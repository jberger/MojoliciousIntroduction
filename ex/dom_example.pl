use Mojo::Base -strict;
use Mojo::DOM;

my $html = <<'END';
  <div class="something">
    <h2>Heading</h2>
    Bare text
    <p>Important</p>
  </div>
  <div class="else">Ignore</div>
END

my $dom = Mojo::DOM->new($html);
say $dom->at('.something p')->text;

