## extra code developed for possible use with wallflower

# to get better urls from wallflower for gh-pages
my $is_psgi = do {
  no warnings 'uninitialized';
  app->commands->detect eq 'psgi';
};

under '/WCpm-Mojolicious' if $is_psgi;

sub format_hack {
  push @_, format => 'html' if $is_psgi;
  return @_;
}
#####
