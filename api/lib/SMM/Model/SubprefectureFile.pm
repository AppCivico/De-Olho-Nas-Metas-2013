package SMM::Model::SubprefectureFile;
use Moose;
use utf8;
use JSON::MaybeXS;

use SMM::Model::File::XLSX;
use SMM::Model::File::XLS;
use SMM::Model::File::CSV;

sub process {
    my ( $self, %param ) = @_;

    my $upload = $param{upload};
    my $schema = $param{schema};

    my $parse;
    eval {
        if ( $upload->filename =~ /xlsx$/ ) {
            $parse = SMM::Model::File::FileXLSX->new->parse( $upload->tempname );
        }
        elsif ( $upload->filename =~ /xls$/ ) {
            $parse = SMM::Model::File::XLS->new->parse( $upload->tempname );
        }
        elsif ( $upload->filename =~ /csv$/ ) {
            $parse = SMM::Model::File::FileCSV->new->parse( $upload->tempname );
        }
    };
    die "FATAL ERROR: $@" if $@;
    die 'not supported filetype' unless $parse;

    my $status = $@ ? { error => "$@" }: undef;

    $status->{accepted} = $parse->{ok};
    $status->{ignored} = $parse->{ignored} if $parse->{ignored};
    $status->{error} = 'header_found' unless $parse->{header_found};

    $status->{original_filename} = $upload->filename;

    my $file_id;

    my $user_id = $param{user_id};
    my $file    = $schema->resultset('ImeiFile')->create(
        {
            status      => (encode_json $status),
            user_id     => $user_id
        }
    );
    $file_id = $file->id;

    # is ok
    if ($parse && $parse->{rows}){
        for my $r (@{$parse->{rows}}){
            my $imei = $r->{imei};
            die \['archive', "too long imei: $imei"] if length $imei > 15;
            die \['archive', "too short imei: $imei"] if length $imei < 14;
        }

        eval{
            $schema->txn_do(
                sub {
                    my $dbh = $schema->storage->dbh;

                    my $quotechar = "\x{11}";    # Vertical tab (ASCII 11)

                    for my $r (@{$parse->{rows}}){
						p $r;
                        my $imei = $r->{imei};
                    }

                }
            );
        };

        $status->{error} = $@ if $@;

        $file->update( { status => encode_json $status } ) if $@;

    }

    return {
        status  => $status,
        file_id => $file_id
    };

}

sub _verify_variable_type {
    my ( $self, $value, $type ) = @_;

    return $value if $type eq 'str';

    # certo, entao agora o type é int ou num.

    # vamos tratar o caso mais comum, que é [0-9]{1,3}\.[0-9]{1,3},[0-9]
    if ( $value =~ /[0-9]{1,3}\.[0-9]{1,3},[0-9]{1,9}$/ ) {
        $value =~ s/\.//g;
        $value =~ s/,/./;
    }

    # valores só com virgula.. eh . no banco..
    elsif ( $value =~ /^[0-9]{1,15},[0-9]{1,9}$/ ) {

        $value =~ s/,/./;
    }

    # e agora o inverso... usou , e depois um .
    elsif ( $value =~ /[0-9]{1,3}\,[0-9]{1,3}.[0-9]{1,9}$/ ) {
        $value =~ s/,//g;
        $value =~ s/\./,/;
    }

    # se parece com numero ?
    if ( $value =~ /^[0-9]{1,15}\.[0-9]{1,9}$/ || $value =~ /^[0-9]{1,15}$/ ) {

        $value = int($value) if $type eq 'int';

        return $value;
    }

    # retorna undef.
    undef();
}

1;
