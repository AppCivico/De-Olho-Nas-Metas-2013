use utf8;
package SMM::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-13 12:05:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:X76iGBov7sJi/uTa7aXqyw

sub AUTOLOAD {
    ( my $name = our $AUTOLOAD ) =~ s/.*:://;
    no strict 'refs';

    # isso cria na hora a sub e não é recompilada \m/ perl nao é lindo?!
    *$AUTOLOAD = sub {
        my ( $self, @args ) = @_;
        my $res = eval {
            $self->storage->dbh->selectrow_hashref(
                "select * from $name ( " . substr( '?,' x @args, 0, -1 ) . ')',
                undef, @args
            );
        };
        do { print $@; return undef } if $@;
        return $res;
    };
    goto &$AUTOLOAD;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable( inline_constructor => 0 );
1;


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
