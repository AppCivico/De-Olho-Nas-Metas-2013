use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Geo::Google::PolylineEncoder;
use Spreadsheet::Read;
use Data::Printer;
use Spreadsheet::ParseExcel::Stream;
use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);


open my $fh, '<:encoding(utf8)', 'data/new_info_subprefecture.txt' or die "nao abriu";

while(<$fh>){
	
	my ( $subprefeitura, $subprefeito, $site, $email , $telefone , $endereco) = split(';',$_);
	$schema->resultset('Subprefecture')->search({ name  => { ilike => '%'.$subprefeitura.'%' } })->update({ email => $email});
}
