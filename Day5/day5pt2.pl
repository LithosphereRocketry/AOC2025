use strict;
use List::Util qw{min max sum};

open(my $infile, "<", "input.txt");
my ($range_text, $value_text) = split("\n\n", join("", <$infile>));

my @ranges = map { [map { $_ + 0 } split("-", $_)] } split("\n", $range_text);
my @sranges = sort { $a->[0] <=> $b->[0] } @ranges;

my $total = 0;
my ($cmin, $cmax) = @{ shift @sranges };
foreach ( @sranges ) {
    my ($min, $max) = @{ $_ };
    if ($min <= $cmax) {
        $cmax = max $max, $cmax;
    } else {
        $total += $cmax - $cmin + 1;
        $cmin = $min;
        $cmax = $max;
    }
}
$total += $cmax - $cmin + 1;
print $total, "\n";
