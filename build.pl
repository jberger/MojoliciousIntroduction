use Mojo::Base -strict;

use Mojo::Util qw/slurp spurt trim xml_escape/;
use Mojo::Template;

my $include = Mojo::Template->new;
$include->parse(<<'INCLUDE')->build->compile;
% my $file = shift;
<pre><code class="perl" data-trim>
  <%== Mojo::Util::slurp $file =%>
</code></pre>
<p style="float: right; text-color: white; font-size: small;"><%== $file %></p>
INCLUDE

sub include {
  my $file = trim shift;
  warn "Including: $file\n";
  $include->interpret($file);
}

my $template = slurp 'index.html.template';

my $start = qr/\s*\Q<!--\E\s*/;
my $end = qr/\s*\Q-->\E\s*/;
$template =~ s/^ $start include \s* (.*) $end\K$/include($1)/megx;

spurt $template => 'index.html';

