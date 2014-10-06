package WebSMM::Controller::Promise;
use Moose;
use namespace::autoclean;
use MIME::Base64;
use URI;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/root') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'categories',
        params => {
            order => 'name',
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

    $api->stash_result(
        $c,
        'electoral_regional_courts',
        params => {
            order => 'state.name',
        }
    );
    $c->stash->{select_spe} = [ map { [ $_->{id}, $_->{state}{name} ] }
          @{ $c->stash->{electoral_regional_courts} } ];

    $api->stash_result(
        $c, 'states',
        params => {
            order => 'name',
        }
    );
    $c->stash->{select_states} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];

    unshift( $c->stash->{select_states}, [ 'br', 'Brasil' ] );
}

sub index : Chained('base') : PathPart('promessas') {
    my ( $self, $c, $candidate ) = @_;

    my $api = $c->model('API');

    $c->stash->{no_link} = 0;
    if ($candidate) {
        $c->req->params->{candidate_id} = $candidate;
        $c->stash->{no_link} = 1;
    }

    $api->stash_result(
        $c,
        'promises',
        params => {
            state_id => $c->req->params->{state_id}
            ? $c->req->params->{state_id}
            : undef,
            category_id => $c->req->params->{category_id}
            ? $c->req->params->{category_id}
            : undef,
            candidate_id => $c->req->params->{candidate_id}
            ? $c->req->params->{candidate_id}
            : undef,
        }
    );

    my %candidates;
    my $candidate_id = 0;
    my @info;
    my $i = 0;

    foreach my $promise ( @{ $c->stash->{promises} } ) {

        if ( $candidate_id != $promise->{candidate}{id} ) {

            $candidates{ $promise->{candidate}{name} } = $promise->{candidate};
            $candidates{ $promise->{candidate}{name} }{campaign_year} =
              $promise->{election_campaign}{year},

              $candidates{ $promise->{candidate}{name} }{political_position} =
              $promise->{election_campaign}{political_position}{position};

            $candidate_id = $promise->{candidate}{id};

            $candidates{ $promise->{candidate}{name} }{promises} = [];

        }

        $api->stash_result(
            $c,
            'promise_contents',
            params => {
                promise_id => $promise->{id}
            }
        );

        push(
            $candidates{ $promise->{candidate}{name} }{promises},
            {
                id                   => $promise->{id},
                name                 => $promise->{name},
                source               => $promise->{source},
                description          => $promise->{description},
                category_name        => $promise->{category}{name},
                created_at           => $promise->{created_at},
                created_by           => $promise->{created_by}{name},
                source_type          => $promise->{source_type}{name},
                publication_date     => $promise->{publication_date},
                external_link        => $promise->{external_link},
                promise_content_id   => $c->stash->{promise_contents}[0]{id},
                promise_content_name => $c->stash->{promise_contents}[0]{name}
            }
        );

    }

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', ['/root/index'],
            'Ocorreu um erro ao acessar as promessas.' );
    }
    else {
        $c->stash->{promises} = \%candidates;
    }

}

sub filter_promise_select : Chained('base') : PathPart('filter_promise_select')
{
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    if ( $c->req->params->{filter} eq 'br' ) {
        $api->stash_result(
            $c,
            'election_campaigns/get_candidates',
            params => {
                filter_position => 1
            }
        );
    }
    else {
        $api->stash_result(
            $c,
            'election_campaigns/get_candidates',
            params => {
                filter_region => $c->req->params->{filter}
            }
        );
    }

    $c->stash->{select_candidates} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{candidates} } ];

    $c->stash->{template}        = 'auto/select_candidates.tt';
    $c->stash->{without_wrapper} = 1;
}

sub filter_category_select : Chained('base') :
  PathPart('filter_category_select') {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    $api->stash_result(
        $c,
        'promises',
        params => {
            candidate_id => $c->req->params->{candidate_id},
        }
    );

    if ( scalar @{ $c->stash->{promises} } ) {

        my @ids;
        foreach my $promise ( @{ $c->stash->{promises} } ) {
            push( @ids, $promise->{category}{id} );
        }

        $api->stash_result(
            $c,
            'categories',
            params => {
                ids => encode_json( \@ids )
            }
        );
        $c->stash->{any_promise} = 0;
    }
    else {
        $c->stash->{any_promise} = 1;
    }
    $c->stash->{select_categories} =
      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{categories} } ];

    $c->stash->{template}        = 'auto/select_categories.tt';
    $c->stash->{without_wrapper} = 1;
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

__PACKAGE__->meta->make_immutable;

1;
