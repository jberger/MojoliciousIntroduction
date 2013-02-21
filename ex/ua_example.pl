use Mojo::Base -strict;
use Mojo::UserAgent;

my $ua = Mojo::UserAgent->new(max_redirects => 10);
$ua->detect_proxy;

say $ua->get('api.metacpan.org/v0/release/Mojolicious')
       ->res->json->{version};


use Mojo::URL;
my $url = Mojo::URL->new('http://openlibrary.org/search.json')
                   ->query( title => 'perl practices' );

say $ua->get($url)
       ->res->json('/docs/0/title_suggest');

