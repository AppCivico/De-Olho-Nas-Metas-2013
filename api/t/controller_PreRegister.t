use strict;
use warnings;
use Test::More;

use Catalyst::Test 'SMM';
use SMM::Controller::PreRegister;

ok( request('/preregister')->is_success, 'Request should succeed' );
done_testing();
