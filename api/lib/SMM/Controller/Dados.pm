
=head1 Download de dados do SMM

=head2 Descrição

As tabelas estao disponveis pelas seguintes URLs:

tipo = csv | json | xml

=cut

package SMM::Controller::Dados;
use Moose;
BEGIN { extends 'Catalyst::Controller::REST' }
__PACKAGE__->config( default => 'application/json' );

use utf8;
use File::Basename;
use JSON;
use Text::CSV_XS;
use Spreadsheet::WriteExcel;
use XML::Simple qw(:strict);
use Digest::MD5;
use DateTime::Format::Pg;

sub base : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub _loc_str {
    my ( $self, $c, $str ) = @_;

    return $str if !defined $str || $str eq '';
    return $str unless $str =~ /[A-Za-z]/o;
    return $str if $str =~ /CONCATENAR/o;
    return $str if $str =~ /^\s*$/o;
    return $str if $str =~ /:\/\//o;

    return $str;
}

# download de todos os endpoints caem aqui
sub _download : Chained('base') PathPart('download') : Args(1) {
    my ( $self, $c, $ff ) = @_;

    use DDP;
    $c->detach
      unless $ff =~
      m/meta|empresa|projeto|objetivo|conselho|subprefeitura|orcamento|distrito/;
    my $path = ( $c->config->{downloads}{tmp_dir} || '/tmp' ) . '/' . lc $ff;

    if ( -e $path ) {

        # apaga o arquivo caso passe 12 horas
        my $epoch_timestamp = ( stat($path) )[9];
        unlink($path) if time() - $epoch_timestamp > 60;
    }
    $self->_download_and_detach( $c, $path ) if -e $path;

    my ( $tabela, $formato ) = ( split( /\./, $ff ) );

    $c->stash->{type} = $formato;

    my @lines = $self->_define_lines( $c, $tabela );

    eval { $self->lines2file( $c, $path, \@lines ) };

    if ($@) {
        $path =~ s/\.check//;
        unlink($path);
        $path .= '.check';
        unlink($path);
        die $@;
    }

    #$self->_download_and_detach( $c, $path ) if -e $path;

    #eval { $self->lines2file( $c, $path, \@lines ) };
    #if ($@) {
    #    $path =~ s/\.check//;
    #    unlink($path);
    #    $path .= '.check';
    #    unlink($path);
    #    die $@;
    #}
    $self->_download_and_detach( $c, $path );
}

sub _period_pt {
    my ( $self, $period ) = @_;

    return 'semanal' if $period eq 'weekly';
    return 'mensal'  if $period eq 'monthly';
    return 'anual'   if $period eq 'yearly';
    return 'decada'  if $period eq 'decade';
    return 'diario'  if $period eq 'daily';

    return $period;    # outros nao usados
}

sub _define_lines {
    my ( $self, $c, $company ) = @_;
    my $db;
    my @lines;
    use DDP;

    my $data_rs;
    if ( $company eq 'meta' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID da meta',
                'Nome',
                'Descrição',
                'Orçamento esperado',
                'Número da meta',
                'Data de atualização',
                'Data esperada para início',
                'Data esperada para termino',
                'Será entregue',
                'Transversalidade',
                'Progresso Qualitativo 1',
                'Progresso Qualitativo 2',
                'Progresso Qualitativo 3',
                'Progresso Qualitativo 4',
                'Progresso Qualitativo 5',
                'Progresso Qualitativo 6',
            ]
        );

        $data_rs = $c->model('DB::Goal')->search(
            undef,
            {

                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id},
                $self->_loc_str( $c, $data->{name} ),
                $self->_loc_str( $c, $data->{description} ),
                $data->{expected_budget},
                $data->{goal_number},
                $data->{updated_at},
                $data->{expected_start_date},
                $data->{expected_end_date},
                $self->_loc_str( $c, $data->{will_be_delivered} ),
                $self->_loc_str( $c, $data->{transversality} ),
                $self->_loc_str( $c, $data->{qualitative_progress_1} ),
                $self->_loc_str( $c, $data->{qualitative_progress_2} ),
                $self->_loc_str( $c, $data->{qualitative_progress_3} ),
                $self->_loc_str( $c, $data->{qualitative_progress_4} ),
                $self->_loc_str( $c, $data->{qualitative_progress_5} ),
                $self->_loc_str( $c, $data->{qualitative_progress_6} ),
            );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'projeto' ) {
        $db    = 'Project';
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID do projeto',
                'Nome',
                'latitude',
                'longitude',
                'Número do Projeto',
                'Progresso Qualitativo 1',
                'Progresso Qualitativo 2',
                'Progresso Qualitativo 3',
                'Progresso Qualitativo 4',
                'Progresso Qualitativo 5',
                'Progresso Qualitativo 6',
                'Porcentagem',
                'Data de Atualização',
            ]
        );
        $data_rs = $c->model('DB::Project')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id},
                $data->{name},
                $data->{latitude},
                $data->{longitude},
                $data->{project_number},
                $data->{qualitative_progress_1},
                $data->{qualitative_progress_2},
                $data->{qualitative_progress_3},
                $data->{qualitative_progress_4},
                $data->{qualitative_progress_5},
                $data->{qualitative_progress_6},
                $data->{percentage},
                $data->{updated_at},
            );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'objetivo' ) {
        $db    = 'Objective';
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID do Objetivo',
                'Nome', 'Data de Atualização',
            ]
        );
        $data_rs = $c->model('DB::Objective')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = ( $data->{id}, $data->{name}, $data->{updated_at}, );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'empresa' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID da empresa',
                'Nome', 'Url do nome',
            ]
        );
        $data_rs = $c->model('DB::Company')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = ( $data->{id}, $data->{name}, $data->{name_url}, );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'orcamento' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID do orçamento',
                'Nome da empresa',
                'CNPJ',
                'Número da meta',
                'Valor Dedicado',
                'Valor liquidado',
                'Observação',
                'Código de contrato',
                'Código da organização',
                'Nome da organização',
                'Id da empresa',
                'Data de atualização',
            ]
        );
        $data_rs = $c->model('DB::Budget')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id},              $data->{business_name},
                $data->{cnpj},            $data->{goal_number},
                $data->{dedicated_value}, $data->{liquidated_value},
                $data->{observation},     $data->{contract_code},
                $data->{organ_code},      $data->{organ_name},
                $data->{company_id},      $data->{updated_at},
            );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'conselho' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID do conselho',
                'Nome do conselho',
                'Descrição',
                'Telefone',
                'Endereço',
                'Código postal',
                'Site',
            ]
        );
        $data_rs = $c->model('DB::Organization')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id}, $data->{name},
                $data->{description}, $data->{phone},
                $data->{address}, $data->{postal_code}, $data->{website},
            );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'distrito' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID do distrito',
                'Nome do distrito',
                'Latitude',
                'Longitude',
                'Coordenadas Geométricas',
            ]
        );
        $data_rs = $c->model('DB::Region')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id},   $data->{name}, $data->{lat},
                $data->{long}, $data->{geom},
            );

            push @lines, \@this_row;
        }

    }
    elsif ( $company eq 'subprefeitura' ) {
        @lines = (
            [
                map { $self->_loc_str( $c, $_ ) } 'ID da subprefeitura',
                'Nome da subprefeitura',
                'Endereço',
                'E-mail',
                'Site',
                'Telefone',
                'Subprefeito',
                'Latitude',
                'Longitude',
            ]
        );
        $data_rs = $c->model('DB::Subprefecture')->search(
            undef,
            {
                result_class => 'DBIx::Class::ResultClass::HashRefInflator'
            }
        );
        while ( my $data = $data_rs->next ) {
            my @this_row = (
                $data->{id},           $data->{name},
                $data->{address},      $data->{email},
                $data->{site},         $data->{telephone},
                $data->{deputy_mayor}, $data->{latitude},
                $data->{longitude},
            );

            push @lines, \@this_row;
        }

    }

    return @lines;
}

sub ymd2dmy {
    my ( $self, $str ) = @_;
    return "$3/$2/$1" if ( $str =~ /(\d{4})-(\d{2})-(\d{2})/ );
    return '';
}

sub lines2file {
    my ( $self, $c, $path, $lines ) = @_;

    $path =~ s/\.check//;
    warn 1;
    open my $fh, ">:encoding(utf8)", $path or die "$path: $!";
    if ( $path =~ /csv$/ ) {
        my $csv =
          Text::CSV_XS->new( { sep_char => ';', binary => 1, eol => "\r\n" } )
          or die "Cannot use CSV: " . Text::CSV_XS->error_diag();

        $csv->print( $fh, $_ ) for @$lines;

    }
    elsif ( $path =~ /json$/ ) {
        binmode($fh);
        print $fh encode_json($lines);
    }
    elsif ( $path =~ /xml$/ ) {
        binmode($fh);

        print $fh XMLout( $lines, KeyAttr => { server => 'linhas' } );

    }
    elsif ( $path =~ /xls$/ ) {
        binmode($fh);
        my $workbook = Spreadsheet::WriteExcel->new($fh);

        # Add a worksheet
        my $worksheet = $workbook->add_worksheet();

        #  Add and define a format
        my $bold = $workbook->add_format();    # Add a format
        $bold->set_bold();

        # Write a formatted and unformatted string, row and column notation.
        my $total = @$lines;

        for ( my $row = 0 ; $row < $total ; $row++ ) {

            if ( $row == 0 ) {
                $worksheet->write( $row, 0, $lines->[$row], $bold );
            }
            else {
                my $total_col = @{ $lines->[$row] };
                for ( my $col = 0 ; $col < $total_col ; $col++ ) {
                    my $val = $lines->[$row][$col];

                    if ( $val && $val =~ /^\=/ ) {
                        $worksheet->write_string( $row, $col, $val );
                    }
                    else {
                        $worksheet->write( $row, $col, $val );
                    }
                }
            }
        }

    }
    else {
        die("not a valid format");
    }
    close $fh or die "$path: $!";

    open( $fh, $path ) or die "Can't open '$path': $!";
    binmode($fh);
    my $md5 = Digest::MD5->new;
    while (<$fh>) {
        $md5->add($_);
    }
    close($fh);

    open $fh, '>', "$path.check" or die "$path: $!";
    print $fh $md5->hexdigest;

}

sub _download_and_detach {
    my ( $self, $c, $path ) = @_;

    if ( $c->stash->{type} =~ /(json)/ ) {
        $c->response->content_type('application/json; charset=UTF-8');
    }
    elsif ( $c->stash->{type} =~ /(xml)/ ) {
        $c->response->content_type('text/xml');
    }
    elsif ( $c->stash->{type} =~ /(csv)/ ) {
        $c->response->content_type('text/csv');
    }
    elsif ( $c->stash->{type} =~ /(xls)/ ) {
        $c->response->content_type('application/vnd.ms-excel');
    }
    $c->response->headers->header(
        'content-disposition' => "attachment;filename=" . basename($path) );

    open( my $fh, '<:raw', $path );
    $c->res->body($fh);

    $c->detach;
}

##################################################
### be happy to read bellow this line!

for my $chain (qw/institute_load network_cidade cidade_regiao/) {
    for my $tipo (qw/csv json xls xml/) {
        eval( "
            sub chain_${chain}_${tipo} : Chained('/$chain') : PathPart('indicadores.$tipo') : CaptureArgs(0) {
                my ( \$self, \$c ) = \@_;
                \$c->stash->{type} = '$tipo';
            }

            sub chain_${chain}_${tipo}_check : Chained('/$chain') : PathPart('indicadores.$tipo.checksum') : CaptureArgs(0) {
                my ( \$self, \$c ) = \@_;
                \$c->stash->{type} = '$tipo.check';
            }

            sub render_${chain}_${tipo} : Chained('chain_${chain}_${tipo}') : PathPart('') : Args(0) {
                my ( \$self, \$c ) = \@_;
                \$self->_download(\$c);
            }

            sub render_${chain}_${tipo}_check : Chained('chain_${chain}_${tipo}_check') : PathPart('') : Args(0) {
                my ( \$self, \$c ) = @_;
                \$self->_download(\$c);
            }
        " );
    }
}

#################

for my $chain (
    qw/network_indicator home_network_indicator cidade_regiao_indicator/)
{
    for my $tipo (qw/csv json xls xml/) {
        eval( "
            sub chain_${chain}_${tipo} : Chained('/$chain') : PathPart('dados.$tipo') : CaptureArgs(0) {
                my ( \$self, \$c ) = \@_;
                \$c->stash->{type} = '$tipo';
            }

            sub chain_${chain}_${tipo}_check : Chained('/$chain') : PathPart('dados.$tipo.checksum') : CaptureArgs(0) {
                my ( \$self, \$c ) = \@_;
                \$c->stash->{type} = '$tipo.check';
            }

            sub render_${chain}_${tipo} : Chained('chain_${chain}_${tipo}') : PathPart('') : Args(0) {
                my ( \$self, \$c ) = \@_;
                \$self->_download(\$c);
            }

            sub render_${chain}_${tipo}_check : Chained('chain_${chain}_${tipo}_check') : PathPart('') : Args(0) {
                my ( \$self, \$c ) = @_;
                \$self->_download(\$c);
            }
        " );
    }
}

1;
