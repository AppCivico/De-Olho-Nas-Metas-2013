package WebSMM::Controller::Admin::Driver;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('driver') : CaptureArgs(0) {
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api     = $c->model('API');
    my $form    = $c->model('Form');
    
    my $item_per_page 	= 10;
	my $page 			= $c->req->params->{page} || 1;

    if($c->req->params->{start} || $c->req->params->{end} || $c->req->params->{name}) {
        my @fields;
        my $params = { %{ $c->req->params } };

        $c->stash->{start}  = $c->req->params->{start};
        $c->stash->{end}    = $c->req->params->{end};
        $c->stash->{name}	= $c->req->params->{name};

        push(@fields, 'start','end');

        $form->format_date($params, @fields);

        $api->stash_result(
            $c, 'drivers',
            params => {
                end     => $params->{end} ? $params->{end}.' 23:59:59' : undef,
                start   => $params->{start} ? $params->{start}.' 00:00:00' : undef,
                name	=> $params->{name} ? $params->{name} : undef,
                page	=> $page,
                order	=> $c->req->params->{order},
                filters => 1,
            }
        );
    } else {
        $api->stash_result(
            $c, 'drivers',
            params => {
                filters => 1,
                page	=> $page,
                order	=> $c->req->params->{order}
            }
        );
    }
    
    $c->stash->{count_partial} 	= scalar keys $c->stash->{drivers};
	$c->stash->{total}   		= $c->stash->{count};
	$c->stash->{results} 		= $c->stash->{drivers};

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

__PACKAGE__->meta->make_immutable;

1;