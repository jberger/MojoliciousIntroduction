use Mojolicious::Lite;

my %data = (
  1 => { foo => 'bar' },
  2 => { baz => 'bat' },
);

any '/:id' => sub {
  my $self = shift;
  return $self->reply->not_found
    unless my $item = $data{$self->stash('id')};

  $self->respond_to(
    txt => { text => join(', ', %$item) },
    json => { json => $item },
    any  => { 
      format => 'html', 
      template => 'page', 
      foo => $item,
    },
  );
};

app->start;

__DATA__

@@ page.html.ep

% my $key = (keys %$foo)[0];
% title "You wanted $key";
% layout 'basic';

<p>
  All your <%= $key %> 
  are belong to <%= $foo->{$key} %>
</p>
