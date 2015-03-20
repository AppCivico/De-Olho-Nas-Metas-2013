package SMM::Controller::API::Company::Goal;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/company/object') : PathPart('goals') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $goals = $c->stash->{company}->budgets;

   my $rs = $c->model('DB::Goal')->search({ goal_number => {-in => $goals->get_column('goal_number')->as_query }});
    $rs = $rs->search(
        undef,
        {
            order_by => 'name'
        },
    );

    $self->status_ok(
        $c,
        entity => {
            goals => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              name
                              /
                        ),

                      }
                } $rs->search(undef,{result_class => 'DBIx::Class::ResultClass::HashRefInflator'})->all
            ]
        }
    );
}
1;
