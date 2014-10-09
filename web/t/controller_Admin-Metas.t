use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSMM';
use WebSMM::Controller::Admin::Metas;

ok( request('/admin/metas')->is_success, 'Request should succeed' );
done_testing();
