package SMM::Controller::Update;
use Moose;
use namespace::autoclean;
use JSON;
use utf8;
use Furl;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

SMM::Controller::Update - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{url} = 'http://planejasampa.prefeitura.sp.gov.br/metas/api/';
}

sub document : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'goals';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},
        );
    };
    my $data = decode_json $res->content;

    my $workbook = Spreadsheet::WriteExcel->new('file.xls')
      or die "Can't open file";
    my $worksheet = $workbook->add_worksheet();

    my $count = 0;
    for my $val ( @{$data} ) {

        if ( $count == 0 ) {
            $worksheet->write( 0, 0, 'Meta' );
            $worksheet->write( 0, 1, $val->{name} );
        }
        else {
            $worksheet->write( ++$count, 0, 'Meta' );
            $worksheet->write( $count,   1, $val->{name} );
        }
        $worksheet->write( ++$count, 0, 'Observação Técnica' );
        $worksheet->write( $count,   1, $val->{technically} );

        my $count_project = 0;
        for my $project_content ( @{ $val->{projects} } ) {

            $worksheet->write( ++$count, 0, 'Projeto' . ++$count_project );
            $worksheet->write( $count,   1, $project_content->{name} );
        }
        $worksheet->write( ++$count, 0, '-' x 90 );
    }
}

sub goal : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;
    my @prefectures;
    my @projects;
    my @secretary;
    my @secretaries;
    my $db = $c->model('DB::Goal');
    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'goals';

    p $c->stash->{url};

    $res = $self->furl->get( $c->stash->{url} );

    my $data = decode_json $res->content;
    for my $goal (@$data){

	next if $c->model('DB::Goal')->search({ name => $goal->{name} })->next; 
    p $c->stash->{url};	

    for my $sec ( @{ $goal->{secretaries} } ) {
		my $return_sec;
		
        delete $sec->{created_at};
        delete $sec->{updated_at};
        delete $sec->{pivot};

		$return_sec = $c->model('DB::Secretary')->search({ name => $sec->{name}})->next;
		$return_sec = $c->model('DB::Secretary')->create($sec) unless $return_sec;
		
        push( @secretary, $return_sec->id );
	}
    for my $key ( @{ $goal->{projects} } ) {

        for my $lol ( @{ $key->{prefectures} } ) {
			my $return_pref;
            delete $lol->{pivot};
            delete $lol->{created_at};
            delete $lol->{updated_at};
			delete $lol->{id};
            $lol->{latitude}  = delete $lol->{gps_lat};
            $lol->{longitude} = delete $lol->{gps_long};
			$return_pref = $c->model('DB::Prefecture')->search({ name => $lol->{name}})->next;
            $return_pref = $c->model('DB::Prefecture')->create($lol) unless $return_pref;
            push( @prefectures, $return_pref->id );
        }
        delete $key->{qualitative_progress_3};
        delete $key->{qualitative_progress_5};
        delete $key->{qualitative_progress_4};
        delete $key->{qualitative_progress_2};
        delete $key->{qualitative_progress_1};
        delete $key->{qualitative_progress_6};
        delete $key->{district};
        delete $key->{goal_id};
        delete $key->{prefectures};
        delete $key->{project_type};
        delete $key->{updated_at};
        delete $key->{created_at};
        delete $key->{location_type};
        delete $key->{weight_about_goal};
		delete $key->{id};
        $key->{latitude}  = delete $key->{gps_lat};
        $key->{longitude} = delete $key->{gps_long};
        my $return_proj; 
		$return_proj = $c->model('DB::Project')->search({ name => $key->{name}})->next;
		$return_proj = $c->model('DB::Project')->create($key) unless $return_proj;
        for (@prefectures){

        my $project = $c->model('DB::ProjectPrefecture')->create({
            project_id    => $return_proj->id,
            prefecture_id => $_  }) unless $c->model('DB::ProjectPrefecture')->search({ project_id => $return_proj->id, prefecture_id => $_ })->next;

		}
        push( @projects, $return_proj->id )

    }
    delete $goal->{qualitative_progress_3};
    delete $goal->{qualitative_progress_5};
    delete $goal->{qualitative_progress_4};
    delete $goal->{qualitative_progress_2};
    delete $goal->{qualitative_progress_1};
    delete $goal->{qualitative_progress_6};
    delete $goal->{schedule_2015_2016};
    delete $goal->{schedule_2013_2014};
    delete $goal->{axis_id};
    delete $goal->{articulation_id};
    delete $goal->{objective_id};
    delete $goal->{status};
    delete $goal->{porcentagem};
	delete $goal->{projects};
	delete $goal->{secretaries};
	delete $goal->{created_at};
	delete $goal->{updated_at};
    $goal->{transversality}  = delete $goal->{transversalidade};
    $goal->{description}     = delete $goal->{observation};
    $goal->{expected_budget} = delete $goal->{total_cost};

    my $return_goal = $c->model('DB::Goal')->create($goal);
	
	for (@projects){
    my $lol = $c->model('DB::GoalProject')->create({
        goal_id    => $return_goal->id,
        project_id => $_ }) unless $c->model('DB::GoalProject')->search({ goal_id => $return_goal->id, project_id => $_ })->next;
	}
	for (@secretary){

    my $sec = $c->model('DB::GoalSecretary')->create({
        goal_id    => $return_goal->id,
        secretary_id => $_ }) unless $c->model('DB::GoalSecretary')->search({ goal_id => $return_goal->id, secretary_id => $_ })->next; 
	}

    }
}

sub prefectures : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'prefectures';

    p $c->stash->{url};

    #$res = eval {
    #    $return = $model->_do_http_req(
    #        method => 'GET',
    #        url    => $c->stash->{url},
    #    );
    #};

    $res = $self->furl->get( $c->stash->{url} );

    my $data = decode_json $res->content;
    p $data;

    $c->res->body('teste');
}
sub search_goal : Chained('base') :Args(0) :ActionClass('REST'){}
sub search_goal_GET {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
	my @goals =  $c->model('DB::Goal')->search(undef, { prefetch => [{ goal_projects => 'project' }] })->all;

	for my $key (@goals){
		for my $lol ($key->goal_projects){
			p$lol->project;
		}
	}
	$self->status_ok( $c , 
	entity => \@goals ); 	
}


sub furl {
    return Furl->new(
        agent   => 'SMM',
        timeout => 100
    );
}

=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
