use strict;
use warnings;
use Test::More;

use Catalyst::Test 'SMM';
use SMM::Controller::API::Project;

ok( request('/api/project')->is_success, 'Request should succeed' );
done_testing();
