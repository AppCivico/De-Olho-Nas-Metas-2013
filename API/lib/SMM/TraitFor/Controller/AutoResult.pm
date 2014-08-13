package SMM::TraitFor::Controller::AutoResult;

use Moose::Role;
requires 'result_GET';
requires 'result_PUT';
requires 'result_DELETE';

around result_GET => sub {
    my $orig = shift;
    my $self = shift;
    my ($c)  = @_;

    my $it = $c->stash->{ $self->config->{object_key} };

    my $func = $self->config->{build_row};

    my $ref = $func->($it);

    $self->status_ok( $c, entity => $ref );

    $self->$orig(@_);
};

around result_PUT => sub {
    my $orig = shift;
    my $self = shift;
    my ($c)  = @_;

    my $something = $c->stash->{ $self->config->{object_key} };

    $something->execute( $c, for => 'update', with => $c->req->params );

    $self->status_accepted(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $something->id ] )->as_string,
        entity => { id => $something->id }
      ),
      $c->detach
      if $something;

    $self->$orig(@_);
};

around result_DELETE => sub {
    my $orig = shift;
    my $self = shift;
    my ($c)  = @_;

    my $something = $c->stash->{ $self->config->{object_key} };
    $self->status_gone( $c, message => 'deleted' ), $c->detach
      unless $something;


    $c->model('DB')->txn_do(sub {

        my $delete = 1;
        if (ref $self->config->{before_delete} eq 'CODE'){
            $delete = $self->config->{before_delete}->($self, $c, $something);
        }

        $something->delete if $delete;
    });

    $self->status_no_content($c);
    $self->$orig(@_);
};

1;

