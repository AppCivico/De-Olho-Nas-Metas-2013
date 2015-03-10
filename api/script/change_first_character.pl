#!/usr/bin/perl
use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use DDP;
use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

my ( $sigla, $name) = split(';',$_);

my @subpref = $schema->resultset('Subprefecture')->all;

for my $x (@subpref){
	print lc($x->name)."\n";
	my @work_split = split (/\//,$x->name) if $x->name =~ /\//;	
	my $work;
	my @words;
	p @work_split;
	if ((scalar @work_split) > 0){
		for my $w (@work_split){
		 @words = join " " , map{ ucfirst $_ } split(/\s+/, lc($w));
		}
		p @words;
	warn "lol";
	}
	#my $word = join " " , map{ ucfirst $_ } split(/\s+/, lc($x->name));
	#print "name: $word\n";
#	$schema->resultset('Subprefecture')->search({ id => $x->id})->update( {name => $word});
}
