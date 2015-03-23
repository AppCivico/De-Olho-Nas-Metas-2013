use lib './lib';
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
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
    timeout => 100
);

my $url = URI->new("http://planejasampa.prefeitura.sp.gov.br/metas/api");

$url->path_segments( 'metas', 'api', 'projects', 'types' );

my $res  = $furl->get( $url->as_string );
my $data = decode_json $res->content;

use DDP;
for my $d ( @{$data} ) {
    $schema->resultset('ProjectType')->create( { name => $d->{name} } );
}

p $res;
$url;
