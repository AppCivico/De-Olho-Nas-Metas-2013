package Crawler::Data;
use Moose;
use HTTP::Request::Common qw(POST);
use Business::BR::CPF qw/test_cpf format_cpf/;
use Business::BR::CNPJ qw/test_cnpj format_cnpj/;

has 'view_state'           => ( is => 'rw', isa => 'Str' );
has 'event_target'         => ( is => 'rw', isa => 'Str' );
has 'event_argument'       => ( is => 'rw', isa => 'Str' );
has 'last_focus'           => ( is => 'rw', isa => 'Str' );
has 'view_state_generator' => ( is => 'rw', isa => 'Str' );
has 'view_state_encrypted' => ( is => 'rw', isa => 'Str' );
has 'event_validation'     => ( is => 'rw', isa => 'Str' );
has 'search_type'          => ( is => 'rw', isa => 'Int' );
has 'number'               => ( is => 'rw', );
has 'tag'                  => ( is => 'rw', );
has 'cpf_cnpj'             => ( is => 'rw', isa => 'Str' );
has 'year'                 => ( is => 'rw', isa => 'Int' );
has 'ua'                   => ( is => 'rw' );
has 'document'             => ( is => 'rw', isa => 'Int' );
has 'event_txt'            => ( is => 'rw', isa => 'Str' );

sub BUILD {
    my $self = shift;
    if ( test_cpf( $self->cpf_cnpj ) ) {
        $self->cpf_cnpj( format_cpf( $self->cpf_cnpj ) );
        $self->event_target('ctl00$ContentPlaceHolder1$rdCPF')
          unless $self->event_target;
        $self->event_txt('ctl00$ContentPlaceHolder1$txtCPF')
          unless $self->event_txt;
        $self->tag('rdCPF');
    }

    if ( test_cnpj( $self->cpf_cnpj ) ) {
        $self->cpf_cnpj( format_cnpj( $self->cpf_cnpj ) );
        $self->event_target('ctl00$ContentPlaceHolder1$rdCNPJ')
          unless $self->event_target;
        $self->event_txt('ctl00$ContentPlaceHolder1$txtCNPJ')
          unless $self->event_txt;
        $self->tag('rdCNPJ');
    }
}

sub process {
    my ( $self, %args ) = @_;
    my $form = [
        __VIEWSTATE          => $self->view_state,
        __EVENTTARGET        => $self->event_target,
        __EVENTARGUMENT      => $self->event_argument,
        __LASTFOCUS          => $self->last_focus,
        __VIEWSTATEGENERATOR => $self->view_state_generator,
        __VIEWSTATEENCRYPTED => $self->view_state_encrypted,
        __EVENTVALIDATION    => $self->event_validation,
        'ctl00$ContentPlaceHolder1$ddlTipoPesquisa' => $self->search_type,
        'ctl00$ContentPlaceHolder1$CPFCNPJ'         => $self->tag,
        'ctl00$ContentPlaceHolder1$hid_tooltip'     => '',
        'ctl00$ContentPlaceHolder1$txtFornecedor'   => '',
        (
            $self->year
            ? (
                $self->document
                ? (
                    $self->event_txt                   => $self->cpf_cnpj,
                    'ctl00$ContentPlaceHolder1$ddlAno' => $self->year,
                  )
                : (
                    'ctl00$ContentPlaceHolder1$ImgPesquisar.x' => '20',
                    'ctl00$ContentPlaceHolder1$ImgPesquisar.y' => '34',
                    $self->event_txt                   => $self->cpf_cnpj,
                    'ctl00$ContentPlaceHolder1$ddlAno' => $self->year,
                )
              )
            : ( 'ctl00$ContentPlaceHolder1$ddlAno' => 0 )
        ),
    ];

    my $res;
    $res = $self->ua->request(
        'POST',
        $args{url},
        {
            headers => {
                referer        => $args{url},
                'Content-Type' => 'application/x-www-form-urlencoded',
                (
                    $self->document
                    ? ( Accept =>
'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
                      )
                    : ()
                )
            },
            content => POST( '', [], Content => $form )->content
        }
    );

    return $res;

}

package Crawler;

use utf8;
use strict;
use warnings;

#use Business::BR::CNPJ;
#use Business::BR::CPF;
use FindBin qw($Bin);
use lib "$Bin/../files";
use Crawler::Data;
use DDP;
use HTTP::Tiny;
use HTTP::CookieJar;
use Path::Tiny;
use Mojo::DOM;
use Text2URI;
use URI;
use SMM::Schema;
use Business::BR::CPF;
use Business::BR::CNPJ;
use Path::Class qw(dir);
use File::Path qw/mkpath/;
use HTTP::Request::Common qw(POST);
use Term::ProgressBar;

use Catalyst::Test q(SMM);

my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password},
    {
        quote_char => q{"},
        name_sep   => q{.}
    }
);

my $t = Text2URI->new();

#my $cnpj = "11.958.828/0001-73";
#my $cnpj = "11958828000173";
#my $year = 2014;

my $jar_file = path("jar.txt");

$jar_file->touch;

my $jar = HTTP::CookieJar->new->load_cookies( $jar_file->lines );
my $ua  = HTTP::Tiny->new(
    cookie_jar => $jar,
    agent =>
"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:39.0) Gecko/20100101 Firefox/39.0"
);

my @budgets       = $schema->resultset('Company')->all;
my $scalar_budget = scalar @budgets;

my $progress = Term::ProgressBar->new($scalar_budget);
warn $scalar_budget;
my $url = URI->new("http://transparenciasp.prefeitura.sp.gov.br");

$url->path_segments( 'sj2224_contrato', 'PaginasPublicas',
    'frmPesquisaContrato.aspx' );

for my $budget (@budgets) {

    $progress->update($_);
    next
      unless test_cpf( $budget->cnpj ) || test_cnpj( $budget->cnpj );

    #next unless $budget->dedicated_year;
    for my $year (qw/2014 2015/) {
        print "cpf || cnpj: " . $budget->cnpj . "\n";
        print "ano:" . $year . "\n";

        my $res = $ua->request( 'GET', $url, {} );

        my $dom  = Mojo::DOM->new( $res->{content} );
        my $data = Crawler::Data->new(
            view_state =>
              $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
            event_argument =>
              $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
            last_focus =>
              $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
            view_state_generator =>
              $dom->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
            view_state_encrypted =>
              $dom->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
            event_validation =>
              $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
            cpf_cnpj    => $budget->cnpj,
            search_type => 4,
            ua          => $ua,
        );

        $res = $data->process( url => $url );

        $dom = Mojo::DOM->new( $res->{content} );

        my $data2 = Crawler::Data->new(
            view_state =>
              $dom->find('[id="__VIEWSTATE"]')->first->attr('value'),
            event_argument =>
              $dom->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
            last_focus =>
              $dom->find('[id="__LASTFOCUS"]')->first->attr('value'),
            view_state_generator =>
              $dom->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
            view_state_encrypted =>
              $dom->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
            event_validation =>
              $dom->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
            cpf_cnpj    => $budget->cnpj,
            search_type => 4,
            ua          => $ua,
        );
        $res = $data2->process( url => $url );
        my $dom2 = Mojo::DOM->new( $res->{content} );

        my $data3 = Crawler::Data->new(
            view_state =>
              $dom2->find('[id="__VIEWSTATE"]')->first->attr('value'),
            event_target =>
              $dom2->find('[id="__EVENTTARGET"]')->first->attr('value'),
            event_argument =>
              $dom2->find('[id="__EVENTARGUMENT"]')->first->attr('value'),
            last_focus =>
              $dom2->find('[id="__LASTFOCUS"]')->first->attr('value'),
            view_state_generator =>
              $dom2->find('[id="__VIEWSTATEGENERATOR"]')->first->attr('value'),
            view_state_encrypted =>
              $dom2->find('[id="__VIEWSTATEENCRYPTED"]')->first->attr('value'),
            event_validation =>
              $dom2->find('[id="__EVENTVALIDATION"]')->first->attr('value'),
            cpf_cnpj    => $budget->cnpj,
            search_type => 4,
            year        => $year,
            ua          => $ua,
        );

        $res = $data3->process( url => $url );
        my $dom3 = Mojo::DOM->new( $res->{content} );

        my @docs;

        for my $e (
            $dom3->find('#ctl00_ContentPlaceHolder1_grdContratos tr')->each )
        {

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

            for my $td ( $e->find('td a')->each ) {
                next unless $td->attr('id');
                if ( $td->attr('id') =~ m#Integra$# ) {
                    my ($doc_id) =
                      $td->attr('href') =~
                      m#javascript:__doPostBack\('([^']+)',''\)#;

                    #p $doc_id;
                    my $data4 = Crawler::Data->new(
                        view_state => $dom3->find('[id="__VIEWSTATE"]')
                          ->first->attr('value'),
                        event_target   => $doc_id,
                        event_argument => $dom3->find('[id="__EVENTARGUMENT"]')
                          ->first->attr('value'),
                        last_focus => $dom3->find('[id="__LASTFOCUS"]')
                          ->first->attr('value'),
                        view_state_generator =>
                          $dom3->find('[id="__VIEWSTATEGENERATOR"]')
                          ->first->attr('value'),
                        view_state_encrypted =>
                          $dom3->find('[id="__VIEWSTATEENCRYPTED"]')
                          ->first->attr('value'),
                        event_validation =>
                          $dom3->find('[id="__EVENTVALIDATION"]')
                          ->first->attr('value'),
                        cpf_cnpj    => $budget->cnpj,
                        search_type => 4,
                        year        => $year,
                        ua          => $ua,
                        document    => 1,
                    );

                    my $res1 = $data4->process( url => $url );
                    $item->{data_publicacao} =~ s/\//-/g;
                    $item->{nome_orgao} = $t->translate( $item->{nome_orgao} );
                    push @docs, $res1->{content};

                    my $path =
                      dir('root/static/docs')->resolve . "/" . $budget->id;

                    #p $path;
                    unless ( -e $path ) {
                        mkpath($path);
                    }
                    my $name =
                      "$item->{nome_orgao}$item->{data_publicacao}.doc";
                    my $company_doc_rs  = $schema->resultset('CompanyDocument');
                    my $company_doc_row = $$company_doc->search(
                        {
                            company_id => $budget->id,
                            url_name   => $name
                        }
                    )->next;

                    if ($company_doc_row) {
                        $company_doc_row->update{};
                    }
                    my $company_created = $company_doc->create(
                        {
                            url_name   => $name,
                            company_id => $budget->id
                        }
                    );

                    open my $fh, '>', "$path/$name"
                      or die 'not open file';
                    print $fh $res1->{content};

                    close $fh;
                    sleep 1;

                    #p $res1;
                }
            }
        }
    }
}
