package SMM::TraitFor::Controller::ListAutocomplete;

use Moose::Role;
use SMM::FuzzyText;

after list_GET => sub {
    my $self = shift;

    my ($c) = @_;

    if ( $c->req->params->{list_autocompleate} ) {
        my $list_key = $self->config->{list_key};

        if ( !$c->stash->{error} && exists $c->stash->{rest}{$list_key} ) {

            my $rest = {
                suggestions => [

                    # ex: { value => 'foobar', data => { }  }
                ]
            };

            foreach ( @{ $c->stash->{rest}{$list_key} } ) {
                push @{ $rest->{suggestions} },
                  {
                    value => $_->{name},
                    data  => $_->{id}
                  };
            }
            $c->stash->{rest} = $rest;

        }
        elsif ( !$c->stash->{error} ) {
            $self->status_bad_request( $c, message => "unknwon error before on list_GET" ), $c->detach;
        }
    }

};

1;

