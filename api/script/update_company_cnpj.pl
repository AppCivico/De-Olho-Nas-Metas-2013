use lib './lib';
use utf8;
use SMM::Schema;
use lib "$Bin/../files";

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my @budgets = $schema->resultset('Budget')->all;

for my $b (@budgets) {
    use DDP;
    my $comp =
      $schema->resultset('Company')
      ->search( { name_url => $b->business_name_url } )
      ->update( { cnpj => $b->cnpj } );
    p $schema->resultset('Company')
      ->search( { name_url => $b->business_name_url } )->next;
    p $comp;
}
