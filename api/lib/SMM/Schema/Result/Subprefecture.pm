use utf8;

package SMM::Schema::Result::Subprefecture;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SMM::Schema::Result::Subprefecture

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

__PACKAGE__->load_components( "InflateColumn::DateTime", "TimeStamp",
    "PassphraseColumn" );

=head1 TABLE: C<subprefecture>

=cut

__PACKAGE__->table("subprefecture");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'subprefecture_id_seq'

=head2 acronym

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 latitude

  data_type: 'text'
  is_nullable: 1

=head2 longitude

  data_type: 'text'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 site

  data_type: 'text'
  is_nullable: 1

=head2 deputy_mayor

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 telephone

  data_type: 'text'
  is_nullable: 1

=head2 address

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
    "id",
    {
        data_type         => "integer",
        is_auto_increment => 1,
        is_nullable       => 0,
        sequence          => "subprefecture_id_seq",
    },
    "acronym",
    { data_type => "text", is_nullable => 1 },
    "name",
    { data_type => "text", is_nullable => 0 },
    "latitude",
    { data_type => "text", is_nullable => 1 },
    "longitude",
    { data_type => "text", is_nullable => 1 },
    "timestamp",
    {
        data_type     => "timestamp",
        default_value => \"current_timestamp",
        is_nullable   => 1,
        original      => { default_value => \"now()" },
    },
    "site",
    { data_type => "text", is_nullable => 1 },
    "deputy_mayor",
    { data_type => "text", is_nullable => 1 },
    "email",
    { data_type => "text", is_nullable => 1 },
    "telephone",
    { data_type => "text", is_nullable => 1 },
    "address",
    { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 organizations

Type: has_many

Related object: L<SMM::Schema::Result::Organization>

=cut

__PACKAGE__->has_many(
    "organizations",
    "SMM::Schema::Result::Organization",
    { "foreign.subprefecture_id" => "self.id" },
    { cascade_copy               => 0, cascade_delete => 0 },
);

=head2 regions

Type: has_many

Related object: L<SMM::Schema::Result::Region>

=cut

__PACKAGE__->has_one(
    "regions", "SMM::Schema::Result::Region",
    { "foreign.subprefecture_id" => "self.id" },
    { cascade_copy               => 0, cascade_delete => 0 },
);

# Created by DBIx::Class::Schema::Loader v0.07041 @ 2015-02-24 11:38:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DAI7nyLh3SlTWjuaYUYAzA

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
                name => {
                    required => 0,
                    type     => 'Str',
                },
                acronym => {
                    required => 0,
                    type     => 'Str',
                },
                latitude => {
                    required => 0,
                    type     => 'Str',
                },
                longitude => {
                    required => 0,
                    type     => 'Str',
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

            my $subprefecture = $self->update( \%values );

            return $subprefecture;
        }
    };
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
