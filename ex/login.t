use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use FindBin '$Bin';
require "$Bin/login.pl";

my $t = Test::Mojo->new;
$t->ua->max_redirects( 2 );

$t->get_ok('/')
  ->status_is(200)
  ->text_is( h1 => 'Not logged in' )
  ->element_exists( 'form' );

my $login = { user => 'joel', pass => 'mypass' };
$t->post_ok( '/' => form => $login )
  ->status_is(200)
  ->text_like( h1 => qr/joel/i )
  ->element_exists_not( 'form' );

$t->get_ok('/logout')
  ->status_is(200)
  ->element_exists('form');

done_testing;

