#!/usr/bin/perl
use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;
use DDP;
use Catalyst::Test q(SMM);
use Text2URI;

my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);


my @budgets = $schema->resultset('Budget')->all;
my $t = new Text2URI();

for my $b (@budgets){

	my $b_name_url = $t->translate($b->business_name);
	use DDP; p $b_name_url;
	$schema->resultset('Budget')->search({ id => $b->id})->update( {business_name_url => $b_name_url});
}
