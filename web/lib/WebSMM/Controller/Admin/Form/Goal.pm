package WebSMM::Controller::Admin::Form::Goal;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub download : Chained('base') : PathPart('goal') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    @{ $c->stash->{header} } = (
        "nome",
        "descrição",
        "descrição Técnica",
        "objetivo de entrega",
        "expectativa de começo",
        "expectativa de fim",
        "porcentagem",
        "número da meta",
        "progresso Qualitativo 1",
        "progresso Qualitativo 2",
        "progresso Qualitativo 3",
        "progresso Qualitativo 4",
        "progresso Qualitativo 5",
        "progresso Qualitativo 6"
    );
}

sub upload : Chained('base') : PathPart('upload_goal') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    my $upload = $c->req->upload('archive');
    use DDP;
    if ( !$upload ) {
        $c->stash->{error} = 'form_error';
        $c->stash->{form_error} = { 'archive', 'missing' };
        $c->detach('/form/redirect_error');
    }
    elsif ( $upload->filename !~ /(.xlsx?|.csv)$/i ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = { 'archive', 'invalid' };
        $c->stash->{form_error} = { 'archive:help', 'use XLS, XLSX or CSV' };
        $c->detach( '/form/redirect_error4adm',
            [ anchor => 'usuario/blacklist/upload' ] );
    }
    my $status = $api->stash_result(
        $c,
        [ 'upload', 'goals' ],

        body => [
            'orignal_filename ' => $upload->filename,
            'file'              => [ $upload->tempname ]
        ],
        method => 'upload',
    );
    $c->detach;
    if ( $status->{status}{error} eq 'header_found' ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = {
            'archive',      'invalid',
            'archive:help', 'cabeçalho não encontrado.'
        };

        $c->detach( '/form/redirect_error', );
    }
    elsif ( $status->{error} ) {

        $c->stash->{error}      = $status->{error};
        $c->stash->{form_error} = $status->{form_error}
          if exists $status->{form_error};
        $c->stash->{error} = 'form_error' if $status->{error_is_form_error};

        if ( ref $c->stash->{form_error} eq 'HASH' ) {
            my %new;

            # porrra de macros.tt q nao entende os varios tipos de erros..
            while ( my ( $k, $v ) = each %{ $c->stash->{form_error} } ) {
                $new{$k} = $v;
                if ( $v !~ /(invalid|missing)/ ) {
                    $new{"$k:help"} = $v;
                    $new{$k} = 'invalid';
                }
            }
            $c->stash->{form_error} = \%new;
        }

        $c->detach( '/form/redirect_error', );

    }
    else {

        $c->detach(
            '/form/redirect_ok',
            [
                anchor     => 'usuario/blacklist',
                status_msg => 'Importado com sucesso',
                status     => $status->{status}
            ]
        );

    }

}

sub csv : Chained('download') : PathPart('csv') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'meta', \%lines );

}

sub xls : Chained('download') : PathPart('xls') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'meta', \%lines );

}

sub xlsx : Chained('download') : PathPart('xlsx') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'meta', \%lines );

}

sub process : Chained('base') : PathPart('goal') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    $api->stash_result(
        $c, ['goals'],
        method => 'POST',
        body   => $params
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach( '/form/redirect_ok',
        [ '/admin/goal/index', {}, 'Cadastrado com sucesso!' ] );
}

sub process_edit : Chained('base') : PathPart('goal') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'goals', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/goal/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_goal') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'goals', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/goal/index', {}, 'Removido com sucesso!' ] );
    }
}

__PACKAGE__->meta->make_immutable;

1;
