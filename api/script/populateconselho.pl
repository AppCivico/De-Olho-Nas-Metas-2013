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

open my $fh, '<:encoding(utf8)', 'data/subprefeituras.txt' or die "nao abriu";

while(<$fh>){
	chomp($_);	
	my ( $sigla, $name) = split(';',$_);
	my $region = $schema->resultset('Subprefecture')->search({ name => { ilike => $name} },{ rows => 1})->next;

	$schema->resultset('Organization')->create({
		name    => uc($name),
		city_id => 1,
	    subprefecture_id => $region ? $region->id : undef 	
	});
}
