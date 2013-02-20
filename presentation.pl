#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'PPI';

app->defaults( layout => 'basic' );
my $columns = plugin 'ColumnPlugin';
$columns->width('50');

helper prev_page => sub {
  my $self = shift;
  my $page = $self->stash('page');
  return $page == 1 ? 1 : $page - 1;
};

helper next_page => sub {
  my $self = shift;
  my $page = $self->stash('page');
  return $page == $self->stash('pages') ? $page : $page + 1;
};

any '/:page' => { page => 1 } => sub {
  my $self = shift;
  my $page = $self->stash( 'page' );
  $self->render( $page );
};

# update with the total number of pages
app->defaults( 'pages' => 2 );

app->start;

__DATA__

@@ layouts/basic.html.ep

<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    %= stylesheet 'ppi.css'
    %= stylesheet 'style.css'
    %= javascript 'ppi.js'
    %= javascript 'mousetrap.min.js'
    %= javascript begin
      Mousetrap.bind(['right', 'down', 'pagedown'], function(){
        window.location = "<%= url_for 'page' => { page => next_page } %>";
      });
      Mousetrap.bind(['left', 'up', 'pageup'], function(){
        window.location = "<%= url_for 'page' => { page => prev_page } %>";
      });
    % end
  </head>
  <body>
    <h2><%= title %></h2>
    %= content
    <div class="nav">
      <button class="left">
        %= link_to Previous => page => { page => prev_page }
      </button>
      <span><%= "Page $page / $pages" %></span>
      <button class="right">
        %= link_to Next => page => { page => next_page }
      </button>
    </div>
  </body>
</html>

@@ 1.html.ep

% title 'Columns Testing';

%= columns begin

  %= column begin
    Hi World
  % end

  %= column begin
    %= ppi begin
use Mojolicious::Lite;

any '/' => sub { shift->render( text => 'Hello World' ) };

app->start;
    % end
  % end

% end

@@ 2.html.ep

Page 2
