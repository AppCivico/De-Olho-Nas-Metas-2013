package WebSMM::Model::Form;
use base 'Catalyst::Model';
use Moose;
use utf8;

sub initialize_after_setup {
}

sub format_date {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        next unless $ref->{$f};

        my $date            = $ref->{$f};
        my ( $d, $m, $y )   = $date =~ m/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
        $ref->{$f}          = "$y-$m-$d";
    }
}

sub format_date_to_human {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        my $date = $ref->{$f};
        my @date_sp = split( 'T', $date );

        my ( $y, $m, $d ) = $date_sp[0] =~ m/^(\d{4})-(\d{1,2})-(\d{1,2})$/;
        $ref->{$f} = "$d/$m/$y";
    }

}

sub format_cpf_to_human {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        my $cpf = $ref->{$f};

        my ( $u, $d, $t, $q ) = $cpf =~ m/^(\d{3})(\d{3})(\d{3})(\d{2})$/;
        $ref->{$f} = "$u.$d.$t-$q";
    }
}

sub format_cnpj_to_human {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        my $cpf = $ref->{$f};

        my ( $a, $b, $c, $d, $e ) = $cpf =~ m/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/;
        $ref->{$f} = "$a.$b.$c/$d-$e";
    }
}

sub only_number {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        next unless $ref->{$f};

        $ref->{$f} =~ s/[^\d]//g;
    }
}

sub format_car_plate {
    my ( $self, $ref, @fields ) = @_;

    foreach my $f (@fields) {
        $ref->{$f} =~ s/-//g;
    }
}

1;
