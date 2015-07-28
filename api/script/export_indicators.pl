use lib './lib';
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Spreadsheet::XLSX;
use DDP;
use Moose;
use Text::CSV;

use Catalyst::Test q(SMM);
my $config = SMM->config;
my $model  = SMM::Model::File::XLSX->new();

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password},
    {
        quote_char => q{"},
        name_sep   => q{.}

    }
);

#my $excel = Spreadsheet::XLSX->new( $ARGV[0] );
my $csv =
  Text::CSV->new( { binary => 1, eol => $/, sep_char => q/;/ }
  )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

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
eval {
    $schema->txn_do(
        sub {
            my @user_session = $schema->resultset('UserSession')->search->all;

            my @login_counsil = $schema->resultset('UserSession')->search(
                {
                    '-or' => [
                        'role.name' => 'counsil',
                        'role.name' => 'counsil_master'
                    ]
                },
                {
                    prefetch => { 'user' => { 'user_roles' => 'role' } },
                    result_class => 'DBIx::Class::ResultClass::HashRefInflator'
                }
            )->all;

#            my @login_counsil =
#              $schema->resultset('UserSession')
#              ->search( \['ts_created::date = current_date'] )->search_rs(
#                {
#
#                    '-or' => [
#                        'role.name' => 'counsil',
#                        'role.name' => 'counsil_master'
#                      ]
#
#                },
#                {
#                    prefetch => { 'user' => { 'user_roles' => 'role' } },
#                    result_class => 'DBIx::Class::ResultClass::HashRefInflator'
#                }
#              )->all;

            my $project_follow = $schema->resultset('UserFollowProject')->count;

            my $counsil_follow = $schema->resultset('UserFollowCounsil')->count;

            use DDP;

            my $quantity_login;
            for my $key (@login_counsil) {
                my $date = ( split( q/ /, $key->{ts_created} ) )[0];

                push @{ $quantity_login->{$date} }, $key;

            }

            open my $fh, ">:encoding(utf8)", "new.csv" or die "new.csv: $!";
            my @lines;

            $csv->print(
                $fh,
                [
                    'Data',
                    'Login Conselheiro',
                    'Seguidores dos Projetos',
                    'Seguidores dos conselhos',
                    'Quantidade total de acessos'
                ]
            );

            for my $dt ( sort { $a cmp $b } keys $quantity_login ) {
                push my @line, $dt, scalar @{ $quantity_login->{$dt} },
                  $project_follow, $counsil_follow, scalar @login_counsil;

                $csv->print( $fh, \@line );
            }

            #p $quantity_login;
            die 'rollback';
        }
    );
};
die $@ unless $@ =~ /rollback/;
