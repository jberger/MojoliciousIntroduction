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
app->defaults( 'pages' => 5 );

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
    <h1 class="center"><%= title %></h1>
    <div id="main">
      %= content
    </div>
    <div class="nav">
      <span class="left">
        %= link_to Previous => page => { page => prev_page }
      </span>
      <span><%= "Page $page / $pages" %></span>
      <span class="right">
        %= link_to Next => page => { page => next_page }
      </span>
    </div>
  </body>
</html>

@@ 1.html.ep

% title q{Introduction to Mojolicious};

%= tag div => class => center => begin
  <p>
    %= image 'unicorn.png'
  </p>
% end

@@ 2.html.ep

% title 'Getting Help';

%= columns begin

  %= column begin
    %= image 'failraptor.png' => style => 'width: 100%; height: auto;'
  % end

  %= column begin
    <ul>
      %= tag li => 'http://mojolicio.us'
      %= tag li => 'http://mojocasts.com/e1'
      %= tag li => '#mojo on irc.perl.org'
    </ul>
  % end

% end

@@ 3.html.ep

% title q{Mojolicious::Lite 'Hello World'};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'imports strict, warnings and utf8'
      %= tag li => q{handles the '/' route}
      %= tag li => 'renders the text (as text)'
      %= tag li => 'starts the app'
    </ul>
  % end

  %= column begin
    %= ppi begin
use Mojolicious::Lite;

any '/' => sub { shift->render( text => 'Hello World' ) };

app->start;
    % end
  % end

% end

@@ 4.html.ep

% title q{Mojolicious::Lite 'Hello User'};

%= columns begin

  %= column begin
    <ul>
      %= tag li => q{handles all toplevel routes, including '/'}
      %= tag li => 'stashes route matches'
      %= tag li => 'other stash values can be added'
      %= tag li => 'renders from a template with layout'
      %= tag li => 'stash values localized to Perl scalars'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/hello.pl'
  % end

% end

@@ 5.html.ep

% title q{Testing 'Hello User'};

%= columns begin

  %= column begin
    <ul>
      %= tag li => q{'Lite' apps must require the app}
      %= tag li => q{'Full' apps pass class name to Test::Mojo->new}
    </ul>
  % end

  %= column begin
    %= ppi 'ex/hello1.t'
  % end

% end
