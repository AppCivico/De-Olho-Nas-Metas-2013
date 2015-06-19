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
    $config->{'Model::DB'}{connect_info}{password}
);

open( my $fh, '>', 'data/disqus_import.txt' ) or die "erro open file";

print $fh "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
print $fh
"<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\"  xmlns:dsq=\"http://www.disqus.com/\"	     xmlns:dc=\"http://purl.org/dc/elements/1.1/\"	       xmlns:wp=\"http://wordpress.org/export/1.0/\">\n";

my $csv = Text::CSV->new( { binary => 1, sep_char => ';', eol => "\r\n" }
  )    # should set binary attribute.
  or die "Cannot use CSV: " . Text::CSV->error_diag();

open my $fh_csv, '<', 'data/disqus.csv'
  or die "not open";
print $fh "<channel>";

while ( my $row = $csv->getline($fh_csv) ) {
    use DDP;
    p $row;
    print $fh "<item>";

    print $fh "<title> Foo Bar </title>";

    print $fh "<link>http://deolhonasmetas.org.br/project/"
      . $row->[4]
      . "</link>";
    print $fh "<content:encoded><![CDATA[Hello World]]></content:encoded>";
    print $fh "<wp:post_date_gmt>2015-04-16 19:54:40</wp:post_date_gmt>";
    print $fh "<wp:comment_status>open</wp:comment_status>";
    print $fh "<wp:comment>";

    print "<wp:comment_id>$row->[0]</wp:comment_id>";
    my $user =
      $schema->resultset('User')->find( $row->[5] );

    print $fh "<wp:comment_author>$user->name</wp:comment_author>";
    print $fh "<wp:comment_author_email>$user->email</wp:comment_author_email>";
    my @date = split /\./, $row->[2];
    print $fh "<wp:comment_date_gmt>$date[0]</wp:comment_date_gmt>";
    print $fh "<wp:comment_content><![CDATA[$row->[1]]]></wp:comment_content>";
    print $fh "<wp:comment_approved>1</wp:comment_approved>";
    print $fh "<wp:comment_parent>0</wp:comment_parent>";
    print $fh "</wp:comment>";
    print $fh "</item>";

    #    $csv->parse($_);
    #    my @fields = $csv->fields();
    #    p \@fields;
}
print $fh "</channel>";
print $fh "</rss>";
