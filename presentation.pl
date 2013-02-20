#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'PPI';

app->defaults( layout => 'basic' );

helper column => sub { 
  my $self = shift;
  my $content = pop || return;
  $content = ref $content ? $content->() : $content;

  my %args = @_;
  my $style = $args{width} ? "width: $args{width}%;" : undef; 
  return $self->render( 
    partial => 1, 
    'columns.style' => $style,
    'columns.column' => $content, 
    inline => <<'TEMPLATE' );
% my @tag = qw/div class column/;
% if ( my $style = stash 'columns.style' ) { push @tag, style => $style } 
%= tag @tag, begin
  %= stash 'columns.column'
% end
TEMPLATE
};

helper columns => sub { 
  my $self = shift;
  return unless @_;
  my $content = shift->();
  return $self->render( 
    partial => 1, 
    'columns.content' => $content,
    inline => <<'TEMPLATE',
<div class="columns-wrapper"><div class="columns">
  %= stash 'columns.content'
</div></div>
TEMPLATE
  );
};

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

@@ style.css
.columns-wrapper {
  display: table;
  width: 100%;
}

.columns {
  display: table-row;
}

.columns > .column {
  display: table-cell;
  vertical-align: middle;
}

.nav {
  text-align: center;
  position: fixed; 
  width: 100%; 
  bottom: 10px;
}

.nav .left {
  position: fixed;
  left: 20px;
}

.nav .right {
  position: fixed;
  right: 20px;
}

@@ layouts/basic.html.ep

<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    %= stylesheet 'style.css'
    %= stylesheet 'ppi.css'
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
