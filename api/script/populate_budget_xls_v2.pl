use lib './lib';
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Spreadsheet::XLSX;
use DDP;
use Moose;
use Text2URI;

use Catalyst::Test q(SMM);
my $config = SMM->config;
my $model  = SMM::Model::File::XLSX->new();

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $excel = Spreadsheet::XLSX->new( $ARGV[0] );

my %expected_header = (
    Ano_empenho => qr /\b(AnoEmpenho)\b/io,
    cod_orgao   => qr /\bcodorgao\b/io,
    orgao       => qr /\borgao\b/io,

    txt_emp    => qr /\bTxt_Obs_Eph\b/io,
    Nome_razao => qr /\bNom_Rzao_Soci_Sof\b/io,

    total_emp        => qr /\b(Val_tot_eph)\b/io,
    Cod_Cpf_Cnpj_Sof => qr /\b(Cod_Cpf_Cnpj_Sof)\b/io,
    liquidado        => qr /\b(liquidado)\b/io,
    meta_number      => qr /\b(meta_n_c)\b/io,
    code_emp         => qr /\b(Cod_eph)\b/io,
);

my @rows;
my $ok      = 0;
my $ignored = 0;
my $header_found;

my $t = new Text2URI();

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
            $registro->{Nome_razao} =~ s/",;//g;
            $registro->{txt_emp} =~ s/&quot;//g;
            use DDP;
            p $registro;
            warn $registro->{txt_emp};
            $registro->{business_name_url} =
              $t->translate( $registro->{Nome_razao} )
              if $registro->{Nome_razao};

            next unless $registro->{business_name_url};
            if ( $registro->{meta_number} =~ / \// ) {
                warn "entrou";
                my @goals = split qw/\//, $registro->{meta_number};
                for my $v_goal (@goals) {
                    $schema->resultset('Budget')->create(
                        {
                            business_name     => $registro->{Nome_razao},
                            cnpj              => $registro->{Cod_Cpf_Cnpj_Sof},
                            goal_number       => $v_goal,
                            dedicated_value   => $registro->{total_emp},
                            liquidated_value  => $registro->{liquidado},
                            observation       => $registro->{txt_emp},
                            dedicated_year    => $registro->{Ano_empenho},
                            organ_code        => $registro->{cod_orgao},
                            organ_name        => $registro->{orgao},
                            cod_emp           => $registro->{code_emp},
                            business_name_url => $registro->{business_name_url},

                        }
                    );
                }
            }
            else {

                warn "aki";
                $schema->resultset('Budget')->create(
                    {

                        business_name     => $registro->{Nome_razao},
                        cnpj              => $registro->{Cod_Cpf_Cnpj_Sof},
                        goal_number       => $registro->{meta_number},
                        dedicated_value   => $registro->{total_emp},
                        observation       => $registro->{txt_emp},
                        liquidated_value  => $registro->{liquidado},
                        dedicated_year    => $registro->{Ano_empenho},
                        organ_code        => $registro->{cod_orgao},
                        organ_name        => $registro->{orgao},
                        cod_emp           => $registro->{code_emp},
                        business_name_url => $registro->{business_name_url}

                    }
                );
            }
        }
    }
}
warn $@;
die $@ unless $@ =~ /rollback/;
