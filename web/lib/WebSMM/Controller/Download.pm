package WebSMM::Controller::Download;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

WebSMM::Controller::Download - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub download : Path : Args(0) {
    my ( $self, $c ) = @_;
    my $csv;

    my $api = $c->model('API');

    my $json = $api->stash_result( $c, 'preregisters', get_as_content => 1 );
    use DDP;
    my $content = decode_json $json;
    $csv .= "$_->{username},$_->{useremail}\n"
      for ( @{ $content->{preregisters} } );
    $c->res->content_type('text/comma-separated-values');

    my $name = q/pre_cadastro.txt/;
    $c->res->header( 'Content-Disposition', qq[attachment; filename=$name] );

    $c->res->body($csv);

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
