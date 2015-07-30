#!/usr/bin/perl

use WWW::Mechanize::PhantomJS;
my $mech = WWW::Mechanize::PhantomJS->new();
use DDP;

my $url =
  'http://transparencia.prefeitura.sp.gov.br/contas/Paginas/Contratos-v2.aspx';

$mech->viewport_size( { width => 1388, height => 792 } );
$mech->allow( 'javascript' => 1 );
$mech->get($url);

print $mech->content;

#print $mech->content_as_png();
#print $mech->content;

#my $pdf_data = $mech->render( format => 'pdf');

#my $pdf_data = $mech->render( format => 'pdf' );
exit;
$mech->render_content(
    format   => 'jpg',
    filename => '/tmp/my.jpg',
);

#p $mech->click( { selector => '#ctl00_ContentPlaceHolder1_ddlTipoPesquisa' } );
#

#p $mech->click(
#    {
#        xpath => '//select[@name="ctl00\$ContentPlaceHolder1\$ddlTipoPesquisa"]'
#    }
#);
