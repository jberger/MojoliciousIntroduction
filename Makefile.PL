#!/usr/bin/env perl
use ExtUtils::MakeMaker;
 
WriteMakefile(
  PREREQ_PM => {
    'Mojolicious' => '6.0', # arbitrary
    'Mojolicious::Plugin::RevealJS' => 0,
  },  
);
