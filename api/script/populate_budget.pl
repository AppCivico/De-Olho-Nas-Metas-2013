use lib './lib';
use utf8;
use SMM::Schema;
use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Geo::Google::PolylineEncoder;
use Parse::CSV;


use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

open my $fh, '<', 'data/METAS_TUDO_csv.csv' or die "nao abriu";

my $simple = Parse::CSV->new(
	handle => $fh,
	sep_char => '\r\n',
	
);
use DDP; 
p $simple->fetch;
while( my $row = $simple->fetch ){
		
	use DDP;
#	p $row;

	#$metas[0]  - ano empenho
	#$metas[2]  - código do orgão
	#$metas[3]  - orgão
	#$metas[25] - observação empenho
	#$metas[26] - nome da razão social
	#$metas[27] - total empenhado
	#$metas[28] - CNPJ
	#$metas[33] - total liquidado
	#$metas[35] - numero da meta
	#$metas[35] - numero da meta
#	$schema->resultset('Budget')->create({
#		business_name    => $metas[26],
#		cpnj             => $metas[28],
#		goal_number      => $schema->resultset('Goal')->search({ goal_number => $metas[35]})->next->id,
#		dedicated_value  => $metas[27],
#		liquidated_value => $metas[33],
#		observation      => $metas[25],
#		dedicated_year   => $metas[0],
#		organ_code       => $metas[2],
#		organ_name       => $metas[3]
#
#	});

}
