use strict;
use List::Util qw{min sum};
use Data::Printer;

open(my $infile, "<", "input.txt");
my ($range_text, $value_text) = split("\n\n", join("", <$infile>));

my @values = map { $_ + 0 } split("\n", $value_text);
my @ranges = map { [map { $_ + 0 } split("-", $_)] } split("\n", $range_text);

sub inrange {
    my $num = shift(@_);
    my @hits = map {
        my ($min, $max) = @{ $_ };
        $num >= $min && $num <= $max ? 1 : 0
    } @ranges;
    my $count = sum( @hits );
    return min $count,1;
}

print sum ( map { inrange($_) } @values ), "\n";
