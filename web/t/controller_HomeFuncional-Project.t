use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::HomeFuncional::Project;

ok( request('/homefuncional/project')->is_success, 'Request should succeed' );
done_testing();
