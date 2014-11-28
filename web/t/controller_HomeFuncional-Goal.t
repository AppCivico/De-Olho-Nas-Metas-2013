use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Goal;

ok( request('/homefuncional/goal')->is_success, 'Request should succeed' );
done_testing();
