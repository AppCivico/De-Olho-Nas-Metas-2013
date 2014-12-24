use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Geo::Google::PolylineEncoder;
use Geo::CEP;
use Catalyst::Test q(SMM);
use WWW::Correios::CEP;

my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);



my $cepper = WWW::Correios::CEP->new;
my $address = $cepper->find( 11674400 );

use DDP;
p $address;
