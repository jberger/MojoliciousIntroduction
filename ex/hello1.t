use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin '$Bin';
require "$Bin/hello.pl";

my $t = Test::Mojo->new;

$t->get_ok('/')
  ->status_is(200)
  ->content_like(qr/Hello World/)
  ->content_like(qr/\d{2}:\d{2}/);

$t->get_ok('/Joel')
  ->status_is(200)
  ->content_like(qr/Hello Joel/)
  ->content_like(qr/\d{2}:\d{2}/);

done_testing;

