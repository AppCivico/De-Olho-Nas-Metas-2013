
package SMM::Controller::API::Upload::Budget;

use Moose;
use JSON;
use SMM::Types qw/DataStr TimeStr/;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

__PACKAGE__->config( default => 'application/json' );

sub base : Chained('/api/upload/base') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub configuration : Chained('base') : PathPart('budgets') : Args(0)
  : ActionClass('REST') {

}

sub configuration_POST {
    my ( $self, $c ) = @_;

    my %header = (
        business_name    => qr /\bnome\b/io,
        cnpj             => qr /\bsigla\b/io,
        goal_id          => qr /\blatitude\b/io,
        dedicated_value  => qr /\bvalor dedicado\b/io,
        liquidated_value => qr /\bvalor liquidado\b/io,
        observation      => qr /\bobserva..o\b/io,
        contract_code    => qr /\bc.digo de contrato\b/io,
        dedicated_year   => qr /\bano dedicado\b/io,
        organ_code       => qr /\bc.digo da organiza..o\b/io,
        organ_name       => qr /\bnome da organiza..o\b/io,
        company_id       => qr /\bid da empresa\b/io,
        cod_emp          => qr /\bc.digo de empenho\b/io,
    );
    $c->stash->{db}       = $c->model('DB::Budget');
    $c->stash->{header}   = \%header;
    $c->stash->{validate} = sub {
        my $line = shift;
        my $dv   = Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                business_name    => { required => 1, type => 'Str' },
                cnpj             => { required => 0, type => 'Str' },
                goal_id          => { required => 0, type => 'Int' },
                dedicated_value  => { required => 0, type => 'Int' },
                liquidated_value => { required => 0, type => 'Int' },
                observation      => { required => 0, type => 'Str' },
                contract_code    => { required => 0, type => 'Str' },
                dedicated_year   => { required => 0, type => 'Int' },
                organ_code       => { required => 0, type => 'Int' },
                organ_name       => { required => 0, type => 'Str' },
                company_id       => { required => 0, type => 'Int' },
                cod_emp          => { required => 0, type => 'Str' },
            }
        );
        my $results = $dv->verify($line);

        return 1 if $results->success;

        my @res = $results->invalids;
        my @message;
        push @message, $results->get_field($_)->original_value for @res;

        return \@message if @message;

    };
    $c->forward('/api/uploadfile/do');
}

1;
