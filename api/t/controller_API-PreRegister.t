use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SMM';
use SMM::Controller::API::PreRegister;

ok( request('/api/preregister')->is_success, 'Request should succeed' );
done_testing();
