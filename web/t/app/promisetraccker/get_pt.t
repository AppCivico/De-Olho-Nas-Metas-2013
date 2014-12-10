use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;
use JSON;
use LWP::UserAgent;
use HTTP::Request;

use Catalyst::Test 'WebSMM';
use WebSMM::Controller::PromiseTracker::Campaign;
my $ua = LWP::UserAgent->new;
{
	my $res = $ua->request(GET 'http://dev.monitor.promisetracker.org/api/v1/campaigns', Authorization => 'Token token=c687bd99026769a662e9fc84f5c4e201'  );
	warn $res->as_string;

	is( $res->status_line ,'200 OK', 'GET Promise tracker OK' );	
	ok( my $json = decode_json $res->content, 'JSON OK' );	
}
		
{			
	my $res = $ua->request(GET 'http://dev.monitor.promisetracker.org/api/v1/campaigns/86', Authorization => 'Token token="c687bd99026769a662e9fc84f5c4e201');
	warn $res->as_string;
	is( $res->status_line ,'200 OK', 'GET Promise tracker OK - Select Campaign' );	
	ok( my $json = decode_json $res->content, 'JSON OK' );	
}
		
done_testing();

