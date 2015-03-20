package SMM::Types;
our $ONLY_DIGITY = sub { my ($val) = @_; $val =~ s/[^0-9]//g; $val };

use MooseX::Types -declare => [
    qw(
      DataStr
      TimeStr
      )
];
use MooseX::Types::Moose qw(ArrayRef HashRef CodeRef Str ScalarRef);
use Moose::Util::TypeConstraints;

use DateTime::Format::Pg;

subtype DataStr, as Str, where {
    eval { DateTime::Format::Pg->parse_datetime($_)->datetime };
    return $@ eq '';
}, message { "$_ data invalida" };

coerce DataStr, from Str, via {
    DateTime::Format::Pg->parse_datetime($_)->datetime;
};

subtype TimeStr, as Str, where {
    eval { DateTime::Format::Pg->parse_time($_)->hms };
    return $@ eq '';
}, message { "$_ data invalida" };

coerce TimeStr, from Str, via {
    DateTime::Format::Pg->parse_time($_)->hms;
};

1;
