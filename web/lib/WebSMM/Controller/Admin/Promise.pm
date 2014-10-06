package WebSMM::Controller::Admin::Promise;
use Moose;
use namespace::autoclean;
use POSIX;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/base') : PathPart('promise') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $org = $c->stash->{organizations};

    $api->stash_result(
        $c,
        'categories',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_categories} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{categories} } ];

    $api->stash_result(
        $c,
        'candidates',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_candidates} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{candidates} } ];

    if ($org) {
        $api->stash_result(
            $c, 'states',
            params => {
                order => 'me.name',
                id    => $org->[0]{city}{state}{id}
            }
        );

        $api->stash_result(
            $c, 'cities',
            params => {
                order    => 'me.name',
                state_id => $org->[0]{city}{state}{id}
            }
        );

        $api->stash_result(
            $c,
            'election_campaigns',
            params => {
                filter   => 1,
                order    => 'state.uf',
                state_id => $org->[0]{city}{state}{id},
            }
        );

    }
    else {
        $api->stash_result(
            $c, 'states',
            params => {
                order => 'me.name',
            }
        );

        $api->stash_result(
            $c, 'cities',
            params => {
                order => 'me.name',
            }
        );

        $api->stash_result(
            $c,
            'election_campaigns',
            params => {
                order => 'state.uf',
            }
        );
    }

    $api->stash_result(
        $c,
        'source_types',
        params => {
            order => 'me.name',
        }
    );
    $c->stash->{select_source_types} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{source_types} } ];

    $c->stash->{select_states} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
    $c->stash->{select_cities} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ];
    $c->stash->{select_election_campaigns} = [
        map {
            [
                $_->{id},
                $_->{year} . '  '
                  . $_->{political_position}{position} . '  '
                  . $_->{state}{uf} . '  '
                  . $_->{city}{name}
            ]
        } @{ $c->stash->{election_campaigns} }
    ];
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    $api->stash_result( $c, [ 'promises', $id ], stash => 'promise_obj' );

    $api->stash_result(
        $c,
        'promise_contents',
        stash  => 'promise_content_obj',
        params => {
            promise_id => $c->stash->{promise_obj}{id}
        }
    );

    my $params = { %{ $c->stash->{promise_obj} } };

    $form->format_date_to_human( $params, 'publication_date' );

    $c->stash->{promise_obj} = $params;
}

sub index : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api  = $c->model('API');
    my $form = $c->model('Form');

    my $org = $c->stash->{organizations};

    my $item_per_page = 10;
    my $page = $c->req->params->{page} || 1;

    if ( $c->req->params->{name} ) {
        my @fields;
        my $params = { %{ $c->req->params } };

        $c->stash->{name} = $c->req->params->{name};

        $api->stash_result(
            $c,
            'promises',
            params => {
                name => $params->{name} ? $params->{name} : undef,
                page => $page,
                org_state_id => $org ? $org->[0]{city}{state}{id} : undef,
            }
        );
    }
    else {
        $api->stash_result(
            $c,
            'promises',
            params => {
                page         => $page,
                org_state_id => $org ? $org->[0]{city}{state}{id} : undef,
            }
        );
    }

    $c->stash->{count_partial} = scalar keys $c->stash->{promises};
    $c->stash->{total}         = $c->stash->{count};
    $c->stash->{results}       = $c->stash->{promises};

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

sub download_content : Chained('base') : PathPart('download_content') : Args(1)
{
    my ( $self, $c, $content_id ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [ 'promise_contents', $content_id ],
        stash => 'promise_content_obj'
    );

    if ( !$c->stash->{promise_content_obj} ) {
        $c->res->body('Nenhum arquivo encontrado.');
        $c->detach();
    }

    my $path      = Cwd::cwd();
    my $full_path = $path . '/../' . $c->stash->{promise_content_obj}{link};

    my $name = $c->stash->{promise_content_obj}{name};

    my $content = $api->stash_result(
        $c,
        'download-files',
        params => {
            path => $full_path,
        },
        get_as_content => 1
    );

    $c->res->header( 'content-type',        'application/octet-stream' );
    $c->res->header( 'Content-Disposition', qq[attachment; filename=$name] );

    $c->res->body($content);

    $c->detach();
}

sub filter_candidates_by_ec : Chained('') : PathPart('filter_candidates_by_ec')
  : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        [
            'election_campaigns/get_candidates',
            $c->req->params->{election_campaign_id}
        ],
    );

    $c->stash->{select_candidates} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{candidates} } ];

    $c->stash->{template}        = 'auto/select_candidates.tt';
    $c->stash->{without_wrapper} = 1;
}

__PACKAGE__->meta->make_immutable;

1;
