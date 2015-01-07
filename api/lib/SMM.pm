package SMM;
use Moose;
use namespace::autoclean;
use Sys::Hostname;
use Catalyst::Runtime 5.90042;
use open qw(:std :utf8);

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
  ConfigLoader
  Static::Simple

  Authentication
  Authorization::Roles

  /;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in pi_pcs.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

my $user = $ENV{USER};
my $host = Sys::Hostname::hostname();

__PACKAGE__->config(
    name     => 'SMM',
    encoding => 'UTF-8',

    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header                      => 1,   # Send X-Catalyst header

    'Plugin::ConfigLoader' => {
         driver              => { General => { -ForceArray => 1, } },
         config_local_suffix => "${user}_${host}",
         file => __PACKAGE__->path_to('conf')
     },
);

after 'setup_components' => sub {
    my $app = shift;
    for ( keys %{ $app->components } ) {
        if ( $app->components->{$_}->can('initialize_after_setup') ) {
            $app->components->{$_}->initialize_after_setup($app);
        }
    }

};

after setup_finalize => sub {
    my $app = shift;

    for ( $app->registered_plugins ) {
        if ( $_->can('initialize_after_setup') ) {
            $_->initialize_after_setup($app);
        }
    }
};

# Start the application
__PACKAGE__->setup();

=head1 NAME

SMM - Catalyst based application

=head1 SYNOPSIS

    script/pi_pcs_server.pl

=head1 SEE ALSO

L<SMM::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Renato CRON

=head1 LICENSE

This library is private software.

=cut

1;
