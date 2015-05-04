#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'RevealJS';

any '/' => { template => 'index', layout => 'revealjs' };

app->start;

