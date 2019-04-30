use Mojolicious::Lite -signatures;

helper validate => sub ($c, $user, $pass) {
  state $users = {
    joel => 'mypass',
  };
  return unless $users->{$user} eq $pass;
  $c->session( user => $user );
};

any '/' => sub ($c) {
  my ($user, $pass) = map {$c->param($_)} qw/user pass/;
  $c->validate($user, $pass) if $user;
  $c->render('index');
};

any '/logout' => sub ($c) {
  $c->session( expires => 1 );
  $c->redirect_to('/');
};

app->start;

__DATA__

@@ index.html.ep

% my $user = session 'user';
% title $user ? "Welcome back \u$user" : "Not logged in";
% layout 'basic';

<h1><%= title %></h1>

% unless ($user) {
  %= form_for '/' => method => 'POST' => begin
    Username: <%= input_tag 'user' %> <br>
    Password <%= password_field 'pass' %> <br>
    %= submit_button
  % end
% }

