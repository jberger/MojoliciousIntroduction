use Mojolicious::Lite -signatures;

any '/:name' => { name => 'World' } => sub ($c) { 
  $c->stash( time => scalar localtime );
  $c->render( 'hello' );
};

app->start;

__DATA__

@@ layouts/basic.html.ep

<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
  </head>
  <body>
    %= content
  </body>
<html>

@@ hello.html.ep

% layout 'basic';
% title "Hello $name";

<p>Hello <%= $name %></p>

%= tag p => begin
  The time is now <%= $time %>
% end
