package SMM::Model::File;
use Moose;
use utf8;
use JSON qw/encode_json/;

use SMM::Model::File::XLSX;
use SMM::Model::File::XLS;
use SMM::Model::File::CSV;

sub process {
    my ( $self, %param ) = @_;

    my $upload = $param{upload};
    my $schema = $param{schema};
    my %header = %{ $param{header} };
    my $parse;
    eval {
        if ( $upload->filename =~ /xlsx$/ ) {
            $parse =
              SMM::Model::File::XLSX->new->parse( $upload->tempname, %header );
        }
        elsif ( $upload->filename =~ /xls$/ ) {
            $parse =
              SMM::Model::File::XLS->new->parse( $upload->tempname, %header );
        }
        elsif ( $upload->filename =~ /csv$/ ) {
            $parse =
              SMM::Model::File::CSV->new->parse( $upload->tempname, %header );
        }
    };
    die $@ if $@;
    die "file not supported!\n" unless $parse;
    my $status = $@ ? $@ : '';

    $status .= 'Linhas aceitas: ' . $parse->{ok} . "\n";
    $status .= 'Linhas ignoradas: ' . $parse->{ignored} . "\n"
      if $parse->{ignored};
    $status .= "Cabeçalho não encontrado!\n" unless $parse->{header_found};

    use DDP;
    p $parse;
    exit;
    my $file_id;

    # se tem menos variaveis no banco do que as enviadas

    my $user_id = $param{user_id};
    my $file    = $schema->resultset('File')->create(
        {
            name        => $upload->filename,
            status_text => $status,
            created_by  => $user_id
        }
    );
    $file_id = $file->id;

    my $rvv_rs = $schema;

    $schema->txn_do(
        sub {
            my $with_region    = {};
            my $without_region = {};
            my $cache_ref      = {};

            # percorre as linhas e insere no banco
            # usando o modelo certo.
            my $c = 0;

            foreach my $r ( @{ $parse->{rows} } ) {
                $c++;

                my $old_value = $r->{value};

                if ( !defined $r->{value} ) {
                    $status =
"Valor '$old_value' não é um número válido [registro número $c]. Por favor, envie formatado corretamente.";

                    #  die "invalid number";
                }

                my $ref = {
                    do_not_calc => 1,
                    cache_ref   => $cache_ref
                };
                $ref->{variable_id} = $r->{id};

                $status .= "$@" if $@;
                die $@ if $@;
            }
            my $data = Iota::IndicatorData->new( schema => $schema->schema );
            if ( exists $with_region->{dates} ) {
                $data->upsert(
                    indicators => [
                        $data->indicators_from_variables(
                            variables => [ keys %{ $with_region->{variables} } ]
                        )
                    ],
                    dates      => [ keys %{ $with_region->{dates} } ],
                    regions_id => [ keys %{ $with_region->{regions} } ],
                    user_id    => $user_id
                );
            }
            if ( exists $without_region->{dates} ) {
                $data->upsert(
                    indicators => [
                        $data->indicators_from_variables(
                            variables =>
                              [ keys %{ $without_region->{variables} } ]
                        )
                    ],
                    dates   => [ keys %{ $without_region->{dates} } ],
                    user_id => $user_id
                );
            }

        }
    );
    $file->update( { status_text => $status } );

    return {
        status  => $status,
        file_id => $file_id
    };

}

sub process_to_create {
    my ( $self, %param ) = @_;

    my $upload = $param{upload};
    my $schema = $param{schema};

    my $create;
    eval {
        if ( $upload->filename =~ /xlsx$/ ) {
            $create = SMM::Model::File::XLSX->new->create();
        }
        elsif ( $upload->filename =~ /xls$/ ) {
            $create = SMM::Model::File::XLS->new->create();
        }
        elsif ( $upload->filename =~ /csv$/ ) {
            $create = SMM::Model::File::CSV->new->create();
        }
    };
    die $@ if $@;
    die "file not supported!\n" unless $create;

    my $status = $@ ? $@ : '';
}

sub _verify_variable_type {
    my ( $self, $value, $type ) = @_;

    return $value if $type eq 'str';

    # certo, entao agora o type é int ou num.

    # vamos tratar o caso mais comum, que é [0-9]{1,3}\.[0-9]{1,3},[0-9]
    if ( $value =~ /[0-9]{1,3}\.[0-9]{1,3},[0-9]{1,9}$/ ) {
        $value =~ s/\.//g;
        $value =~ s/,/./;
    }

    # valores só com virgula.. eh . no banco..
    elsif ( $value =~ /^[0-9]{1,15},[0-9]{1,9}$/ ) {

        $value =~ s/,/./;
    }

    # e agora o inverso... usou , e depois um .
    elsif ( $value =~ /[0-9]{1,3}\,[0-9]{1,3}.[0-9]{1,9}$/ ) {
        $value =~ s/,//g;
        $value =~ s/\./,/;
    }

    # se parece com numero ?
    if (   $value =~ /^[0-9]{1,15}\.[0-9]{1,9}$/
        || $value =~ /^[0-9]{1,15}$/ )
    {

        $value = int($value) if $type eq 'int';

        return $value;
    }

    # retorna undef.
    undef();
}

1;
