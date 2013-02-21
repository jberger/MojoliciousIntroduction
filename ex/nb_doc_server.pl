use Mojolicious::Lite;
use Mojo::UserAgent;
use Mojo::URL;

my $ua = Mojo::UserAgent->new;
my $url = Mojo::URL->new('http://api.metacpan.org/pod/')
                   ->query( 'content-type' => 'text/html' );

any '/:module' => { module => 'Mojolicious' } => sub {
  my $c = shift;
  $c->render_later;

  my $module = $c->stash('module');
  my $target = $url->clone;
  $target->path($module);

  $ua->get( $target => sub {
    my ($ua, $tx) = @_;
    $c->render( 'docs', pod => $tx->res->body );
  });
};

app->start;

__DATA__

@@ docs.html.ep

% layout 'basic';
% title $module;

<h1><%= $module %></h1>

%== $pod
