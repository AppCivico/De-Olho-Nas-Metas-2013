package WebSMM::Model::File;
use Moose;
BEGIN { extends 'Catalyst::Controller' }
use utf8;
use JSON::XS;
use Spreadsheet::WriteExcel;
use Text::CSV_XS;

sub _loc_str {
    my ( $self, $c, $str ) = @_;

    return $str if !defined $str || $str eq '';
    return $str unless $str =~ /[A-Za-z]/o;
    return $str if $str =~ /CONCATENAR/o;
    return $str if $str =~ /^\s*$/o;
    return $str if $str =~ /:\/\//o;

    return $c->loc($str);
}

# download de todos os endpoints caem aqui
sub _download {
    my ( $self, $c, $name, $data ) = @_;

    my $ignore_cache = 0;

    my $file = $c->get_lang() . '_' . $name . '.';

    # evita conflito com outros usuarios
    $file .= join '-', rand, rand, rand, rand, '.' if $ignore_cache;
    $file .= $c->stash->{type};

    my $path = ( $c->config->{downloads}{tmp_dir} || '/tmp' ) . '/' . lc $file;
    if ( -e $path ) {
        my $epoch_timestamp = ( stat($path) )[9];
        unlink($path) if time() - $epoch_timestamp > 60;
    }

    $self->_download_and_detach( $c, $path, $file )
      if !$ignore_cache && -e $path;
    my @lines = @{ $data->{main} };

    eval { $self->lines2file( $c, $path, \@lines ) };

    if ($@) {
        unlink($path);
        die $@;
    }
    $self->_download_and_detach( $c, $path, $file, $ignore_cache );

    unlink($path) if $ignore_cache;
}

sub lines2file {
    my ( $self, $c, $path, $lines ) = @_;

    open my $fh, ">:encoding(utf8)", $path or die "$path: $!";
    if ( $path =~ /csv$/ ) {
        my $csv = Text::CSV_XS->new( { binary => 1, eol => "\r\n" } )
          or die "Cannot use CSV: " . Text::CSV_XS->error_diag();

        $csv->print( $fh, $_ ) for @$lines;

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

}

sub _download_and_detach {
    my ( $self, $c, $path, $file, $custom ) = @_;
    if ( $c->stash->{type} =~ /(csv)/ ) {
        $c->response->content_type('text/csv');
    }
    elsif ( $c->stash->{type} =~ /(xls)/ ) {
        $c->response->content_type('application/vnd.ms-excel');
    }
    $c->response->headers->header(
        'content-disposition' => "attachment;filename=" . "exemplo-$file" );

    open( my $fh, '<:raw', $path );
    $c->res->body($fh);

    $c->detach;
}

1;
