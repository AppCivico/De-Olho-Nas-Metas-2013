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
      $schema->resultset('Company')->search( { name => $b->business_name } )
      ->next;
    warn $b->business_name;

    my $bud = $schema->resultset('Company')->create(
        {
            name     => $b->business_name,
            name_url => $b->business_name_url,
            goal_id  => $b->goal_number
        }
    ) unless $comp;

    if ($bud) {
        $b->update( { company_id => $bud->id } );

    }
    else {
        $b->update( { company_id => $comp->id } );
    }
}
