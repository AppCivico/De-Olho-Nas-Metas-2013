use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Geo::Google::PolylineEncoder;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

open my $fh, '<:encoding(utf8)', 'data/subprefeituras_distritos.txt' or die "nao abriu";

while(<$fh>){
	use DDP;
	chomp($_);	
	my ( $cddist, $dist, $cd_sub, $sig_sub, $subp ) = split(';',$_);
	my $subpref = $schema->resultset('Subprefecture')->search({ name => { like => $subp}})->next;
	my $reg = $schema->resultset('Region')->search({  name => { like => $dist }})->next;
	
	$schema->resultset('Region')->find($reg->id)->update({ subprefecture_id => $subpref->id }) if $reg and $subpref;
}
