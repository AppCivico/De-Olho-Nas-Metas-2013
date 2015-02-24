use utf8;
use FindBin qw($Bin);
use lib "$Bin/../../lib";

use SMM::Test::Further;

db_transaction {

    rest_get '/projects'

};

done_testing;
