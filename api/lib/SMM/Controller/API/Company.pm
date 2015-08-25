package SMM::Controller::API::Company;

use Moose;
use utf8;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

__PACKAGE__->config(

    result => 'DB::Company',

    object_key => 'company',
    list_key   => 'companies',
    search_ok  => {
        name_url => 'Str'
    },
    result_attr  => { order_by => ['me.name'] },
    update_roles => [qw/superadmin admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],

    build_row => sub {
        my ( $r, $self, $c ) = @_;

        return {
            (
                map { $_ => $r->$_, }
                  qw/
                  id
                  name
                  name_url
                  cnpj
                  /
            ),
            documents => [
                map {
                    my $d = $_;
                    +{
                        (
                            map { $_ => $d->$_ }
                              qw/
                              id
                              url_name
                              /
                        ),

                      },
                  } $r->company_documents,

            ],

        };

    },
    before_delete => sub {
        my ( $self, $c, $item ) = @_;

        use DDP;
        $item->search_related('budgets')->update( { company_id => undef } )
          or return 0;
        return 1;
    },

);
with 'CatalystX::Eta::Controller::SimpleCRUD';
with 'CatalystX::Eta::Controller::Order';

after 'base' => sub {
    my ( $self, $c ) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search(
        {
            name_url => { '<' => 'a' }
        }
    ) if $c->req->params->{name_url_zero};
};
sub base : Chained('/api/base') : PathPart('companies') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) { }

sub result : Chained('object') : PathPart('') : Args(0) :
  ActionClass('REST') { }

sub result_GET {
}

sub result_DELETE {
}

sub result_PUT {
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
}

sub list_POST {
}

1;
