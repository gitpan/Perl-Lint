#!perl

use strict;
use warnings;
use Perl::Lint::Policy::ValuesAndExpressions::ProhibitSpecialHeredocTerminator;
use t::Policy::Util qw/fetch_violations/;
use Test::Base::Less;

my $class_name = 'ValuesAndExpressions::ProhibitSpecialHeredocTerminator';

filters {
    params => [qw/eval/], # TODO wrong!
};

for my $block (blocks) {
    my $violations = fetch_violations($class_name, $block->input, $block->params);
    is scalar @$violations, $block->failures, $block->dscr;
}

done_testing;

__DATA__

===
--- dscr: Basic failures
--- failures: 5
--- params:
--- input
print <<__END__;
All language designers are arrogant. Goes with the territory... :-)
--Larry Wall in <1991Jul13.010945.19157@netlabs.com>
__END__

print <<__PACKAGE__;
#else /* !STDSTDIO */ /* The big, slow, and stupid way */
--Larry Wall in str.c from the perl source code
__PACKAGE__

print <<__LINE__;
Does the same as the system call of that name.
If you don't know what it does, don't worry about it.
--Larry Wall in the perl man page regarding chroot(2)
__LINE__

print <<__FILE__;
When in doubt, parenthesize. At the very least it will let some
poor schmuck bounce on the % key in vi.
--Larry Wall in the perl man page
__FILE__

print <<__DATA__;
: I've tried (in vi) "g/[a-z]\n[a-z]/s//_/"...but that doesn't
: cut it. Any ideas? (I take it that it may be a two-pass sort of solution).
In the first pass, install perl. :-)

--- Larry Wall <6849@jpl-devvax.JPL.NASA.GOV>
__DATA__

===
--- dscr: failures with quotes
--- failures: 2
--- params:
--- input
print <<"__END__";
If you want your program to be readable, consider supplying the argument.
--Larry Wall in the perl man page
__END__

print <<'__END__';
In general, if you think something isn't in Perl, try it out, because it
usually is. :-)
--Larry Wall in <1991Jul31.174523.9447@netlabs.com>
__END__

===
--- dscr: outside the scope of this policy
--- failures: 0
--- params:
--- input
print <<__end__;
OOPS! You naughty creature! You didn't run Configure with sh!
I will attempt to remedy the situation by running sh for you...
--Larry Wall in Configure from the perl distribution
__end__

