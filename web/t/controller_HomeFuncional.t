use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional;

ok( request('/homefuncional')->is_success, 'Request should succeed' );
done_testing();
