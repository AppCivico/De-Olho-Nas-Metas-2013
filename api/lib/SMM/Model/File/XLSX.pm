package SMM::Model::File::XLSX;
use strict;
use Moose;
use utf8;
use DateTime;
use DateTime::Format::Pg;

use Spreadsheet::XLSX;
use DateTime::Format::Excel;

use Encode;

sub parse {
    my ( $self, $file ) = @_;

    my $excel = Spreadsheet::XLSX->new($file);

    my %expected_header = (
        Ano_empenho    => qr /\b(AnoEmpenho)\b/io,
        cod_orgao  => qr /\bcodorgao\b/io,
        orgao => qr /\borgao\b/io,

        txt_emp    => qr /\bTxt_Obs_Eph\b/io,
        Nome_razao => qr /\bNom_Rzao_Soci_Sof\b/io,

        total_emp => qr /\b(Val_tot_eph)\b/io,
        Cod_Cpf_Cnpj_Sof => qr /\b(Val_tot_eph)\b/io,
        liquidado => qr /\b(liquidado)\b/io,
        meta_number => qr /\b(meta_n_c)\b/io,
    );

    my @rows;
    my $ok      = 0;
    my $ignored = 0;
    my $header_found;
    for my $worksheet ( @{ $excel->{Worksheet} } ) {

        my ( $row_min, $row_max ) = $worksheet->row_range();
        my ( $col_min, $col_max ) = $worksheet->col_range();

        my $header_map = {};
        $header_found = 0;

        for my $row ( $row_min .. $row_max ) {

            if ( !$header_found ) {
                for my $col ( $col_min .. $col_max ) {
                    my $cell = $worksheet->get_cell( $row, $col );
                    next unless $cell;

                    foreach my $header_name ( keys %expected_header ) {
                        my $cell_Value = $cell->value();
                        utf8::decode($cell_Value);

                        if ( $cell_Value =~ $expected_header{$header_name} ) {
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

                    my $cell = $worksheet->get_cell( $row, $col );
                    next unless $cell;

                    my $value = $cell->value();
                    utf8::decode($value);

                    # aqui é uma regra que você escolhe, pois as vezes o valor da célula pode ser nulo
                    next if !defined $value || $value =~ /^\s*$/;
                    $value =~ s/^\s+//;
                    $value =~ s/\s+$//;
                    $registro->{$header_name} = $value;
                }

            }

        }
    }
    return {
        rows         => \@rows,
        ignored      => $ignored,
        ok           => $ok,
        header_found => !!$header_found
    };
}

1;
