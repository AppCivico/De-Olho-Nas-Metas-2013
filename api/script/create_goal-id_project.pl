use lib './lib';
use utf8;
use SMM::Schema;
use lib "$Bin/../files";
use Text::Unidecode;
use String::Util qw/trim/;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my @projects = $schema->resultset('Project')->search(
    undef,
    {
        join         => { goal_projects => 'goal' },
        columns      => [qw/id name goal.id/],
        result_class => 'DBIx::Class::ResultClass::HashRefInflator',
    }
)->all;
use DDP;

for my $p (@projects) {
    p $p;
    $schema->resultset('Project')->find( $p->{id} )
      ->update( { goal_id => $p->{goal}->{id} } );

}
