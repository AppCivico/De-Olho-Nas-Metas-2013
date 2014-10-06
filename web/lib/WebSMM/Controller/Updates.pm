package WebSMM::Controller::Updates;
use Moose;
use namespace::autoclean;
use JSON;
use Data::Dumper;
use XML::Simple;
use XML::XML2JSON;
use Spreadsheet::WriteExcel;
use utf8;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::Updates - Catalyst Controller

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

sub projects : Chained('base') Args(1) {

    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'project';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},

        );
    };
    my $teste = decode_json $res->content;
    OA $c->res->body( Dumper $teste );
}

sub axes : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'axes';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},

        );
    };
    my $teste = decode_json $res->content;

    $c->res->body( Dumper $teste );
}

sub articulations : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'articulations';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},

        );
    };
    my $teste = decode_json $res->content;

    $c->res->body( Dumper $teste );
}

sub objectives : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'objectives';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},

        );
    };
    my $teste = decode_json $res->content;

    $c->res->body( Dumper $teste );
}

sub secretaries : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'objectives';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},

        );
    };
    my $teste = decode_json $res->content;

    $c->res->body( Dumper $teste );
}

sub prefectures : Chained('base') Args(0) {
    my ( $self, $c ) = @_;
    my $return;
    my $res;

    use DDP;
    my $model = $c->model('API');

    $c->stash->{url} .= 'prefectures';

    p $c->stash->{url};

    $res = eval {
        $return = $model->_do_http_req(
            method => 'GET',
            url    => $c->stash->{url},
        );
    };
    my $teste = decode_json $res->content;

    $c->res->body( Dumper $teste );
}

=encoding utf8

=head1 AUTHOR

development,,,
B

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
