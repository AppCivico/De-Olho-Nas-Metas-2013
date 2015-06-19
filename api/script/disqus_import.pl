#!/usr/bin/perl
use utf8;
use Text::CSV;
use lib './lib';
use utf8;

use SMM::Schema;

use FindBin qw($Bin);
use lib "$Bin/../files";
use File::Basename;

use Catalyst::Test q(SMM);
my $config = SMM->config;

my $schema = SMM::Schema->connect(
    $config->{'Model::DB'}{connect_info}{dsn},
    $config->{'Model::DB'}{connect_info}{user},
    $config->{'Model::DB'}{connect_info}{password},{
    quote_char => q{"},
    name_sep => q{.}
}
);
use DDP; p $schema;
open( my $fh, '>', 'data/disqus_import.txt' ) or die "erro open file";

print $fh "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
print $fh
"<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\"  xmlns:dsq=\"http://www.disqus.com/\"	     xmlns:dc=\"http://purl.org/dc/elements/1.1/\"	       xmlns:wp=\"http://wordpress.org/export/1.0/\">\n";

my $csv = Text::CSV->new( { binary => 1, sep_char => ';', eol => "\r\n" }
  )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

open my $fh_csv, '<', 'data/disqus.csv'
  or die "not open";
print $fh "<channel>\n";

while ( my $row = $csv->getline($fh_csv) ) {
    use DDP;
    p $row;
    print $fh "<item>\n";

    print $fh "<title> Foo Bar </title>\n";

    print $fh "<link>http://deolhonasmetas.org.br/project/"
      . $row->[4]
      . "</link>\n";
    print $fh "<content:encoded><![CDATA[Hello World]]></content:encoded>\n";
    print $fh "<wp:post_date_gmt>2015-04-16 19:54:40</wp:post_date_gmt>\n";
    print $fh "<wp:comment_status>open</wp:comment_status>\n";
    print $fh "<wp:comment>\n";

    print $fh "<wp:comment_id>$row->[0]</wp:comment_id>\n";
    use DDP; p $row;
    p $row->[5];
    my $user =
      $schema->resultset('User')->search({ id => $row->[5]} )->next;
    p $user;	
    print $fh "<wp:comment_author>".$user->name."</wp:comment_author>\n";
    print $fh "<wp:comment_author_email>".$user->email."</wp:comment_author_email>\n";
    my @date = split /\./, $row->[2];
    print $fh "<wp:comment_date_gmt>$date[0]</wp:comment_date_gmt>\n";
    print $fh "<wp:comment_content><![CDATA[$row->[1]]]></wp:comment_content>\n";
    print $fh "<wp:comment_approved>1</wp:comment_approved>\n";

    print $fh "<wp:comment_parent>0</wp:comment_parent>\n";
    print $fh "</wp:comment>\n";
    print $fh "</item>\n";

    #    $csv->parse($_);
    #    my @fields = $csv->fields();
    #    p \@fields;
}
print $fh "</channel>\n";
print $fh "</rss>\n";
