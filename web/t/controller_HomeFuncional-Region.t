use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Region;

ok( request('/homefuncional/region')->is_success, 'Request should succeed' );
done_testing();
