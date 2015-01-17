use Mojo::Base -strict;

use Mojo::Util qw/slurp spurt trim xml_escape/;

my $format = <<'FORMAT';

<pre><code class="perl" data-trim>
%s
</code></pre>
FORMAT

sub include {
  my $file = trim shift;
  warn "Including: $file\n";
  sprintf $format, xml_escape(slurp $file);
}

my $template = slurp 'index.html.template';

my $start = qr/\s*\Q<!--\E\s*/;
my $end = qr/\s*\Q-->\E\s*/;
$template =~ s/^ $start include \s* (.*) $end\K$/include($1)/megx;

spurt $template => 'index.html';

