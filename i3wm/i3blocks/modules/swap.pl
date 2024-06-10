#!/usr/bin/env perl
# I3blocks Swap Usage Module
#

use strict;
use warnings;

# Swap usage
my $swapTotal = `cat /proc/meminfo | grep SwapTotal | awk '{print \$2}'`;
my $swapFree = `cat /proc/meminfo | grep SwapFree | awk '{print \$2}'`;

chomp($swapTotal, $swapFree);

my $swapUsed = $swapTotal - $swapFree;
my $swapUsedGB = sprintf("%.2f", ($swapUsed / 1024 / 1024));
my $swapTotalGB = sprintf("%.2f", ($swapTotal / 1024 / 1024));
my $swapUsedPerc = sprintf("%.2f", ($swapUsed / $swapTotal) * 100);

print " $swapUsedGB / $swapTotalGB GB ($swapUsedPerc%)\n";
