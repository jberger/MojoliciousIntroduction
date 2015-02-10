use Mojo::Base -strict;
use Mojo::UserAgent;

my $ua = Mojo::UserAgent->new(max_redirects => 10);

say $ua->get('api.metacpan.org/v0/release/Mojolicious')
       ->res->json->{version};

use Mojo::URL;
my $url = Mojo::URL->new('http://openlibrary.org/subjects/')
                   ->path('perl.json')
                   ->query( details => 'true' );
say $url;
say $ua->get($url)->res->json('/works/0/title');

