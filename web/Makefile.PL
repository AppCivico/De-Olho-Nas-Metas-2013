#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'WebSMM';
all_from 'lib/WebSMM.pm';

requires 'Catalyst::Runtime' => '5.90042';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::StatusMessage';
requires 'Catalyst::Plugin::Session::DynamicExpiry';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Catalyst::Plugin::Session::PerUser';

requires 'Catalyst::Plugin::Session::Store::File';

requires 'Catalyst::Plugin::Assets';
requires 'Catalyst::Plugin::StatusMessage';
requires 'DateTime::Format::DateParse';

requires 'Catalyst::Plugin::Authentication';

requires 'Catalyst::Plugin::Session::DynamicExpiry';
requires 'Catalyst::Plugin::Session';

requires 'Catalyst::Plugin::Session::Store::File';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::PerUser';

requires 'Template::AutoFilter';
requires 'Furl';
requires 'Catalyst::Helper::View::Email'; 
requires 'File::MoreUtil';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;



