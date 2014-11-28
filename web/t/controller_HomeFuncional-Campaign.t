use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Campaign;

ok( request('/homefuncional/campaign')->is_success, 'Request should succeed' );
done_testing();
