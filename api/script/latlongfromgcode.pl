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

open my $fh, '<:encoding(utf8)', "files/out.regions.csv" or die "not open file";
use DDP;
my %data;
my $encoder = Geo::Google::PolylineEncoder->new;

while (<$fh>) {
    my @parser_line = split( ',', $_ );

    my $point = $encoder->decode_points( $parser_line[10] );
    #	p $point;
    $data{ $parser_line[1] } =
      { compact => $point, lat => $parser_line[16], long => $parser_line[17], name => $parser_line[1] };

}
my @array;

for my $key (%data) {
    for my $data ( $data{$key} ) {
		@array = ();
        for my $linestring ( @{ $data{$key}{compact} } ) {
			my $locale = join (" ",$linestring->{lon},$linestring->{lat});
            push( @array, $locale ) if $locale =~ qr/^(\-?\d+(\.\d+)?)\ \s*(\-?\d+(\.\d+)?)$/;
        }
		 next if scalar @array eq 0;
		 my $join_locale = join (',',@array);
		 $schema->resultset('Region')->create( 
			{ geom => \['ST_GeomFromText((?),4326)',
				 [ p => "LINESTRING($join_locale)" ]
				],
			  name => $data{$key}{name},
			  lat  => $data{$key}{lat},
			  long => $data{$key}{long}
			 });
    }
}

# $region_rs->search_rs(
#    {
#        -and => [
#            \[q{ST_Intersects(me.geom::geography, ?::geography )}],
#            [ _coords => qq{SRID=4326;POINT($long $lat )} ]
#        ]
#    },
#    {
#        select => [ \'ST_AsKML(me.geom) as kml' ],
#        as     => [qw(kml)]
#    }
#);

#	$schema->resultset('Region')->create(
#		name =>
#	);
#	INSERT INTO mytable (geom) VALUES (
# 		ST_GeomFromText('POINT(0 0)', 26910)
#	);

