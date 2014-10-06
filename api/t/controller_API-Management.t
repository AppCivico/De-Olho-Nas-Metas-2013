use strict;
use warnings;
use Test::More;

use Catalyst::Test 'SMM';
use SMM::Controller::API::Management;

ok( request('/api/management')->is_success, 'Request should succeed' );
done_testing();
