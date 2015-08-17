use lib './lib';
use strict;
use warnings;
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use DDP;
use Moose;
use Text2URI;
use Text::CSV_XS;
use Catalyst::Test q(SMM);

my $config = SMM->config;
my $model  = SMM::Model::File::CSV->new();

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);
my @rows;
my $ok      = 0;
my $ignored = 0;

my $header_map   = {};
my $header_found = 0;

$schema->txn_do(
    sub {

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

        my $file = $ARGV[0];

        my $csv = Text::CSV_XS->new( { binary => 1, sep_char => ';' } )
          or die "Cannot use CSV: " . Text::CSV_XS->error_diag();
        open my $fh, "<:encoding(utf8)", $file or die "$file: $!";

        my $t = new Text2URI();
        while ( my $row = $csv->getline($fh) ) {
            warn 'lol';
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
                p $header_map;
            }
            else {
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
                my $budget = $schema->resultset('Budget')->search(
                    {
                        cod_emp        => $registro->{code_emp},
                        dedicated_year => $registro->{Ano_empenho}
                    }
                )->next;
                if ($budget) {
                    $budget->update(
                        {
                            business_name    => $registro->{Nome_razao},
                            dedicated_value  => $registro->{total_emp},
                            liquidated_value => $registro->{liquidado},
                            observation      => $registro->{txt_emp},
                            dedicated_year   => $registro->{Ano_empenho},
                            updated_at       => \"now()"

                        }
                    );
                }

                p $registro;
            }
        }

    }
);
