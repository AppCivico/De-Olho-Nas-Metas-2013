package SMM::Controller::API::State;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result    => 'DB::State',
    search_ok => {
        id    => 'Int',
        order => 'Str'
    },

);

with 'SMM::TraitFor::Controller::AutoBase';
with 'SMM::TraitFor::Controller::Search';

sub base : Chained('/api/base') : PathPart('states') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;
    $self->status_ok(
        $c,
        entity => {
            states => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              uf
                              country_id
                              /
                        ),
                      }
                } $c->stash->{collection}->as_hashref->all
            ]
        }
    );
}

1;
