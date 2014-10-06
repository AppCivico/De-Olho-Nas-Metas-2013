package WebSMM::Controller::Admin::PoliticalParty;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('political_party') :
  CaptureArgs(0) {
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $item_per_page = 10;
    my $page = $c->req->params->{page} || 1;

    if ( $c->req->params->{name} ) {
        my @fields;
        my $params = { %{ $c->req->params } };

        $c->stash->{name} = $c->req->params->{name};

        $api->stash_result(
            $c,
            'political_parties',
            params => {
                name => $params->{name} ? $params->{name} : undef,
                page => $page,
                pagination => 1
            }
        );
    }
    else {
        $api->stash_result(
            $c,
            'political_parties',
            params => {
                page       => $page,
                pagination => 1
            }
        );
    }

    $c->stash->{count_partial} = scalar keys $c->stash->{political_parties};
    $c->stash->{total}         = $c->stash->{count};
    $c->stash->{results}       = $c->stash->{political_parties};

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

__PACKAGE__->meta->make_immutable;

1;
