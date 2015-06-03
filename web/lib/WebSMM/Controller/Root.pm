package WebSMM::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }
use I18N::AcceptLanguage;

has 'lang_acceptor' => (
    is      => 'rw',
    isa     => 'I18N::AcceptLanguage',
    lazy    => 1,
    default => sub { I18N::AcceptLanguage->new( defaultLanguage => 'pt-br' ) }
);
#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=encoding utf-8

=head1 NAME

WebSMM::Controller::Root - Root Controller for WebSMM

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $self->root($c);

    $c->res->redirect( $c->uri_for_action('/user/account/index') ), $c->detach
      if $c->user_exists;

    $c->forward('/homefuncional/base');
    $c->forward('/homefuncional/home');
    $c->stash->{template} = 'homefuncional/home.tt';

}

sub change_lang : Chained('root') PathPart('lang') CaptureArgs(1) {
    my ( $self, $c, $lang ) = @_;
    $c->stash->{lang} = $lang;
}

sub change_lang_redir : Chained('change_lang') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

    my $cur_lang = $c->stash->{lang};
    my %langs = map { $_ => 1 } split /,/, $c->config->{available_langs};
    $cur_lang = 'pt-br' unless exists $langs{$cur_lang};
    my $host = $c->req->uri->host;

    $c->response->cookies->{'cur_lang'} = {
        value   => $cur_lang,
        path    => '/',
        expires => '+3600h',
    };

    my $refer = $c->req->headers->referer;
    if ( $refer && $refer =~ /^https?:\/\/$host/ ) {
        $c->res->redirect($refer);
    }
    else {
        $c->res->redirect( $c->uri_for('/') );
    }
    $c->detach;
}

sub load_lang {
    my ( $self, $c ) = @_;

    my $cur_lang =
      exists $c->req->cookies->{cur_lang}
      ? $c->req->cookies->{cur_lang}->value
      : undef;

    if ( !defined $cur_lang ) {
        my $al = $c->req->headers->header('Accept-language');
        my $language =
          $self->lang_acceptor->accepts( $al, split /,/,
            $c->config->{available_langs} );

        $cur_lang = $language;

    }
    else {
        my %langs = map { $_ => 1 } split /,/, $c->config->{available_langs};
        $cur_lang = 'en' unless exists $langs{$cur_lang};
    }

    $c->set_lang($cur_lang);

    $c->response->cookies->{'cur_lang'} = {
        value   => $cur_lang,
        path    => '/',
        expires => '+3600h',
      }
      if !exists $c->req->cookies->{cur_lang}
      || $c->req->cookies->{cur_lang} ne $cur_lang;

}

#sub more : Chained('') : Path('saiba-mais') : Args(0) {
#    my ( $self, $c ) = @_;
#
#    my $api = $c->model('API');
#
#    $api->stash_result(
#        $c,
#        'categories',
#        params => {
#            order => 'name',
#        }
#    );
#    $c->stash->{select_categories} =
#      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{categories} } ];
#
#    $api->stash_result(
#        $c,
#        'candidates',
#        params => {
#            order => 'me.name',
#        }
#    );
#    $c->stash->{select_candidates} =
#      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{candidates} } ];
#
#    $api->stash_result(
#        $c, 'states',
#        params => {
#            order => 'name',
#        }
#    );
#    $c->stash->{select_states} =
#      [ map { [ $_->{id}, $_->{name} ] } @{ $c->stash->{states} } ];
#
#    unshift( $c->stash->{select_states}, [ 'br', 'Brasil' ] );
#
#    $api->stash_result(
#        $c,
#        'electoral_regional_courts',
#        params => {
#            order => 'state.name',
#        }
#    );
#
#    $c->stash->{select_spe} = [ map { [ $_->{id}, $_->{state}{name} ] }
#          @{ $c->stash->{electoral_regional_courts} } ];
#
#    $c->stash->{template} = 'auto/saiba_mais.tt';
#}

sub root : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->stash->{c_req_path} = $c->req->path;

    $c->session->{foobar}++;

    $self->load_lang($c);

    $c->load_status_msgs;
    my $status_msg = $c->stash->{status_msg};
    my $error_msg  = $c->stash->{error_msg};

    @{ $c->stash }{ keys %$status_msg } = values %$status_msg
      if ref $status_msg eq 'HASH';
    @{ $c->stash }{ keys %$error_msg } = values %$error_msg
      if ref $error_msg eq 'HASH';

    my ( $class, $action ) = ( $c->action->class, $c->action->name );
    $class =~ s/^WebSMM::Controller:://;
    $class =~ s/::/-/g;

    $c->stash->{body_class} = lc "$class $class-$action";

    if ( $c->user ) {
        if ( grep { /^user$/ } $c->user->roles ) {
            $c->stash->{role_controller} = 'user';
        }
        elsif ( grep { /^admin$/ } $c->user->roles ) {
            $c->stash->{role_controller} = 'admin';
        }
        elsif ( grep { /^counsil$/ } $c->user->roles ) {
            $c->stash->{role_controller} = 'counsil';
        }
        elsif ( grep { /^organization$/ } $c->user->roles ) {
            $c->stash->{role_controller} = 'organization';
        }
    }
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;

    $self->root($c);
    my $maybe_view = join '/', @{ $c->req->arguments };

    if ( $c->user && $maybe_view =~ /^(participar)$/ ) {
        $c->detach( 'Form::Login' => 'after_login' );
    }

    my $output;
    eval {
        $c->stash->{body_class} .= ' ' . $maybe_view;
        $c->stash->{body_class} =~ s/\//-/g;
        $c->stash->{template_wrapper} = 'func';
        $output =
          $c->view('TT')->render( $c, "auto/$maybe_view.tt", $c->stash );
    };
    if ( $@ && $@ =~ /not found$/ ) {
        $c->response->body('Page not found');
        $c->response->status(404);
    }
    elsif ( !$@ ) {
        $c->response->body($output);
    }
    else {
        die $@;
    }
}

sub rest_error : Private {
    my ( $self, $c ) = @_;

    $c->stash->{template}        = 'rest_error.tt';
    $c->stash->{without_wrapper} = 1;

    # TODO enviar um email se não estiver com $c->debug ?
    $c->res->status(500);

}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;

    if ( $c->debug && exists $ENV{DUMP_STASH} ) {
        my $x = $c->stash;
    }
}

=head1 AUTHOR

renato,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
