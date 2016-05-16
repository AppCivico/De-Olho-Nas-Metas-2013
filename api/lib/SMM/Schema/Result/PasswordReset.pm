use utf8;
package SMM::Schema::Result::PasswordReset;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::PasswordReset

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<password_reset>

=cut

__PACKAGE__->table("password_reset");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'password_reset_id_seq'

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 hash

  data_type: 'text'
  is_nullable: 0

=head2 expires_at

  data_type: 'timestamp'
  default_value: (now() + '7 days'::interval)
  is_nullable: 1

=head2 valid

  data_type: 'boolean'
  default_value: true
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "password_reset_id_seq",
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "hash",
  { data_type => "text", is_nullable => 0 },
  "expires_at",
  {
    data_type     => "timestamp",
    default_value => \"(now() + '7 days'::interval)",
    is_nullable   => 1,
  },
  "valid",
  { data_type => "boolean", default_value => \"true", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<SMM::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "SMM::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-13 12:05:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wvMjlyfMmOxL9Gu2Hk97qA

# You can replace this text with custom code or comments, and it will be preserved on regeneration

with 'SMM::Role::Verification';
with 'SMM::Role::Verification::TransactionalActions::DBIC';
with 'SMM::Schema::Role::ResultsetFind';

use Data::Verifier;
use MooseX::Types::Email qw/EmailAddress/;
use SMM::Types qw /DataStr TimeStr/;

sub verifiers_specs {
    my $self = shift;
    return {
        update => Data::Verifier->new(
            filters => [qw(trim)],
            profile => {
                user_id => {
                    required => 0,
                    type     => 'Int',
                },
                hash => {
                    required => 0,
                    type     => 'Str',
                },
                valid => {
                    required => 0,
                    type     => 'Bool',
                },
            }
        ),
    };
}

sub action_specs {
    my $self = shift;
    return {
        update => sub {
            my %values = shift->valid_values;

            not defined $values{$_} and delete $values{$_} for keys %values;

            my $password_reset = $self->update( \%values );

            return $password_reset;
        },

    };
}
__PACKAGE__->meta->make_immutable;
1;
