package SMM::Controller::API::Companies;

use Moose;
use utf8;

BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config( default => 'application/json', );

sub base : Chained('/api/base') : PathPart('companies') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET {
    my ( $self, $c ) = @_;
    my $rs = $c->model('DB::ViewCompanies');

    $self->status_ok(
        $c,
        entity => {
            companies => [
                $rs->search(
                    undef,
                    {
                        bind => [ $c->req->params->{business_name_url} ],
                        result_class =>
                          'DBIx::Class::ResultClass::HashRefInflator'
                    }
                )->next
            ]
        }
      )

}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ( $self, $c ) = @_;

    my $rs = $c->model('DB::ViewCompanies');

    $self->status_ok(
        $c,
        entity => {
            companies => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->{$_} }
                              qw/
                              id
                              /
                        ),
                      }
                } $rs->search(undef, { result_class =>
                           'DBIx::Class::ResultClass::HashRefInflator'})->all
            ]
        }
    );
}


1;
