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

my @projects = $schema->resultset('Project')
  ->search( {}, { +select => [qw/id name latitude longitude/], } );
for my $prj (@projects) {

    use DDP;

    #my $teste = $schema->resultset('Region')->search(
    #    \[
    #        'ST_Intersects(geom, ST_GeomFromText((POINT(? ?)),4326)::geometry)',
    #        [ p => "-71.06454", 42.28787 ]
    #    ]
    #);
	my $lat  = $prj->latitude;
	my $long = $prj->longitude;	
    p $prj->latitude;
    p $prj->longitude;
    my @teste = $schema->resultset('Region')->search_rs(
        
            \[
               	q{ST_Intersects(me.geom::geography, ?::geography )},  
                [ _coords => qq{SRID=4326;POINT($long $lat)} ]
            ],
			{
				select => [ qw/id name/],
			}	
    )->all
	unless $prj->latitude eq 0 and $prj->longitude eq 0;

    p @teste;

}
