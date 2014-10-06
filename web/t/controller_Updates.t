use strict;
use warnings;
use Test::More;

use Catalyst::Test 'WebSMM';
use WebSMM::Controller::Updates;

ok( request('/updates')->is_success, 'Request should succeed' );
done_testing();
