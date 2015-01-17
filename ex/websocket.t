use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin '$Bin';
require "$Bin/websocket.pl";

my $t = Test::Mojo->new;

$t->get_ok('/')
  ->status_is(200)
  ->element_exists( '#plot' );

$t->websocket_ok('/data')
  ->message_ok
  ->json_message_is( '/0' => 0 )
  ->json_message_has( '/1' )
  ->message_ok
  ->json_message_is( '/0' => 1 )
  ->finish_ok;

done_testing;

