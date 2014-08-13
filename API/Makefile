# This Makefile is for the SMM extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.98 (Revision: 69800) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Catalyst based application]
#     AUTHOR => [q[Renato CRON]]
#     BUILD_REQUIRES => { Test::More=>q[0.88], ExtUtils::MakeMaker=>q[6.36], Test::Deep=>q[0] }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[SMM]
#     EXE_FILES => [q[script/myapp_cgi.pl], q[script/myapp_create.pl], q[script/myapp_fastcgi.pl], q[script/myapp_server.pl], q[script/myapp_test.pl]]
#     NAME => q[SMM]
#     NO_META => q[1]
#     PREREQ_PM => { Catalyst::Plugin::ConfigLoader=>q[0], JSON::XS=>q[0], Crypt::PasswdMD5=>q[0], MooseX::Traits=>q[0], Catalyst::Plugin::Session::Store::FastMmap=>q[0], Catalyst::Plugin::I18N::DBI=>q[0], Catalyst::Plugin::Session::State::Cookie=>q[0], Catalyst::Plugin::Authorization::Roles=>q[0], Config::General=>q[0], Catalyst::Plugin::Params::Nested=>q[0], Catalyst::Plugin::Assets=>q[0], Text::CSV_XS=>q[0], Test::Deep=>q[0], Catalyst::Authentication::Store::DBIx::Class=>q[0], List::MoreUtils=>q[0], Statistics::Descriptive=>q[0], Catalyst::View::TT=>q[0], ExtUtils::MakeMaker=>q[6.36], DBIx::Class::PassphraseColumn=>q[0], Geo::Coder::Google=>q[0], Email::MIME=>q[0], DBD::Pg=>q[0], DateTime::Format::Duration=>q[0], DateTimeX::Easy=>q[0], Catalyst::Plugin::Session=>q[0], Test::More=>q[0.88], Catalyst::Controller::REST=>q[0], Catalyst::Model::DBIC::Schema=>q[0], Spreadsheet::XLSX=>q[0], Spreadsheet::WriteExcel=>q[0], DateTime::Duration=>q[0], Text::Iconv=>q[0], Catalyst::Component::InstancePerContext=>q[0], String::Random=>q[0], FindBin=>q[0], Email::Sender=>q[0], XML::Simple=>q[0], I18N::AcceptLanguage=>q[0], MooseX::Types::Email=>q[0], Data::Manager=>q[0], Data::Printer=>q[0], Data::Diver=>q[0], Digest::MD5=>q[0], DateTime::Format::Excel=>q[0], Moose=>q[0], namespace::autoclean=>q[0], Text2URI=>q[0], Catalyst::Plugin::Static::Simple=>q[0], Math::Expression::Evaluator=>q[0], Email::Sender::Transport::SMTP::TLS=>q[0], DBIx::Class::TimeStamp=>q[0], Template=>q[0], Catalyst::Action::RenderView=>q[0], Catalyst::Plugin::Unicode::Encoding=>q[0], Email::Sender::Simple=>q[0], Catalyst::Plugin::Authentication=>q[0], JSON=>q[0], Catalyst::Runtime=>q[5.90010], Catalyst::TraitFor::Controller::DBIC::DoesPaging=>q[0], DateTime::Format::Pg=>q[0], Spreadsheet::ParseExcel::Stream=>q[0] }
#     TEST_REQUIRES => {  }
#     VERSION => q[0.01]
#     VERSION_FROM => q[lib/SMM.pm]
#     dist => { PREOP=>q[$(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"] }
#     realclean => { FILES=>q[MYMETA.yml] }
#     test => { TESTS=>q[t/*.t t/api/user/*.t] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/5.14.4/x86_64-linux/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -O2 -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = libc-2.12.so
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 2.6.32-358.el6.x86_64
RANLIB = :
SITELIBEXP = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4
SITEARCHEXP = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/x86_64-linux
SO = so
VENDORARCHEXP = 
VENDORLIBEXP = 


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = SMM
NAME_SYM = SMM
VERSION = 0.01
VERSION_MACRO = VERSION
VERSION_SYM = 0_01
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 0.01
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1
MAN3EXT = 3
INSTALLDIRS = site
DESTDIR = 
PREFIX = $(SITEPREFIX)
PERLPREFIX = /home/devel/perl5/perlbrew/perls/perl-5.14.4
SITEPREFIX = /home/devel/perl5/perlbrew/perls/perl-5.14.4
VENDORPREFIX = 
INSTALLPRIVLIB = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/5.14.4
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = 
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/5.14.4/x86_64-linux
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/x86_64-linux
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = 
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = 
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = 
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = /home/devel/perl5/perlbrew/perls/perl-5.14.4/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = /home/devel/perl5/perlbrew/perls/perl-5.14.4/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = 
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = /home/devel/perl5/perlbrew/perls/perl-5.14.4/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = /home/devel/perl5/perlbrew/perls/perl-5.14.4/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = 
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB =
PERL_ARCHLIB = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/5.14.4/x86_64-linux
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/5.14.4/x86_64-linux/CORE
PERL = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin/perl "-Iinc"
FULLPERL = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin/perl "-Iinc"
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-Iinc" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /home/devel/perl5/perlbrew/perls/perl-5.14.4/lib/site_perl/5.14.4/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.98
MM_REVISION = 69800

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = SMM
BASEEXT = SMM
PARENT_NAME = 
DLBASE = $(BASEEXT)
VERSION_FROM = lib/SMM.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = script/myapp_cgi.pl \
	script/myapp_create.pl \
	script/myapp_fastcgi.pl \
	script/myapp_server.pl \
	script/myapp_test.pl
MAN3PODS = lib/SMM.pm \
	lib/SMM/Controller/Root.pm \
	lib/SMM/Schema/Result/Role.pm \
	lib/SMM/Schema/Result/User.pm \
	lib/SMM/Schema/Result/UserRole.pm \
	lib/SMM/Schema/Result/UserSession.pm

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)
INST_ARCHLIBDIR  = $(INST_ARCHLIB)

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = lib/SMM.pm \
	lib/SMM/Controller/API.pm \
	lib/SMM/Controller/API/User.pm \
	lib/SMM/Controller/Root.pm \
	lib/SMM/Data/Manager.pm \
	lib/SMM/Data/Visitor.pm \
	lib/SMM/Model/DB.pm \
	lib/SMM/Role/Verification.pm \
	lib/SMM/Role/Verification/TransactionalActions.pm \
	lib/SMM/Role/Verification/TransactionalActions/DBIC.pm \
	lib/SMM/Schema.pm \
	lib/SMM/Schema/Result/Role.pm \
	lib/SMM/Schema/Result/User.pm \
	lib/SMM/Schema/Result/UserRole.pm \
	lib/SMM/Schema/Result/UserSession.pm \
	lib/SMM/Schema/ResultSet/User.pm \
	lib/SMM/Schema/Role/InflateAsHashRef.pm \
	lib/SMM/Schema/Role/ResultsetFind.pm \
	lib/SMM/TraitFor/Controller/AutoBase.pm \
	lib/SMM/TraitFor/Controller/AutoList.pm \
	lib/SMM/TraitFor/Controller/AutoObject.pm \
	lib/SMM/TraitFor/Controller/AutoResult.pm \
	lib/SMM/TraitFor/Controller/CheckRoleForPOST.pm \
	lib/SMM/TraitFor/Controller/CheckRoleForPUT.pm \
	lib/SMM/TraitFor/Controller/DefaultCRUD.pm \
	lib/SMM/TraitFor/Controller/FuzzySearch.pm \
	lib/SMM/TraitFor/Controller/ListAutocomplete.pm \
	lib/SMM/TraitFor/Controller/Search.pm \
	lib/SMM/TraitFor/Controller/SimpleCRUD.pm \
	lib/SMM/Types.pm

PM_TO_BLIB = lib/SMM.pm \
	blib/lib/SMM.pm \
	lib/SMM/Controller/API.pm \
	blib/lib/SMM/Controller/API.pm \
	lib/SMM/Controller/API/User.pm \
	blib/lib/SMM/Controller/API/User.pm \
	lib/SMM/Controller/Root.pm \
	blib/lib/SMM/Controller/Root.pm \
	lib/SMM/Data/Manager.pm \
	blib/lib/SMM/Data/Manager.pm \
	lib/SMM/Data/Visitor.pm \
	blib/lib/SMM/Data/Visitor.pm \
	lib/SMM/Model/DB.pm \
	blib/lib/SMM/Model/DB.pm \
	lib/SMM/Role/Verification.pm \
	blib/lib/SMM/Role/Verification.pm \
	lib/SMM/Role/Verification/TransactionalActions.pm \
	blib/lib/SMM/Role/Verification/TransactionalActions.pm \
	lib/SMM/Role/Verification/TransactionalActions/DBIC.pm \
	blib/lib/SMM/Role/Verification/TransactionalActions/DBIC.pm \
	lib/SMM/Schema.pm \
	blib/lib/SMM/Schema.pm \
	lib/SMM/Schema/Result/Role.pm \
	blib/lib/SMM/Schema/Result/Role.pm \
	lib/SMM/Schema/Result/User.pm \
	blib/lib/SMM/Schema/Result/User.pm \
	lib/SMM/Schema/Result/UserRole.pm \
	blib/lib/SMM/Schema/Result/UserRole.pm \
	lib/SMM/Schema/Result/UserSession.pm \
	blib/lib/SMM/Schema/Result/UserSession.pm \
	lib/SMM/Schema/ResultSet/User.pm \
	blib/lib/SMM/Schema/ResultSet/User.pm \
	lib/SMM/Schema/Role/InflateAsHashRef.pm \
	blib/lib/SMM/Schema/Role/InflateAsHashRef.pm \
	lib/SMM/Schema/Role/ResultsetFind.pm \
	blib/lib/SMM/Schema/Role/ResultsetFind.pm \
	lib/SMM/TraitFor/Controller/AutoBase.pm \
	blib/lib/SMM/TraitFor/Controller/AutoBase.pm \
	lib/SMM/TraitFor/Controller/AutoList.pm \
	blib/lib/SMM/TraitFor/Controller/AutoList.pm \
	lib/SMM/TraitFor/Controller/AutoObject.pm \
	blib/lib/SMM/TraitFor/Controller/AutoObject.pm \
	lib/SMM/TraitFor/Controller/AutoResult.pm \
	blib/lib/SMM/TraitFor/Controller/AutoResult.pm \
	lib/SMM/TraitFor/Controller/CheckRoleForPOST.pm \
	blib/lib/SMM/TraitFor/Controller/CheckRoleForPOST.pm \
	lib/SMM/TraitFor/Controller/CheckRoleForPUT.pm \
	blib/lib/SMM/TraitFor/Controller/CheckRoleForPUT.pm \
	lib/SMM/TraitFor/Controller/DefaultCRUD.pm \
	blib/lib/SMM/TraitFor/Controller/DefaultCRUD.pm \
	lib/SMM/TraitFor/Controller/FuzzySearch.pm \
	blib/lib/SMM/TraitFor/Controller/FuzzySearch.pm \
	lib/SMM/TraitFor/Controller/ListAutocomplete.pm \
	blib/lib/SMM/TraitFor/Controller/ListAutocomplete.pm \
	lib/SMM/TraitFor/Controller/Search.pm \
	blib/lib/SMM/TraitFor/Controller/Search.pm \
	lib/SMM/TraitFor/Controller/SimpleCRUD.pm \
	blib/lib/SMM/TraitFor/Controller/SimpleCRUD.pm \
	lib/SMM/Types.pm \
	blib/lib/SMM/Types.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.98
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --
CP_NONEMPTY = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'cp_nonempty' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip --best
SUFFIX = .gz
SHAR = shar
PREOP = $(PERL) -I. "-MModule::Install::Admin" -e "dist_preop(q($(DISTVNAME)))"
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = tardist
DISTNAME = SMM
DISTVNAME = SMM-0.01


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:


# --- MakeMaker const_loadlibs section:


# --- MakeMaker const_cccmd section:


# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:


# --- MakeMaker xs_c section:


# --- MakeMaker xs_o section:


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(BOOTSTRAP) $(INST_DYNAMIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	lib/SMM.pm \
	lib/SMM/Controller/Root.pm \
	lib/SMM/Schema/Result/Role.pm \
	lib/SMM/Schema/Result/User.pm \
	lib/SMM/Schema/Result/UserRole.pm \
	lib/SMM/Schema/Result/UserSession.pm \
	script/myapp_cgi.pl \
	script/myapp_create.pl \
	script/myapp_fastcgi.pl \
	script/myapp_server.pl \
	script/myapp_test.pl
	$(NOECHO) $(POD2MAN) --section=1 --perm_rw=$(PERM_RW) \
	  script/myapp_cgi.pl $(INST_MAN1DIR)/myapp_cgi.pl.$(MAN1EXT) \
	  script/myapp_create.pl $(INST_MAN1DIR)/myapp_create.pl.$(MAN1EXT) \
	  script/myapp_fastcgi.pl $(INST_MAN1DIR)/myapp_fastcgi.pl.$(MAN1EXT) \
	  script/myapp_server.pl $(INST_MAN1DIR)/myapp_server.pl.$(MAN1EXT) \
	  script/myapp_test.pl $(INST_MAN1DIR)/myapp_test.pl.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=3 --perm_rw=$(PERM_RW) \
	  lib/SMM.pm $(INST_MAN3DIR)/SMM.$(MAN3EXT) \
	  lib/SMM/Controller/Root.pm $(INST_MAN3DIR)/SMM::Controller::Root.$(MAN3EXT) \
	  lib/SMM/Schema/Result/Role.pm $(INST_MAN3DIR)/SMM::Schema::Result::Role.$(MAN3EXT) \
	  lib/SMM/Schema/Result/User.pm $(INST_MAN3DIR)/SMM::Schema::Result::User.$(MAN3EXT) \
	  lib/SMM/Schema/Result/UserRole.pm $(INST_MAN3DIR)/SMM::Schema::Result::UserRole.$(MAN3EXT) \
	  lib/SMM/Schema/Result/UserSession.pm $(INST_MAN3DIR)/SMM::Schema::Result::UserSession.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = script/myapp_cgi.pl script/myapp_create.pl script/myapp_fastcgi.pl script/myapp_server.pl script/myapp_test.pl

pure_all :: $(INST_SCRIPT)/myapp_server.pl $(INST_SCRIPT)/myapp_create.pl $(INST_SCRIPT)/myapp_cgi.pl $(INST_SCRIPT)/myapp_fastcgi.pl $(INST_SCRIPT)/myapp_test.pl
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/myapp_server.pl $(INST_SCRIPT)/myapp_create.pl \
	  $(INST_SCRIPT)/myapp_cgi.pl $(INST_SCRIPT)/myapp_fastcgi.pl \
	  $(INST_SCRIPT)/myapp_test.pl 

$(INST_SCRIPT)/myapp_server.pl : script/myapp_server.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/myapp_server.pl
	$(CP) script/myapp_server.pl $(INST_SCRIPT)/myapp_server.pl
	$(FIXIN) $(INST_SCRIPT)/myapp_server.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/myapp_server.pl

$(INST_SCRIPT)/myapp_create.pl : script/myapp_create.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/myapp_create.pl
	$(CP) script/myapp_create.pl $(INST_SCRIPT)/myapp_create.pl
	$(FIXIN) $(INST_SCRIPT)/myapp_create.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/myapp_create.pl

$(INST_SCRIPT)/myapp_cgi.pl : script/myapp_cgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/myapp_cgi.pl
	$(CP) script/myapp_cgi.pl $(INST_SCRIPT)/myapp_cgi.pl
	$(FIXIN) $(INST_SCRIPT)/myapp_cgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/myapp_cgi.pl

$(INST_SCRIPT)/myapp_fastcgi.pl : script/myapp_fastcgi.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/myapp_fastcgi.pl
	$(CP) script/myapp_fastcgi.pl $(INST_SCRIPT)/myapp_fastcgi.pl
	$(FIXIN) $(INST_SCRIPT)/myapp_fastcgi.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/myapp_fastcgi.pl

$(INST_SCRIPT)/myapp_test.pl : script/myapp_test.pl $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/myapp_test.pl
	$(CP) script/myapp_test.pl $(INST_SCRIPT)/myapp_test.pl
	$(FIXIN) $(INST_SCRIPT)/myapp_test.pl
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/myapp_test.pl



# --- MakeMaker subdirs section:

# none

# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  $(BASEEXT).bso $(BASEEXT).def \
	  $(BASEEXT).exp $(BASEEXT).x \
	  $(BOOTSTRAP) $(INST_ARCHAUTODIR)/extralibs.all \
	  $(INST_ARCHAUTODIR)/extralibs.ld $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) *$(OBJ_EXT) \
	  *perl.core MYMETA.json \
	  MYMETA.yml blibdirs.ts \
	  core core.*perl.*.? \
	  core.[0-9] core.[0-9][0-9] \
	  core.[0-9][0-9][0-9] core.[0-9][0-9][0-9][0-9] \
	  core.[0-9][0-9][0-9][0-9][0-9] lib$(BASEEXT).def \
	  mon.out perl \
	  perl$(EXE_EXT) perl.exe \
	  perlmain.c pm_to_blib \
	  pm_to_blib.ts so_locations \
	  tmon.out 
	- $(RM_RF) \
	  blib 
	  $(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	$(NOECHO) $(NOOP)


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  MYMETA.yml $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)_uu'

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).tar$(SUFFIX)'
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).zip'
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(NOECHO) $(ECHO) 'Created $(DISTVNAME).shar'
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.yml to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.json to MANIFEST: $$$${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLARCHLIB)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) $(MOD_INSTALL) \
		read $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLVENDORARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)


doc_perl_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLPRIVLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod

doc_vendor_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLARCHLIB)/perllocal.pod
	-$(NOECHO) $(MKPATH) $(DESTINSTALLARCHLIB)
	-$(NOECHO) $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLVENDORLIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLARCHLIB)/perllocal.pod


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::
	$(NOECHO) $(UNINSTALL) $(PERL_ARCHLIB)/auto/$(FULLEXT)/.packlist

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::
	$(NOECHO) $(UNINSTALL) $(VENDORARCHEXP)/auto/$(FULLEXT)/.packlist


# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /home/devel/perl5/perlbrew/perls/perl-5.14.4/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR= \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t t/api/user/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness($(TEST_VERBOSE), 'inc', '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-Iinc" "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: test_dynamic
testdb_static :: testdb_dynamic


# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="$(VERSION)">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Catalyst based application</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Renato CRON</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Action::RenderView" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Authentication::Store::DBIx::Class" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Component::InstancePerContext" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Controller::REST" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Model::DBIC::Schema" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Assets" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authentication" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Authorization::Roles" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::ConfigLoader" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::I18N::DBI" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Params::Nested" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::State::Cookie" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Session::Store::FastMmap" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Static::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Plugin::Unicode::Encoding" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::Runtime" VERSION="5.9001" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::TraitFor::Controller::DBIC::DoesPaging" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Catalyst::View::TT" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Config::General" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Crypt::PasswdMD5" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBD::Pg" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBIx::Class::PassphraseColumn" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DBIx::Class::TimeStamp" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Diver" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Manager" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Printer" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTime::Duration" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTime::Format::Duration" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTime::Format::Excel" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTime::Format::Pg" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="DateTimeX::Easy" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Digest::MD5" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Email::MIME" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Email::Sender" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Email::Sender::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Email::Sender::Transport::SMTP::TLS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="FindBin::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Geo::Coder::Google" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="I18N::AcceptLanguage" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="JSON::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="JSON::XS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="List::MoreUtils" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Math::Expression::Evaluator" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Moose::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="MooseX::Traits" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="MooseX::Types::Email" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Spreadsheet::ParseExcel::Stream" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Spreadsheet::WriteExcel" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Spreadsheet::XLSX" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Statistics::Descriptive" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="String::Random" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Template::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Text2URI::" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Text::CSV_XS" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Text::Iconv" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="XML::Simple" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="namespace::autoclean" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="x86_64-linux-5.14" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  lib/SMM.pm blib/lib/SMM.pm \
	  lib/SMM/Controller/API.pm blib/lib/SMM/Controller/API.pm \
	  lib/SMM/Controller/API/User.pm blib/lib/SMM/Controller/API/User.pm \
	  lib/SMM/Controller/Root.pm blib/lib/SMM/Controller/Root.pm \
	  lib/SMM/Data/Manager.pm blib/lib/SMM/Data/Manager.pm \
	  lib/SMM/Data/Visitor.pm blib/lib/SMM/Data/Visitor.pm \
	  lib/SMM/Model/DB.pm blib/lib/SMM/Model/DB.pm \
	  lib/SMM/Role/Verification.pm blib/lib/SMM/Role/Verification.pm \
	  lib/SMM/Role/Verification/TransactionalActions.pm blib/lib/SMM/Role/Verification/TransactionalActions.pm \
	  lib/SMM/Role/Verification/TransactionalActions/DBIC.pm blib/lib/SMM/Role/Verification/TransactionalActions/DBIC.pm \
	  lib/SMM/Schema.pm blib/lib/SMM/Schema.pm \
	  lib/SMM/Schema/Result/Role.pm blib/lib/SMM/Schema/Result/Role.pm \
	  lib/SMM/Schema/Result/User.pm blib/lib/SMM/Schema/Result/User.pm \
	  lib/SMM/Schema/Result/UserRole.pm blib/lib/SMM/Schema/Result/UserRole.pm \
	  lib/SMM/Schema/Result/UserSession.pm blib/lib/SMM/Schema/Result/UserSession.pm \
	  lib/SMM/Schema/ResultSet/User.pm blib/lib/SMM/Schema/ResultSet/User.pm \
	  lib/SMM/Schema/Role/InflateAsHashRef.pm blib/lib/SMM/Schema/Role/InflateAsHashRef.pm \
	  lib/SMM/Schema/Role/ResultsetFind.pm blib/lib/SMM/Schema/Role/ResultsetFind.pm \
	  lib/SMM/TraitFor/Controller/AutoBase.pm blib/lib/SMM/TraitFor/Controller/AutoBase.pm \
	  lib/SMM/TraitFor/Controller/AutoList.pm blib/lib/SMM/TraitFor/Controller/AutoList.pm \
	  lib/SMM/TraitFor/Controller/AutoObject.pm blib/lib/SMM/TraitFor/Controller/AutoObject.pm \
	  lib/SMM/TraitFor/Controller/AutoResult.pm blib/lib/SMM/TraitFor/Controller/AutoResult.pm \
	  lib/SMM/TraitFor/Controller/CheckRoleForPOST.pm blib/lib/SMM/TraitFor/Controller/CheckRoleForPOST.pm \
	  lib/SMM/TraitFor/Controller/CheckRoleForPUT.pm blib/lib/SMM/TraitFor/Controller/CheckRoleForPUT.pm \
	  lib/SMM/TraitFor/Controller/DefaultCRUD.pm blib/lib/SMM/TraitFor/Controller/DefaultCRUD.pm \
	  lib/SMM/TraitFor/Controller/FuzzySearch.pm blib/lib/SMM/TraitFor/Controller/FuzzySearch.pm \
	  lib/SMM/TraitFor/Controller/ListAutocomplete.pm blib/lib/SMM/TraitFor/Controller/ListAutocomplete.pm \
	  lib/SMM/TraitFor/Controller/Search.pm blib/lib/SMM/TraitFor/Controller/Search.pm \
	  lib/SMM/TraitFor/Controller/SimpleCRUD.pm blib/lib/SMM/TraitFor/Controller/SimpleCRUD.pm \
	  lib/SMM/Types.pm blib/lib/SMM/Types.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:


# End.
# Postamble by Module::Install 1.10
# --- Module::Install::Admin::Makefile section:

realclean purge ::
	$(RM_F) $(DISTVNAME).tar$(SUFFIX)
	$(RM_F) MANIFEST.bak _build
	$(PERL) "-Ilib" "-MModule::Install::Admin" -e "remove_meta()"
	$(RM_RF) inc

reset :: purge

upload :: test dist
	cpan-upload -verbose $(DISTVNAME).tar$(SUFFIX)

grok ::
	perldoc Module::Install

distsign ::
	cpansign -s

# --- Module::Install::AutoInstall section:

config :: installdeps
	$(NOECHO) $(NOOP)

checkdeps ::
	$(PERL) Makefile.PL --checkdeps

installdeps ::
	$(PERL) Makefile.PL --config= --installdeps=Catalyst::Plugin::Assets,0,XML::Simple,0

installdeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --installdeps=Catalyst::Plugin::Assets,0,XML::Simple,0

upgradedeps ::
	$(PERL) Makefile.PL --config= --upgradedeps=Catalyst::Plugin::Assets,0,XML::Simple,0,Test::More,0.88,Test::Deep,0,Catalyst::Runtime,5.90010,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Model::DBIC::Schema,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Authorization::Roles,0,Catalyst::Plugin::Session,0,Catalyst::Plugin::Session::Store::FastMmap,0,Catalyst::Plugin::Session::State::Cookie,0,Catalyst::Plugin::I18N::DBI,0,I18N::AcceptLanguage,0,Catalyst::Authentication::Store::DBIx::Class,0,Catalyst::Component::InstancePerContext,0,Catalyst::Plugin::Params::Nested,0,Catalyst::Controller::REST,0,Catalyst::TraitFor::Controller::DBIC::DoesPaging,0,DBIx::Class::PassphraseColumn,0,DBIx::Class::TimeStamp,0,Moose,0,namespace::autoclean,0,MooseX::Types::Email,0,Data::Diver,0,Data::Printer,0,Data::Manager,0,FindBin,0,JSON,0,JSON::XS,0,List::MoreUtils,0,String::Random,0,Crypt::PasswdMD5,0,DateTime::Duration,0,Catalyst::Plugin::Unicode::Encoding,0,DateTime::Format::Duration,0,DateTimeX::Easy,0,DateTime::Format::Pg,0,Catalyst::View::TT,0,Geo::Coder::Google,0,Text::Iconv,0,Email::Sender,0,Email::Sender::Simple,0,Spreadsheet::WriteExcel,0,Email::Sender::Transport::SMTP::TLS,0,Email::MIME,0,Spreadsheet::XLSX,0,Spreadsheet::ParseExcel::Stream,0,DateTime::Format::Excel,0,Math::Expression::Evaluator,0,Template,0,Text::CSV_XS,0,Digest::MD5,0,Text2URI,0,MooseX::Traits,0,DBD::Pg,0,Statistics::Descriptive,0,Config::General,0

upgradedeps_notest ::
	$(PERL) Makefile.PL --config=notest,1 --upgradedeps=Catalyst::Plugin::Assets,0,XML::Simple,0,Test::More,0.88,Test::Deep,0,Catalyst::Runtime,5.90010,Catalyst::Plugin::ConfigLoader,0,Catalyst::Plugin::Static::Simple,0,Catalyst::Action::RenderView,0,Catalyst::Model::DBIC::Schema,0,Catalyst::Plugin::Authentication,0,Catalyst::Plugin::Authorization::Roles,0,Catalyst::Plugin::Session,0,Catalyst::Plugin::Session::Store::FastMmap,0,Catalyst::Plugin::Session::State::Cookie,0,Catalyst::Plugin::I18N::DBI,0,I18N::AcceptLanguage,0,Catalyst::Authentication::Store::DBIx::Class,0,Catalyst::Component::InstancePerContext,0,Catalyst::Plugin::Params::Nested,0,Catalyst::Controller::REST,0,Catalyst::TraitFor::Controller::DBIC::DoesPaging,0,DBIx::Class::PassphraseColumn,0,DBIx::Class::TimeStamp,0,Moose,0,namespace::autoclean,0,MooseX::Types::Email,0,Data::Diver,0,Data::Printer,0,Data::Manager,0,FindBin,0,JSON,0,JSON::XS,0,List::MoreUtils,0,String::Random,0,Crypt::PasswdMD5,0,DateTime::Duration,0,Catalyst::Plugin::Unicode::Encoding,0,DateTime::Format::Duration,0,DateTimeX::Easy,0,DateTime::Format::Pg,0,Catalyst::View::TT,0,Geo::Coder::Google,0,Text::Iconv,0,Email::Sender,0,Email::Sender::Simple,0,Spreadsheet::WriteExcel,0,Email::Sender::Transport::SMTP::TLS,0,Email::MIME,0,Spreadsheet::XLSX,0,Spreadsheet::ParseExcel::Stream,0,DateTime::Format::Excel,0,Math::Expression::Evaluator,0,Template,0,Text::CSV_XS,0,Digest::MD5,0,Text2URI,0,MooseX::Traits,0,DBD::Pg,0,Statistics::Descriptive,0,Config::General,0

listdeps ::
	@$(PERL) -le "print for @ARGV" Catalyst::Plugin::Assets XML::Simple

listalldeps ::
	@$(PERL) -le "print for @ARGV" Catalyst::Plugin::Assets XML::Simple Test::More Test::Deep Catalyst::Runtime Catalyst::Plugin::ConfigLoader Catalyst::Plugin::Static::Simple Catalyst::Action::RenderView Catalyst::Model::DBIC::Schema Catalyst::Plugin::Authentication Catalyst::Plugin::Authorization::Roles Catalyst::Plugin::Session Catalyst::Plugin::Session::Store::FastMmap Catalyst::Plugin::Session::State::Cookie Catalyst::Plugin::I18N::DBI I18N::AcceptLanguage Catalyst::Authentication::Store::DBIx::Class Catalyst::Component::InstancePerContext Catalyst::Plugin::Params::Nested Catalyst::Controller::REST Catalyst::TraitFor::Controller::DBIC::DoesPaging DBIx::Class::PassphraseColumn DBIx::Class::TimeStamp Moose namespace::autoclean MooseX::Types::Email Data::Diver Data::Printer Data::Manager FindBin JSON JSON::XS List::MoreUtils String::Random Crypt::PasswdMD5 DateTime::Duration Catalyst::Plugin::Unicode::Encoding DateTime::Format::Duration DateTimeX::Easy DateTime::Format::Pg Catalyst::View::TT Geo::Coder::Google Text::Iconv Email::Sender Email::Sender::Simple Spreadsheet::WriteExcel Email::Sender::Transport::SMTP::TLS Email::MIME Spreadsheet::XLSX Spreadsheet::ParseExcel::Stream DateTime::Format::Excel Math::Expression::Evaluator Template Text::CSV_XS Digest::MD5 Text2URI MooseX::Traits DBD::Pg Statistics::Descriptive Config::General

