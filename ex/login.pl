use Mojolicious::Lite;

helper validate => sub {
  my ($self, $user, $pass) = @_;
  state $users = {
    joel => 'mypass',
  };
  return unless $users->{$user} eq $pass;
  $self->session( user => $user );
};

any '/' => sub {
  my $self = shift;
  my ($user, $pass) = map {$self->param($_)} qw/user pass/;
  $self->validate($user, $pass) if $user;
  $self->render('index');
};

any '/logout' => sub {
  my $self = shift;
  $self->session( expires => 1 );
  $self->redirect_to('/');
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

