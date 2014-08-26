package SMM::Controller::API::City;

use Moose;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
    default => 'application/json',

    result    => 'DB::City',
    search_ok => {
        state_id => 'Int',
        order    => 'Str'
    }
);
with 'SMM::TraitFor::Controller::AutoBase';
with 'SMM::TraitFor::Controller::Search';

sub base : Chained('/api/base') : PathPart('cities') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') {
}

sub list_GET {
    my ( $self, $c ) = @_;

    $self->status_ok(
        $c,
        entity => {
            cities => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              name_url
                              state_id
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
