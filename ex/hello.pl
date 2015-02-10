use Mojolicious::Lite;

any '/:name' => { name => 'World' } => sub { 
  my $self = shift;
  $self->stash( time => scalar localtime );
  $self->render( 'hello' );
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
