package WebSMM::View::TT;
use Moose;
use namespace::autoclean;
use utf8;
use DateTime;
use DateTime::Format::Pg;

extends 'Catalyst::View::TT';

use Template::AutoFilter;

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    WRAPPER            => 'wrapper.tt',
    render_die         => 1,

    CLASS    => 'Template::AutoFilter',
    ENCODING => 'UTF8',

    PRE_PROCESS => 'macros.tt',

    INCLUDE_PATH => [ WebSMM->path_to( 'root', 'src' ) ],
    TIMER        => 0,
    render_die   => 1,
);

sub days_of_week_human {
    my ( $self, $c, $dow ) = @_;

    my $str = join '', sort @$dow;

    return 'Dias úteis' if $str == '23456';

    return 'Fins de semana' if $str == '17';

    my $week = {
        1 => 'Domingo',
        2 => 'Segunda-feira',
        3 => 'Terça-feira',
        4 => 'Quarta-feira',
        5 => 'Quinta-feira',
        6 => 'Sexta-feira',
        7 => 'Sábado',
    };

    my $x = join ', ', map { $week->{$_} } sort @$dow;

    $x =~ s/^(.+)\,\s(.+)$/$1 e $2/;

    return "$x";
}

sub hour_human {
    my ( $self, $c, $time ) = @_;

    my $h = substr( $time, 0, 5 );
    $h =~ s/:/h/;

    return $h;
}

sub format_date_to_human {
    my ( $self, $c, $date ) = @_;

    my ( $y, $m, $d ) = $date =~ m/^(\d{4})-(\d{1,2})-(\d{1,2})/;
    my $h_date = "$d/$m/$y";

    return $h_date;
}

sub format_cnpj_to_human {
    my ( $self, $ref, $cnpj ) = @_;

    my ( $a, $b, $c, $d, $e ) =
      $cnpj =~ m/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/;

    return "$a.$b.$c/$d-$e";
}

sub birthdate_to_age {
    my ( $self, $ref, $date ) = @_;

    if ( !$date ) {
        return undef;
    }

    my $now = DateTime->now();
    my $birthdate = eval { DateTime::Format::Pg->parse_datetime($date) };

    my $age = $birthdate->subtract_datetime($now);

    return $age->years;
}

sub meter_to_kilometer {
    my ( $self, $ref, $distance ) = @_;

    return sprintf( "%.2f", $distance / 1000 );
}

=head1 NAME

WebSMM::View::TT - TT View for WebSMM

=head1 DESCRIPTION

TT View for WebSMM.

=head1 SEE ALSO

L<WebSMM>

=head1 AUTHOR

renato,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
