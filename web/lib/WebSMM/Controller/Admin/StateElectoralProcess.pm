package WebSMM::Controller::Admin::StateElectoralProcess;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('state_electoral_process') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $org = $c->stash->{organizations};

    if ($org) {
        $api->stash_result(
            $c,
            'electoral_regional_courts',
            params => {
                order    => 'state.name',
                state_id => $org->[0]{city}{state}{id}
            }
        );
    }
    else {
        $api->stash_result(
            $c,
            'electoral_regional_courts',
            params => {
                order => 'state.name',
            }
        );
    }

    $c->stash->{select_spe} = [ map { [ $_->{id}, $_->{state}{name} ] }
          @{ $c->stash->{electoral_regional_courts} } ];
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'state_electoral_processes', $id ],
        stash => 'sep_obj'
    );

}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $item_per_page = 10;
    my $page = $c->req->params->{page} || 1;

    my $org = $c->stash->{organizations};

    if ( $c->req->params->{name} ) {
        my @fields;
        my $params = { %{ $c->req->params } };

        $c->stash->{name} = $c->req->params->{name};

        $api->stash_result(
            $c,
            'state_electoral_processes',
            params => {
                name => $params->{name} ? $params->{name} : undef,
                page => $page,

                #                 order			=> 'electoral_regional_court.state.name',
                org_state_id => $org ? $org->[0]{city}{state}{id} : undef
            }
        );
    }
    else {
        $api->stash_result(
            $c,
            'state_electoral_processes',
            params => {
                page => $page,

                #                 order			=> 'electoral_regional_court.state.name',
                org_state_id => $org ? $org->[0]{city}{state}{id} : undef
            }
        );
    }

    $c->stash->{count_partial} =
      scalar keys $c->stash->{state_electoral_processes};
    $c->stash->{total}   = $c->stash->{count};
    $c->stash->{results} = $c->stash->{state_electoral_processes};

    $c->stash(
        current_page  => $page,
        item_per_page => $item_per_page
    );

    $c->stash->{pag_req} = $c->req;
    $c->stash->{total_pages} =
      int( ceil( $c->stash->{total} / $c->stash->{item_per_page} ) );

    $c->stash->{previous_page} = ( $page > 1 ) ? $page - 1 : '';
    $c->stash->{next_page} =
      ( $page < $c->stash->{total_pages} ) ? $page + 1 : '';
    $c->stash->{first_page} = ( $page == 1 ) ? '' : 1;
    $c->stash->{last_page} =
      ( $page >= $c->stash->{total_pages} ) ? '' : $c->stash->{total_pages};
}

sub add : Chained('base') : PathPart('new') : Args(0) {
}

sub edit : Chained('object') : PathPart('') : Args(0) {
}

__PACKAGE__->meta->make_immutable;

1;
