package WebSMM::Controller::Admin::Upload;
use Moose;
use namespace::autoclean;
use utf8;
use Encode;
use JSON::MaybeXS;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::Admin::Upload - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/admin/base') : PathPart('upload') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub upload : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    my $api = $c->model('API');

    my $upload = $c->req->upload('archive');
    use DDP;
    if ( !$upload ) {
        $c->stash->{error} = 'form_error';
        $c->stash->{form_error} = { 'archive', 'missing' };
        $c->detach( '/form/redirect_error' );
    }
    elsif ( $upload->filename !~ /(.xlsx?|.csv)$/i ) {
        $c->stash->{error}      = 'form_error';
        $c->stash->{form_error} = { 'archive', 'invalid' };
        $c->stash->{form_error} = { 'archive:help', 'use XLS, XLSX or CSV' };
        $c->detach( '/form/redirect_error4adm',
            [ anchor => 'usuario/blacklist/upload' ] );
    }
    p $upload;
    my $status = $api->get_result(
        $c,
        '/admin/upload',
        method => 'POST',
        body   => [

        ],
        files => { archive => $upload->tempname, },
    );

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

=encoding utf8

=head1 AUTHOR

development,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
