#!/usr/bin/env perl
use ExtUtils::MakeMaker;
 
WriteMakefile(
  PREREQ_PM => {
    'Mojolicious' => '4', # arbitrary
    'Mojolicious::Plugin::PPI' => 0,
    'Mojolicious::Plugin::SimpleSlides' => 0,
  },  
);
