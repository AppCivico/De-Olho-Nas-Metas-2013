package SMM::Controller::API::Company;

use Moose;
use utf8;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

__PACKAGE__->config(

    result     => 'DB::Company',
	
    object_key => 'company',
	list_key   => 'companies',
    search_ok  => {
        name_url => 'Str'
    },
	order_ok => {
		name => 1
	},
    update_roles => [qw/superadmin admin webapi organization/],
    create_roles => [qw/superadmin admin webapi/],
    delete_roles => [qw/superadmin admin webapi/],

	build_row => sub {
		my ($r, $self, $c) = @_;
	
		return {
		    (
                map { $_ => $r->$_, }
                  qw/
                  id
                  name
				  name_url
                  /
            ),

		};


	}
);
with 'CatalystX::Eta::Controller::SimpleCRUD';
with 'CatalystX::Eta::Controller::Order';

after 'base' => sub { 
	my ($self, $c) = @_;

 	$c->stash->{collection} = $c->stash->{collection}->search({
      name_url => { '<' => 'a' }    
    }) if $c->req->params->{name_url_zero};
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
