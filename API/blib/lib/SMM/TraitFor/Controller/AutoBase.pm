package SMM::TraitFor::Controller::AutoBase;

use Moose::Role;

requires 'base';

around base => sub {
    my $orig = shift;
    my $self = shift;

    my ($c) = @_;
    my $config = $self->config;

    $c->stash->{collection} = $c->model( $self->config->{result} );

    if ( exists $config->{result_cond} && exists $config->{result_attr} ) {

        $c->stash->{collection} = $c->stash->{collection}->search( $config->{result_cond}, $config->{result_attr} );

    }
    else {
        if ( exists $config->{result_cond} ) {
            $c->stash->{collection} = $c->stash->{collection}->search( $config->{result_cond} );
        }
        elsif ( exists $config->{result_attr} ) {
            $c->stash->{collection} = $c->stash->{collection}->search( undef, $config->{result_attr} );
        }
    }

    $self->$orig(@_);
};

sub _real_as_array {
    my ( $self, $splt, $itens ) = @_;

    my $out          = {};
    my $idx_visibles = {};

    foreach my $k ( keys %$itens ) {
        next unless $k =~ /^$splt:([^\:]+):([0-9]+)$/;

        my ( $name, $idx ) = ( $1, $2 );

        $out->{$idx}{$name} = $itens->{$k};
        $idx_visibles->{$idx}++;
    }

    # check if all items are with the same number of keys
    my $last;
    foreach my $idx ( keys %$idx_visibles ) {
        my $v = $idx_visibles->{$idx};
        $last = $v unless defined $last;
        die 'invalid "real_(name):(index)" parameters' if $last != $v;
    }

    my $array = [];
    foreach my $idx ( keys %$idx_visibles ) {

        my $item = {};
        foreach my $name ( keys %{ $out->{$idx} } ) {
            $item->{$name} = $out->{$idx}{$name};
        }
        push @$array, $item;
    }

    return $array;
}

1;

