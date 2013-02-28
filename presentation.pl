#!/usr/bin/env perl

use Mojolicious::Lite;
use lib 'lib';

plugin 'PPI';

my $slides = plugin 'SimpleSlides';
$slides->column_width('50')->last_slide(20);

any '/index' => 'index';

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

% title q{What is Mojolicious?};

%= columns begin 

  %= column align => middle => begin
    %= image 'noraptor.png'
  % end

  %= column begin
    <ul>
      %= tag li => 'A web framework for Perl'
      %= tag li => q{'Duct tape for the HTML5 web'}
      %= tag li => 'Designed from the ground up'
      %= tag li => '... based on years of experience developing Catalyst'
      %= tag li => 'Portable' 
      %= tag li => 'No non-core dependencies'
      %= tag li => 'Batteries included'
      %= tag li => 'Real-time and non-blocking'
      %= tag li => 'Web scale'
      %= tag li => '9215 lines of code in lib'
      %= tag li => '10052 tests'
      %= tag li => begin
        Easy to install (takes only one minute!)
        %= code_line q{curl get.mojolicio.us | sh}
      % end
    </ul>
  % end

% end

@@ 3.html.ep

% title 'Getting Help';

%= columns begin

  %= column begin
    %= image 'failraptor.png' => style => 'width: 100%; height: auto;'
  % end

  %= column align => middle => begin
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

@@ 4.html.ep

% title q{OH HAI!};

%= tag div => class => center => begin
  %= image 'oh-hai.jpg'
% end

@@ 5.html.ep

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
      basic server 
      %= code_line q{./script daemon}
    % end
    %= tag li => begin
      development server,<br>
      smooth auto-restarting on file change
      %= code_line q{morbo script}
    % end
    %= tag li => begin
      high performance preforking server,<br>
      zero downtime redeployment
      %= code_line q{hypnotoad script}
    % end
    %= tag li => begin
      plack/psgi (no real-time features)
      %= code_line q{plackup script}
      %= code_line q{starman script}
    % end
    %= tag li => 'CGI (but why?)'
  </ul>
% end

@@ 6.html.ep

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

@@ 7.html.ep

% title q{Testing 'Hello User'};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Load the app'
      <ul>
        %= tag li => q{'Lite' apps must require the app}
        %= tag li => q{'Full' apps pass class name to Test::Mojo->new}
      </ul>
      %= tag li => 'Request content'
      %= tag li => 'Test status'
      %= tag li => 'Test response and content'
    </ul>

    <p> ... but do I really just have to regex the result??? </p>
    %= tag div => class => center => begin
      %= image 'orly_owl.jpg', width => '50%'
    % end
  % end

  %= column begin
    %= ppi 'ex/hello1.t'
  % end

% end

@@ 8.html.ep

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

@@ 9.html.ep

% title q{Testing 'Hello User' with Selectors};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Many Test::Mojo methods support selectors'
      %= tag li => 'Test::Mojo has all the power of'
      %= tag ul => begin
        %= tag li => 'Mojo::DOM'
        %= tag li => 'Mojo::JSON'
        %= tag li => 'Mojo::UserAgent'
      % end
      %= tag li => 'Wraps many useful functions of Test::More'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/hello2.t'
  % end

% end

@@ 10.html.ep

% title 'Helpers and Sessions (Login Example)';

%= columns begin

  %= column begin
    <ul>
      %= tag li => q{'helpers' are methods on the app, controller and template}
      %= tag li => 'Many helpers are available by default'
      %= tag li => q{'DefaultHelpers' and 'TagHelpers'}
      %= tag li => q{Helpers (and other things) can be bundled and distributed as 'plugins'}
      %= tag li => q{Session info is signed and stored in a cookie}
    </ul>
    %= tag div => class => center => begin
      %= image 'eated-cookie-lolcat.jpg', width => '50%'
    % end
  % end

  %= column begin
    %= ppi 'ex/login.pl'
  % end

% end

@@ 11.html.ep

% title q{Aside: Mojo::UserAgent};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Full featured user agent'
      %= tag li => 'Built-in cookie jar'
      %= tag li => 'Handles redirects'
      %= tag li => 'SSL and proxy support'
      %= tag li => 'dom and json response methods'
      %= tag li => 'Pluggable content generators (form/json)'
      %= tag li => 'Non-blocking with callback'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/ua_example.pl'
  % end

% end

@@ 12.html.ep

% title 'Testing Login Example';

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Test that the form is only shown when not authenticated'
      %= tag li => 'UserAgent generates form content from hash'
      %= tag li => 'UserAgent follows logout redirect'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/login.t'
  % end

% end

@@ 13.html.ep

% title q{Content Negotiation};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'RESTful apps often support many formats'
      %= tag li => begin 
        the helper 
        %= ppi 'respond_to'
      % end 
        <ul>
          %= tag li => 'detects requested format' 
          %= tag li => 'renders for that format'
        </ul>
      %= tag li => begin
        %= ppi 'render_not_found'
        renders a 404 page
      % end
      %= tag li => begin
        %= ppi 'render_exception'
        renders a 500 page
      % end 
    </ul>
    %= tag div => class => center => begin
      %= image 'erm.jpg', width => '50%'
    % end
  % end

  %= column begin
    %= ppi 'ex/content.pl'
  % end

% end

@@ 14.html.ep

% title q{Testing Content Negotiation};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Test for formatted response by'
      <ul>
        %= tag li => 'default'
        %= tag li => 'query parameter'
        %= tag li => 'extension'
        %= tag li => q{'Accept' header} 
      </ul>
      %= tag li => q{Test the 'not found' 404}
    </ul>
  % end

  %= column begin
    %= ppi 'ex/content.t'
  % end

% end

@@ 15.html.ep

% title q{Still not impressed?};

%= tag div => class => center => begin
  %= image 'mckayla.png'
% end

@@ 16.html.ep

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

@@ 17.html.ep

% title q{WebSockets};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Client opens websocket'
      %= tag li => 'Server responds with data every second'
      %= tag li => 'Client receives data and updates plot'
      %= tag li => 'Real app would get some more interesting data'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/websocket.pl'
  % end

% end

@@ 18.html.ep

% title q{Testing WebSockets};

%= columns begin

  %= column begin
    <ul>
      %= tag li => 'Testing is just as easy!'
      %= tag li => 'Send a message'
      %= tag li => 'Wait for a response'
      %= tag li => 'Test response using JSON pointer'
      %= tag li => 'Repeat or finish'
      %= tag li => 'Many other websocket test methods'
    </ul>
  % end

  %= column begin
    %= ppi 'ex/websocket.t'
  % end

% end

@@ 19.html.ep

% title q{Mojolicious::Commands};

<ul>
  %= tag li => begin
    UserAgent get something from the web
    %= code_line q{mojo get www.reddit.com/r/perl/ 'p.title > a.title' text}
    %= code_line q{mojo get http://search.twitter.com/search.json?q=perl /results/0/text}
  % end
  %= tag li => begin
    UserAgent get from your app!
    %= code_line q{./ex/hello.pl get / p 1 text}
  % end
  %= tag li => begin
    Examine the routes that your app defines
    %= code_line q{./ex/websocket.pl routes}
  % end
  %= tag li => begin
    Run some code against your app!
    %= code_line q{.ex/websocket.pl eval 'say app->dumper(app->home)'}
  % end
  %= tag li => begin
    Generate a new app or plugin
    %= code_line q{mojo generate lite_app}
    %= code_line q{mojo generate app}
    %= code_line q{mojo generate plugin}
  % end
  %= tag li => begin
    Add your own commands to your app. e.g.:
    %= code_line q{galileo setup}
  % end
</ul>

@@ 20.html.ep

% title 'Thanks for listening!';

<h2>Now go have fun with Mojolicious!</h2>

If you liked that, see also 
<ul>
  %= tag li => begin
    <%= link_to 'http://metacpan.org/module/Mango' => begin %>Mango<%= end %> 
    - The new MongoDB driver written by author of Mojolicious
  % end 
  %= tag li => begin
    <%= link_to 'http://metacpan.org/module/Galileo' => begin %>Galileo<%= end %> 
    - My CPAN friendly CMS which runs on top of Mojolicious
  % end
  %= tag li => begin
    <%= link_to 'http://metacpan.org/module/Mojolicious::Plugin::PPI' => begin %>Mojolicious::Plugin::PPI<%= end %> 
    - Perl syntax highlighting for Mojolicious
  % end
  %= tag li => begin
    <%= link_to 'http://metacpan.org/module/Mojolicious::Plugin::SimpleSlides' => begin %>Mojolicious::Plugin::SimpleSlides<%= end %> 
    - The "abuse of Mojo::Template" slide plugin written especially for this talk (coming soon)
  % end
</ul>
