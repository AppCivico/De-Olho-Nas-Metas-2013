package WebSMM::Controller::Admin::Preuser;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('pre-user') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
		$c, ['pre_registrations', $id],
		stash => 'preuser_obj'
    );
    
    my $d = $c->stash->{preuser_obj};
    use DDP; p $d;

    $c->detach( '/form/not_found', [] ) if $c->stash->{preuser_obj}{error};
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api     = $c->model('API');
    my $form    = $c->model('Form');
    
    my $item_per_page 	= 10;
	my $page 			= $c->req->params->{page} || 1;

    if($c->req->params->{start} || $c->req->params->{end}) {
        my @fields;
        my $params = { %{ $c->req->params } };

        $c->stash->{start}  = $c->req->params->{start};
        $c->stash->{end}    = $c->req->params->{end};

        push(@fields, 'start','end');

        $form->format_date($params, @fields);

        $api->stash_result(
            $c, 'pre_registrations',
            params => {
                end     => $params->{end} ? $params->{end}.' 23:59:59' : undef,
                start   => $params->{start} ? $params->{start}.' 00:00:00' : undef,
                filters => 1,
                page	=> $page,
                order	=> $c->req->params->{order}
            }
        );
    } else {
        $api->stash_result(
            $c, 'pre_registrations',
            params => {
                filters => 1,
                page	=> $page,
                order	=> $c->req->params->{order}
            }
        );
    }
    
    $c->stash->{count_partial} 	= scalar keys $c->stash->{pre_registrations};
	$c->stash->{total}   		= $c->stash->{count};
	$c->stash->{results} 		= $c->stash->{pre_registrations};

	$c->stash(
		current_page  => $page,
		item_per_page => $item_per_page
	);

	$c->stash->{pag_req}     = $c->req;
	$c->stash->{total_pages} = int( ceil( $c->stash->{total} / $c->stash->{item_per_page} ) );

	$c->stash->{previous_page} = ( $page > 1 )                         ? $page - 1 : '';
	$c->stash->{next_page}     = ( $page < $c->stash->{total_pages} )  ? $page + 1 : '';
	$c->stash->{first_page}    = ( $page == 1 )                        ? ''        : 1;
	$c->stash->{last_page}     = ( $page >= $c->stash->{total_pages} ) ? ''        : $c->stash->{total_pages};
}

sub profile : Chained('object') : PathPart('profile') : Args(0) { 
}

__PACKAGE__->meta->make_immutable;

1;