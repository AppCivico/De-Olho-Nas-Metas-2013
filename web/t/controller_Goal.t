use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::Goal;

ok( request('/goal')->is_success, 'Request should succeed' );
done_testing();
