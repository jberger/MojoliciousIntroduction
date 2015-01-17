use Mojolicious::Lite;

any '/' => 'index';

websocket '/data' => sub {
  my $self = shift;
  my $timer = Mojo::IOLoop->recurring( 1 => sub {
    state $i = 0;
    $self->send({ json => gen_data($i++) }); 
  });

  $self->on( finish => sub {
    Mojo::IOLoop->remove($timer);
  });
};

sub gen_data { 
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
  ws.onmessage = function(e){
    var point = JSON.parse(e.data);
    data.push(point);
    plot.setData([data]);
    plot.setupGrid();
    plot.draw();
  };
% end
