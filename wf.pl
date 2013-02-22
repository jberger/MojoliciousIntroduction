use Mojolicious::Lite;

use FindBin '$Bin';

plugin Mount => { '/WCpm-Mojolicious' => "$Bin/presentation.pl" };

app->start;

