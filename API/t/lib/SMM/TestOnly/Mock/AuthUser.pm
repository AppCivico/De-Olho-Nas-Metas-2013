package SMM::TestOnly::Mock::AuthUser;
use strict;
use warnings;
use base qw/Catalyst::Authentication::User/;
use List::MoreUtils qw(any all);

our $_id;
our @_roles;

sub roles { return @_roles; }

sub id {
    return $_id;
}

sub supports {
    shift;
    return 0 if any { $_ =~ /self_check/ } @_;
    return 1;
}

1;
