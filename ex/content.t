use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin '$Bin';
require "$Bin/content.pl";

my $t = Test::Mojo->new;

$t->get_ok('/0')
  ->status_is(404);

$t->get_ok('/1')
  ->status_is(200)
  ->text_like( p => qr/foo.*?bar/ );

$t->get_ok('/2?format=txt')
  ->status_is(200)
  ->content_is('baz, bat');

$t->get_ok('/1.json')
  ->status_is(200)
  ->json_is({foo => 'bar'});

$t->get_ok('/2', { Accept => 'application/json' })
  ->status_is(200)
  ->json_is('/baz' => 'bat');

done_testing;

