use v6;
use Test;

plan 12;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?niecza skip "Grepping Str against a list of IO::Path does not work"
ok @files.grep('t'), 'current directory contains a t/ dir';
ok @files.grep(*.IO.basename eq 't'), 'current directory contains a t/ dir';
isa_ok @files[0], Str, 'dir() returns strings';
is @files[0].IO.dirname, '.', 'dir() returns Str object in the current directory';

#?niecza 3 skip "Grepping Str against a list of IO::Path does not work"
nok @files.grep('.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep('.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep('t'), "can exclude t/ dir";

# previous tests rewritten to not smartmatch against IO::Path.
# Niecza also seems to need the ~, alas.
nok @files.grep(*.IO.basename eq '.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep(*.IO.basename eq '.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep(*.IO.basename eq 't'), "can exclude t/ dir";

is dir('t').[0].IO.dirname, 't', 'dir("t") returns paths with .dirname of "t"';
