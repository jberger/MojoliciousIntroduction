#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'PPI';

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
  $self->layout( 'slide' );
  $self->render( $page );
};

# update with the total number of pages
app->defaults( 'pages' => 9 );

app->start;

__DATA__

@@ 1.html.ep

% title q{Introduction to Mojolicious};

%= tag div => class => center => begin
  <p><a href="http://mojolicio.us">
    %= image 'unicorn.png'
  </a></p>
% end

@@ 2.html.ep

% title 'Getting Help';

%= columns begin

  %= column begin
    %= image 'failraptor.png' => style => 'width: 100%; height: auto;'
  % end

  %= column begin
    <ul>
      %= tag li => begin 
        <%= link_to 'http://mojolicio.us' => begin %>http://mojolicio.us<% end %>
      % end
      %= tag li => begin
        <%= link_to 'http://mojocasts.com/e1' => begin %>http://mojocasts.com/e1<% end %>
      % end
      %= tag li => begin
        %= link_to 'http://chat.mibbit.com/?channel=%23mojo&server=irc.perl.org' => begin
          #mojo on irc.perl.org
        % end
      % end
    </ul>
  % end

% end

@@ 3.html.ep

% title q{Mojolicious::Lite 'Hello World'};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'imports strict, warnings, utf8 and v5.10'
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

<hr>

%= tag div => style => 'margin: 0px auto; width: 50%;' => begin
  Start the server
  <ul>
    %= tag li => begin
      basic server <pre>./script daemon</pre>
    % end
    %= tag li => begin
      development server, automatic reload <pre>morbo script</pre>
    % end
    %= tag li => begin
      high performance preforking server <pre>hypnotoad script</pre>
    % end
    %= tag li => 'plack/psgi (no real-time features)'
    %= tag li => 'CGI (but why?)'
  </ul>
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
      %= tag li => 'Request content'
      %= tag li => 'Test status'
      %= tag li => 'Test response and content'
    </ul>

    <p> ... but do I really just have to regex the result??? </p>
  % end

  %= column begin
    %= ppi 'ex/hello1.t'
  % end

% end

@@ 6.html.ep

% title q{Aside: Mojo::DOM};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'HTML/XML parser'
      %= tag li => 'CSS3 selectors (all of them)'
      %= tag li => 'List of supported selectors in Mojo::DOM::CSS'
      %= tag li => begin
        First: <%= ppi '$dom->at($selector)' %> returns a Mojo::DOM
      % end
      %= tag li => begin
        Multiple: <%= ppi '$dom->find($selector)' %> returns a Mojo::Collection
      % end
    </ul>
  % end

  %= column begin
    %= ppi 'ex/dom_example.pl'
  % end

% end

@@ 7.html.ep

% title q{Testing 'Hello User' with Selectors};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Many Test::Mojo methods support selectors'
      %= tag li => 'Test::Mojo has all the power of DOM/JSON/UA'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/hello2.t'
  % end

% end

@@ 8.html.ep

% title q{Aside: Mojo::UserAgent};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Full featured user agent'
      %= tag li => 'Built-in cookie jar'
      %= tag li => 'Handles redirects'
      %= tag li => 'SSL and proxy support'
      %= tag li => 'dom and json response methods'
      %= tag li => 'non-blocking with callback'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/ua_example.pl'
  % end

% end

@@ 9.html.ep

% title q{Non-blocking UserAgent + Server};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Requests module documentation from metacpan'
      %= tag li => 'Waits to render the response'
      %= tag li => q{Doesn't block the server while waiting}
    </ul>
  % end

  %= column begin
    %= ppi 'ex/nb_doc_server.pl'
  % end

% end
