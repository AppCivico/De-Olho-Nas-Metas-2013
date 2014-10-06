use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password}
);

&run_sql( $schema, "$Bin/deploy/before_schema.sql" );
$schema->deploy;
&run_sql( $schema, "$Bin/deploy/after_schema.sql" );

sub run_sql {
    my ( $schema, $name ) = @_;

    $schema->storage->dbh_do(
        sub {
            my ( $storage, $dbh ) = @_;
            local $/;
            my $sql = do { open( my $x, '<:utf8', $name ); <$x> };
            $dbh->do($sql);
        }
    );

}

