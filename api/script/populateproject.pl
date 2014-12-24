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

	my $lat  = $prj->latitude;
	my $long = $prj->longitude;
    next if $prj->latitude eq "";	
    next if $prj->longitude eq "";	
    next if $prj->latitude eq 0;	
    p $prj->name;	
	p $prj->id;
	p $prj->latitude;
	p $prj->longitude;
    my @teste = $schema->resultset('Region')->search_rs(
        
            \[
               	q{ST_Intersects(me.geom::geography, ?::geography )},  
                [ _coords => qq{SRID=4326;POINT($long $lat)} ]
            ],
			{
				select => [ qw/id name/],
				result_class => 'DBIx::Class::ResultClass::HashRefInflator',
			}	
    )->all;
    #p $teste[0]->{id};
	$schema->resultset('Project')->find( $prj->id )->update({ region_id => $teste[0]->{id}});
}
