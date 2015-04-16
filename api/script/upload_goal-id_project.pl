use lib './lib';
use utf8;
use SMM::Schema;
use lib "$Bin/../files";
use URI;
use Furl;
use JSON;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my $furl = Furl->new(
    agent   => 'SMM',
    timeout => '100',
);

my @projects =
  $schema->resultset('Project')->search( { goal_id => undef } )->all;

for my $p (@projects) {
    my $url = URI->new('http://planejasampa.prefeitura.sp.gov.br');

    $url->path_segments( 'metas', 'api', 'project', $p->project_number );

    my $res = $furl->get($url);

    use DDP;
    my $json = decode_json( $res->content );

    $p->update( { goal_id => $json->{goal_id} } );
}
