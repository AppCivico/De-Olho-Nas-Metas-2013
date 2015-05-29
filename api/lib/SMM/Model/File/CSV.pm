package SMM::Model::File::CSV;
use strict;
use Moose;
use utf8;
use DateTime;
use DateTime::Format::Pg;

use Text::CSV_XS;

sub parse {
    my ( $self, %args ) = @_;
	my $file = $args{tempname};
	my $validate = $args{validate};

    my $csv = Text::CSV_XS->new( { binary => 1 } )
      or die "Cannot use CSV: " . Text::CSV_XS->error_diag();
    open my $fh, "<:encoding(utf8)", $file or die "$file: $!";

    my %expected_header = %{$args{header}};
    my @rows;
    my $ok      = 0;
    my $ignored = 0;

    my $header_map   = {};
    my $header_found = 0;

    while ( my $row = $csv->getline($fh) ) {

        my @data = @$row;

        if ( !$header_found ) {

            for my $col ( 0 .. ( scalar @data - 1 ) ) {
                my $cell = $data[$col];
                next unless $cell;

                foreach my $header_name ( keys %expected_header ) {

                    if ( $cell =~ $expected_header{$header_name} ) {
                        $header_found++;
                        $header_map->{$header_name} = $col;
                    }
                }
            }
        }
        else {

# aqui você pode verificar se foram encontrados todos os campos que você precisa
# neste caso, achar apenas 1 cabeçalho já é o suficiente

            my $registro = {};

            foreach my $header_name ( keys %$header_map ) {
                my $col = $header_map->{$header_name};

                my $value = $data[$col];

# aqui é uma regra que você escolhe, pois as vezes o valor da célula pode ser nulo
                next if !defined $value || $value =~ /^\s*$/;
                $value =~ s/^\s+//;
                $value =~ s/\s+$//;
                $registro->{$header_name} = $value;
            }
			my $teste = $validate->($registro);
			warn $teste;
            if ($teste) {

                $ok++;

                push @rows, $registro;

            }
            else {
                $ignored++;
            }

        }
    }
    $csv->eof or $csv->error_diag();
    close $fh;

    return {
        rows         => \@rows,
        ignored      => $ignored,
        ok           => $ok,
        header_found => !!$header_found
    };
}

1;
