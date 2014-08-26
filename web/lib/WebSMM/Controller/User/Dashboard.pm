package WebSMM::Controller::User::Dashboard;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/user/base') : PathPart('') : CaptureArgs(0) {
}

sub object : Chained('base') : PathPart('dashboard') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    if ( @{ $c->stash->{vehicles} } == 0 ) {

        $c->stash->{cadastro_incompleto} = 1;
        $c->stash->{main_view}           = 'parts/new_vehicle.tt';

    }
    elsif ( @{ $c->stash->{vehicle_routes} || [] } == 0 ) {

        $c->stash->{cadastro_incompleto} = 1;
        $c->stash->{main_view}           = 'parts/new_route.tt';

        my $controller = $c->controller('User::Route');

        $controller->add($c);

    }

    $api->stash_result( $c, 'states' );
    $c->stash->{select_states} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];

    if($c->stash->{body}{state_id}) {
        $api->stash_result(
            $c, 'cities',
            params => {
                state_id    => $c->stash->{body}{state_id},
                order       => 'name'
            }
        );
        $c->stash->{select_cities} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{cities} } ];
    }

    $api->stash_result($c, 'vehicle_colors', params => { order => 'name' } );
    $c->stash->{select_colors} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{vehicle_colors} } ];

    $api->stash_result(
        $c, 'vehicle_brands',
         params => {
            order => 'name'
        }
    );
    $c->stash->{select_brands} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{vehicle_brands} } ];

    if($c->stash->{body}{vehicle_brand_id}) {
        $api->stash_result(
            $c, 'vehicle_models',
            params => {
                vehicle_brand_id    => $c->stash->{body}{vehicle_brand_id},
                order               => 'name'
            }
        );
        $c->stash->{select_models} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{vehicle_models} } ];
    }

    $api->stash_result(
        $c, 'insurance_companies',
        params => {
            order => 'name'
        }
    );
    $c->stash->{select_insurance_companies} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{insurance_company} } ];

    my $year       = DateTime->now;
    my $first_year = $year->year - 3;
    my @year_range;
    my %vehicle_years;

    $year_range[0] = $first_year;
    $vehicle_years{ $year_range[0] } = $first_year;

    for ( my $i = 1 ; $i < 6 ; $i++ ) {
        $year_range[$i] = $year_range[ $i - 1 ] + 1;
        $vehicle_years{ $year_range[$i] } = $year_range[$i];
    }

    $c->stash->{vehicle_years} = [ map { [ $_, $vehicle_years{$_} ] } sort keys %vehicle_years ];

    $api->stash_result(
        $c,
        'vehicle_parking_types',
        params => {
            order => 'name'
        }
    );
    $c->stash->{select_parking_types} = [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{vehicle_parking_types} } ];
}

sub index : Chained('object') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

}

__PACKAGE__->meta->make_immutable;

1;
