use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::Admin::Goal;

ok( request('/admin/goal')->is_success, 'Request should succeed' );
done_testing();
