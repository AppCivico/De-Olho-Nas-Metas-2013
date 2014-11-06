use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::Download;

ok( request('/download')->is_success, 'Request should succeed' );
done_testing();
