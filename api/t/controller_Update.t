use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SMM';
use SMM::Controller::Update;

ok( request('/update')->is_success, 'Request should succeed' );
done_testing();
