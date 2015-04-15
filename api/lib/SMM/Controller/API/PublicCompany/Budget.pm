package SMM::Controller::API::PublicCompany::Budget;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/publiccompany/object') : PathPart('budgets') :
  CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->stash->{company}->budgets;

    $rs = $rs->search(
        undef,
        {
            order_by => 'me.observation'
        },
    );

    $self->status_ok(
        $c,
        entity => {
            budgets => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              business_name
                              business_name_url
                              dedicated_value
                              liquidated_value
                              observation
                              /
                        ),

                      }
                  } $rs->search(
                    undef,
                    {
                        result_class =>
                          'DBIx::Class::ResultClass::HashRefInflator'
                    }
                  )->all
            ]
        }
    );
}
1;
