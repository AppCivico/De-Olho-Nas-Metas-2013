use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Region::ID;

ok( request('/homefuncional/region/id')->is_success, 'Request should succeed' );
done_testing();
