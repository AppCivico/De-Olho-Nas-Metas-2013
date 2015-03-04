#!/usr/bin/perl
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

my ( $sigla, $name) = split(';',$_);

my @regions = $schema->resultset('Region')->all;

for my $x (@regions){
	#print lc($x->name)."\n";
	my $word = join " " , map{ ucfirst $_ } split(/\s+/, lc($x->name));

	print "word: $word\n";
		
	$schema->resultset('Region')->search({ id => $x->id})->update( {name => $word});
}
