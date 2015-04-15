use lib './lib';
use utf8;
use SMM::Schema;
use lib "$Bin/../files";
use Text::Unidecode;
use String::Util qw/trim/;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

open my $fh, '<', 'data/distritos.txt' or die "nao abriu";

for my $row (<$fh>) {
    $row = trim($row);

    $row_change = $row;
    $row_change = unidecode($row_change);
    print $row_change, "\n";

    my $region =
      $schema->resultset('Region')->search( { name => $row_change } )
      ->update( { name => $row } );
    use DDP;
    p $region;
}
