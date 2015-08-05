use utf8;
use strict;
use warnings;
use HTTP::Tiny;
use HTTP::Request::Common qw(POST);
use HTTP::CookieJar;
use Path::Tiny;
use DDP;
use Mojo::DOM;
use Text2URI;
use Business::BR::CNPJ;
use Business::BR::CPF;

my $t = Text2URI->new();

my $ano  = 2014;
my $cnpj = "11.958.828/0001-73";

my $url =
"http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx";

my $jar_file = path("jar.txt");
$jar_file->touch;

my $jar = HTTP::CookieJar->new->load_cookies( $jar_file->lines );
my $ua  = HTTP::Tiny->new(
    cookie_jar => $jar,
    agent =>
"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:39.0) Gecko/20100101 Firefox/39.0"
);

my $res = $ua->request( 'GET', $url, {} );

#p $res;

#   set-cookie         "ASP.NET_SessionId=abr0op0rfphftfomh1gqh3mr; path=/; HttpOnly",

my $dom = Mojo::DOM->new( $res->{content} );

my $form = [
    __VIEWSTATE   => $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
    __EVENTTARGET => 'ctl00$ContentPlaceHolder1$rdCNPJ',
    __EVENTARGUMENT =>
      $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
    __LASTFOCUS => $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
    __VIEWSTATEGENERATOR =>
      $dom->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
    __VIEWSTATEENCRYPTED =>
      $dom->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
    __EVENTVALIDATION =>
      $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
    'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => '4',
    'ctl00$ContentPlaceHolder1$CPFCNPJ'         => 'rdCNPJ',
    'ctl00$ContentPlaceHolder1$ddlAno'          => 0,
    'ctl00$ContentPlaceHolder1$hid_tooltip'     => '',
    'ctl00$ContentPlaceHolder1$txtFornecedor'   => '',
];

$res = $ua->request(
    'POST',
'http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx',
    {
        headers => {
            referer        => $url,
            'Content-Type' => 'application/x-www-form-urlencoded',
        },
        content => POST( '', [], Content => $form )->content
    }
);

#p $res;

# VAI DIGITAR CNPJ

my $dom = Mojo::DOM->new( $res->{content} );

my $form = [
    __VIEWSTATE   => $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
    __EVENTTARGET => 'ctl00$ContentPlaceHolder1$rdCNPJ',
    __EVENTARGUMENT =>
      $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
    __LASTFOCUS => $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
    __VIEWSTATEGENERATOR =>
      $dom->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
    __VIEWSTATEENCRYPTED =>
      $dom->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
    __EVENTVALIDATION =>
      $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
    'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => '4',
    'ctl00$ContentPlaceHolder1$CPFCNPJ'         => 'rdCNPJ',
    'ctl00$ContentPlaceHolder1$ddlAno'          => 0,
    'ctl00$ContentPlaceHolder1$hid_tooltip'     => '',
    'ctl00$ContentPlaceHolder1$txtFornecedor'   => '',
];

$res = $ua->request(
    'POST',
'http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx',
    {
        headers => {
            referer        => $url,
            'Content-Type' => 'application/x-www-form-urlencoded',
        },
        content => POST( '', [], Content => $form )->content
    }
);

my $dom = Mojo::DOM->new( $res->{content} );

my $form = [
    __VIEWSTATE   => $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
    __EVENTTARGET => $dom->find('[id="__EVENTTARGET"]')->first->attr('value'),
    __EVENTARGUMENT =>
      $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
    __LASTFOCUS => $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
    __VIEWSTATEGENERATOR =>
      $dom->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
    __VIEWSTATEENCRYPTED =>
      $dom->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
    __EVENTVALIDATION =>
      $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
    'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => '4',
    'ctl00$ContentPlaceHolder1$CPFCNPJ'         => 'rdCNPJ',
    'ctl00$ContentPlaceHolder1$txtCNPJ'         => $cnpj,
    'ctl00$ContentPlaceHolder1$ddlAno'          => $ano,
    'ctl00$ContentPlaceHolder1$ImgPesquisar.x'  => '20',
    'ctl00$ContentPlaceHolder1$ImgPesquisar.y'  => '34',
    'ctl00$ContentPlaceHolder1$hid_tooltip'     => '',
];

#p $form;

$res = $ua->request(
    'POST',
'http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx',
    {
        headers => {
            referer        => $url,
            'Content-Type' => 'application/x-www-form-urlencoded',
        },
        content => POST( '', [], Content => $form )->content
    }
);

#p $res;

my $dom = Mojo::DOM->new( $res->{content} );

my $docs = [];

for my $e ( $dom->find('#ctl00_ContentPlaceHolder1_grdContratos tr')->each ) {

    # say $e->{id}, ':', $e->text;
    my @tr;
    for my $td ( $e->find('td')->each ) {

        #        warn $td->find('span')->text unless $td->text;

        push @tr, $td->all_text;
    }

    # p $e->parent->find('td');
    my $item = {
        nome_orgao      => $tr[1],
        fornecedor      => $tr[2],
        objeto          => $tr[3],
        data_publicacao => $tr[4],
        data_assinatura => $tr[5],
        vigencia        => $tr[6],
        contrato        => $tr[7],
        evento          => $tr[8],
        valor           => $tr[9],
    };

    p $item;

    #push @{$docs}, $item;

    #p $docs;

    for my $td ( $e->find('td a')->each ) {
        if ( $td->attr('id') =~ m#Integra$# ) {

            my ($doc_id) =
              $td->attr('href') =~ m#javascript:__doPostBack\('([^']+)',''\)#;
            my $form = [
                __VIEWSTATE =>
                  $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
                __EVENTTARGET => $doc_id,
                __EVENTARGUMENT =>
                  $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
                __LASTFOCUS =>
                  $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
                __VIEWSTATEGENERATOR =>
                  $dom->find('[id="__VIEWSTATEGENERATOR"]')
                  ->first->attr('value'),
                __VIEWSTATEENCRYPTED =>
                  $dom->find('[id="__VIEWSTATEENCRYPTED"]')
                  ->first->attr('value'),
                __EVENTVALIDATION =>
                  $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
                'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => '4',
                'ctl00$ContentPlaceHolder1$CPFCNPJ'         => 'rdCNPJ',
                'ctl00$ContentPlaceHolder1$txtCNPJ'         => $cnpj,
                'ctl00$ContentPlaceHolder1$ddlAno'          => $ano,
                'ctl00$ContentPlaceHolder1$hid_tooltip'     => '',
            ];

            my $res1 = $ua->request(

                'POST',
'http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx',
                {
                    headers => {
                        referer =>
'http://transparenciasp.prefeitura.sp.gov.br/sj2224_contrato/PaginasPublicas/frmPesquisaContrato.aspx',
                        'Content-Type' => 'application/x-www-form-urlencoded',
                        Accept =>
'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                    },
                    content => POST( '', [], Content => $form )->content
                }
            );
            $item->{data_publicacao} =~ s/\//-/g;
            $item->{nome_orgao} = $t->translate( $item->{nome_orgao} );

            open my $fh, '>', "$item->{nome_orgao}$item->{data_publicacao}.doc"
              or die 'not open file';

            print $fh $res1->{content};

            close $fh;
            sleep 1;

            #p $res1;
        }
    }

}
