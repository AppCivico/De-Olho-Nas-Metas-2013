use lib './lib';
use utf8;

use SMM::Schema;
use SMM::Test::Further;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Text::CSV;
use DDP;
use List::Util qw/sum/;
use JSON;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $csv = Text::CSV->new(
    { binary => 1, sep_char => ';' } )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

open my $fh, '<:encoding(utf8)', 'data/user_org.csv'
  or die "nao abriu";

my $furl = Furl->new(
    agent   => 'SMM',
    timeout => 100
);

my @rows;
my $data = {};

api_auth_as user_id => 1, roles => ['superadmin'];

while ( my $row = $csv->getline($fh) ) {

my ($nome, $email, $celular, $senha) = split q/,/, $row->[0];

rest_post '/users',
      name  => 'criar usuario',
      list  => 1,
      stash => 'user',
      [
        name             => $nome,
        email            => $email,
        password         => $senha,
        password_confirm => $senha,
        role             => 'counsil_master'
      ];
    stash_test 'user.get', sub {
        my ($me) = @_;
        is( $me->{email}, $email, 'email ok!' );
    };

}

