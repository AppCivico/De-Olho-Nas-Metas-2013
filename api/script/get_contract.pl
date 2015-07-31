#!/usr/bin/perl

use WWW::Mechanize::PhantomJS;
use Mojo::DOM;
use Furl;
use URI;

my $mech = WWW::Mechanize::PhantomJS->new();
use DDP;

my $url = URI->new(
"http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx"
);
my $furl = Furl->new(
    agent   => 'SMM',
    timeout => 100
);

my $res = $furl->get( $url->as_string );

my $dom = Mojo::DOM->new( $res->content );

my $params = (
    __VIEWSTATE   => $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
    __EVENTTARGET => "",
    'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => 4,
    'ctl00$ContentPlaceHolder1$hid_tooltip'     => "",
);

exit;

#p $mech->click( { selector => '#ctl00_ContentPlaceHolder1_ddlTipoPesquisa' } );
#

#p $mech->click(
#    {
#        xpath => '//select[@name="ctl00\$ContentPlaceHolder1\$ddlTipoPesquisa"]'
#    }
#);
