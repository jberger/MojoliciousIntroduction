package ColumnPlugin;

use Mojo::Base 'Mojolicious::Plugin';

has 'width';

sub register {
  my ($plugin, $app, $conf) = @_;

  $app->helper( column_plugin => sub { $plugin } );

  $app->helper( column => sub { 
    my $c = shift;
    my $plugin = $c->column_plugin;
    my $content = pop || return;
    $content = ref $content ? $content->() : $content;

    my %args = @_;
    $args{width} //= $plugin->width;

    my $style = $args{width} ? "width: $args{width}%;" : undef; 
    return $c->render( 
      partial => 1, 
      'columns.style' => $style,
      'columns.column' => $content, 
      inline => <<'TEMPLATE',
% my @tag = qw/div class column/;
% if ( my $style = stash 'columns.style' ) { push @tag, style => $style } 
%= tag @tag, begin
  %= stash 'columns.column'
% end
TEMPLATE
    );
  });

  $app->helper( columns => sub { 
    my $c = shift;
    return unless @_;
    my $content = shift->();
    return $c->render( 
      partial => 1, 
      'columns.content' => $content,
      inline => <<'TEMPLATE',
<div class="columns-wrapper"><div class="columns">
  %= stash 'columns.content'
</div></div>
TEMPLATE
    );
  });

  return $plugin;
}

1;

