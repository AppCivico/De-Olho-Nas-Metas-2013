package SMM::TraitFor::Controller::AutoList;

use Moose::Role;
requires 'list_GET';
requires 'list_POST';

around list_GET => sub {
    my $orig = shift;
    my $self = shift;
    my ($c)  = @_;

    #print "      AutoList::around list_GET \n";

    my $nameret = $self->config->{list_key};
    my $func = $self->config->{build_list_row} || $self->config->{build_row};

    my @rows;
    while ( my $r = $c->stash->{collection}->next ) {

        push @rows, $func->($r);
    }
    $self->status_ok(
        $c,
        entity => {
            $nameret => \@rows
        }
    );
    $self->$orig(@_);
};

around list_POST => sub {
    my $orig = shift;
    my $self = shift;
    my ($c)  = @_;

    my $something = $c->stash->{collection}->execute(
        $c,
        for  => 'create',
        with => {
            %{ $c->req->params },
            created_by => $c->user->id

        }
    );

    $self->status_created(
        $c,
        location => $c->uri_for( $self->action_for('result'), [ $something->id ] )->as_string,
        entity => {
            id => $something->id
        }
    );

    $self->$orig(@_);

    return 1;
};

1;

