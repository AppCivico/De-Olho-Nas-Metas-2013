use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Management;

ok( request('/homefuncional/management')->is_success, 'Request should succeed' );
done_testing();
