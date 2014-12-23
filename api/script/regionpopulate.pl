use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use Geo::Google::PolylineEncoder;
use XML::Simple qw(:strict);
use Geo::Converter::WKT2KML;
use Geo::WKT::Simple;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

use DDP;

#my $encoder = Geo::Google::PolylineEncoder->new;
my $xs = XML::Simple->new( KeyAttr => { Placemark => 'id' } );

my $ref = $xs->XMLin( 'files/regions3.kml', ForceArray => 1 );

#print p $ref->{Document}[0]->{Folder}[0]->{Placemark};
my %data;

for my $key (
    sort { $a cmp $b }
    keys( $ref->{Document}[0]->{Folder}[0]->{Placemark} )
  )
{
    $data{ $ref->{Document}[0]->{Folder}[0]->{Placemark}->{$key}->{name}[0] } =
      $ref->{Document}[0]->{Folder}[0]->{Placemark}->{$key}->{MultiGeometry}[0]->{Polygon}[0]->{outerBoundaryIs}[0]->{LinearRing}[0]->{coordinates}[0] if exists $ref->{Document}[0]->{Folder}[0]->{Placemark}->{$key}->{name}[0];
}
my @vecs;
foreach my $place ( keys %data) {
    my $str = $data{$place};
     
	my $with_zero =
      $str =~ /(?:-?\d+(?:\.\d+)?\,\s?-?\d+(?:\.\d+)?,\d+(?:\.\d+)?)/;
    
	if ($with_zero) {
        $str =~ s/^\s+//;
        $str =~ s/\s+$//;
    }
    my @latlng = split / /o, $str;
    my @pos;
    foreach my $lnt (@latlng) {
        if ($with_zero) {
            $lnt =~ /(.+)\,(.+)\,\d+(?:\.\d+)?/o;
            push @pos, [ $1, $2 ];
        }
        else {
            $lnt =~ /(.+)\,(.+)/o;
            push @pos, [ $1, $2 ];
        }
    }
	p $place unless grep {defined($_)} @pos;

    push @vecs,
      {
        name   => $place,
        latlng => \@pos
      };

}
for ( @vecs){
	my @line;
	for my $lol (@{$_->{latlng}}){
		
		push @line, join (q/ /, $lol->[0], $lol->[1] );
	}
	print "\n$_->{name}\n";
	my $polygon = join (q/,/, @line);

		 $schema->resultset('Region')->create(
			{ geom => \['ST_GeomFromText((?),4326)',
				 [ p => "POLYGON(($polygon))" ]
				],
			  name => $_->{name},
			  lat  => 1,
			  long => 1
			 });

}

