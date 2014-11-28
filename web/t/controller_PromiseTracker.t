use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::PromiseTracker;

ok( request('/promisetracker')->is_success, 'Request should succeed' );
done_testing();
