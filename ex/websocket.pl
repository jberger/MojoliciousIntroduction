use Mojolicious::Lite;
use Mojo::JSON 'j';

any '/' => 'index';

websocket '/data' => sub {
  my $self = shift;
  $self->on( text => sub {
    my ($self, $text) = @_;
    Mojo::IOLoop->recurring( 1 => sub {
      state $i = 0;
      $self->send({ text => j(get_data($i++)) }); 
    });
  });
};

sub get_data { 
  my $x = shift; 
  return [ $x, sin( $x + 2*rand() - 2*rand() ) ]
}

app->start;

__DATA__

@@ index.html.ep

% layout 'basic';

%= javascript '/jquery-1.9.1.min.js'
%= javascript '/jquery.flot.js'

<div id="plot" style="width:600px;height:300px">
</div>

%= javascript begin
  var data = [];
  var plot = $.plot($('#plot'), [ data ]);

  var url = '<%= url_for('data')->to_abs %>';
  var ws = new WebSocket( url );
  ws.onopen = function(){ this.send('hi') };
  ws.onmessage = function(e){
    var point = JSON.parse(e.data);
    data.push(point);
    plot.setData([data]);
    plot.setupGrid();
    plot.draw();
  };
% end
