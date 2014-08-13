package SMM::TraitFor::Controller::Search;

use Moose::Role;
use Moose::Util::TypeConstraints;

around list_GET => sub {
    my $orig = shift;
    my $self = shift;

    my ($c) = @_;

    #print "      Search::around list_GET \n";

    my %may_search;
    if ( exists $self->config->{search_ok} ) {
        foreach my $key_ok ( keys %{ $self->config->{search_ok} } ) {
            $may_search{$key_ok} = $c->req->params->{$key_ok} if exists $c->req->params->{$key_ok};


            if (exists $c->req->params->{"$key_ok:IN"}){
                $may_search{$key_ok} = [split /\n/, $c->req->params->{"$key_ok:IN"}];
            }
        }
    }

    foreach my $key ( keys %may_search ) {

        my $type = $self->config->{search_ok}{$key};
        my $val  = $may_search{$key};

        my $cons = Moose::Util::TypeConstraints::find_or_parse_type_constraint($type);

        $self->status_bad_request( $c, message => "Unknown type constraint '$type'" ), $c->detach
        unless defined($cons);


        if (ref $val eq 'ARRAY'){
            foreach my $a_val (@$val){
                if ( !$cons->check($a_val) ) {
                    $self->status_bad_request( $c, message => "invalid param $key for $a_val" ), $c->detach;
                }
            }
        }else{
            if ( !$cons->check($val) ) {
                $self->status_bad_request( $c, message => "invalid param $key" ), $c->detach;
            }
        }
    }

    foreach my $k ( keys %may_search ) {
        if ( $k !~ /\./ ) {
            $may_search{"me.$k"} = delete $may_search{$k};
        }
    }

    $c->stash->{collection} = $c->stash->{collection}->search( {%may_search} )
      if %may_search;
    $self->$orig(@_);
};

1;

