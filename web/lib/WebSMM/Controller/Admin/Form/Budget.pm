package WebSMM::Controller::Admin::Form::Budget;
use Moose;
use namespace::autoclean;
use DateTime;
use JSON::XS;
use utf8;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/admin/form/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub download : Chained('base') : PathPart('budget') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    @{ $c->stash->{header} } = (
        "nome da empresa",
        "cnpj",
        "id da meta",
        "valor dedicado",
        "valor liquidado",
        "observação",
        "código de contrato",
        "ano dedicado",
        "código da organização",
        "nome da organização",
        "id da empresa",
        "código de empenho"
    );
}

sub process : Chained('base') : PathPart('budget') : Args(0) {
    my ( $self, $c ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };
    $api->stash_result(
        $c, ['budgets'],
        method => 'POST',
        body   => $params
    );
    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }

    $c->detach( '/form/redirect_ok',
        [ '/admin/budget/index', {}, 'Cadastrado com sucesso!' ] );
}

sub process_edit : Chained('base') : PathPart('budget') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api    = $c->model('API');
    my $params = { %{ $c->req->params } };

    $api->stash_result(
        $c, [ 'budgets', $id ],
        method => 'PUT',
        body   => $params
    );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/budget/index', {}, 'Alterado com sucesso!' ] );
    }
}

sub process_delete : Chained('base') : PathPart('remove_budget') : Args(1) {
    my ( $self, $c, $id ) = @_;

    my $api = $c->model('API');

    $api->stash_result( $c, [ 'budgets', $id ], method => 'DELETE' );

    if ( $c->stash->{error} ) {
        $c->detach( '/form/redirect_error', [] );
    }
    else {
        $c->detach( '/form/redirect_ok',
            [ '/admin/budget/index', {}, 'Removido com sucesso!' ] );
    }
}

sub csv : Chained('download') : PathPart('csv') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'budget', \%lines );

}

sub xls : Chained('download') : PathPart('xls') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'budget', \%lines );

}

sub xlsx : Chained('download') : PathPart('xlsx') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'csv';
    push @{ $lines{main} }, $c->stash->{header};
    $file->_download( $c, 'budget', \%lines );

}

sub upload : Chained('base') : PathPart('upload_budget') : Args(0) {
    my ( $self, $c ) = @_;
    my $api = $c->model('API');

    my $upload = $c->req->upload('archive');
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
        [ 'upload', 'budgets' ],

        body => [
            'orignal_filename ' => $upload->filename,
            'file'              => [ $upload->tempname ]
        ],
        method => 'upload',
    );
    if ( $c->stash->{status}{error} eq 'header_found' ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = {
            'archive',      'invalid',
            'archive:help', 'cabeçalho não encontrado.'
        };

        $c->detach( '/form/redirect_error', );
    }
    elsif ( $c->stash->{error} ) {

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

            #$c->stash->{form_error} = \%new;
            $c->stash->{error} = $c->stash->{form_error}->{archive};
        }

        $c->detach( '/form/redirect_error', );

    }
    else {

        $c->detach(
            '/form/redirect_ok',
            [
                \'/admin/budget/upload',
                status_msg => 'Importado com sucesso',
                status     => $c->stash->{status}
            ],
        );

    }

}

sub company : Chained('download') : PathPart('company') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';

    $api->stash_result( $c, 'companies' );

    push @{ $lines{main} }, [ 'id', 'name' ];
    push @{ $lines{main} }, [ $_->{id}, $_->{name} ]
      for @{ $c->stash->{companies} };
    $file->_download( $c, 'companies', \%lines );

}

sub goal : Chained('download') : PathPart('goal') : Args(0) {
    my ( $self, $c ) = @_;
    my $api  = $c->model('API');
    my $file = $c->model('File');

    my %lines;
    $c->stash->{type} = 'xls';

    $api->stash_result( $c, 'goals' );

    push @{ $lines{main} }, [ 'id', 'name' ];
    push @{ $lines{main} }, [ $_->{id}, $_->{name} ]
      for @{ $c->stash->{goals} };
    $file->_download( $c, 'goals', \%lines );

}

__PACKAGE__->meta->make_immutable;

1;
