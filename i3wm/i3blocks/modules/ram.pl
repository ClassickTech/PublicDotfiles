#!/usr/bin/env perl

# i3blocks Memory Module

use strict;
use warnings;

# Execute 'free' command to get memory information
my $memInfo = `free -b | grep Mem`;

# Extract memory details
my ($memTotal, $memUsed, $memFree, $memAvailable) = $memInfo =~ /(\d+)/g;

# Adjust used memory by adding 8GB
#$memUsed += 8 * 1024 * 1024 * 1024;  # Convert 8GB to bytes

# Convert memory values from bytes to gigabytes
my $memUsedGB = sprintf("%.2f", ($memUsed / 1024 / 1024 / 1024));
my $memTotalGB = sprintf("%.2f", ($memTotal / 1024 / 1024 / 1024));
my $memUsedPerc = sprintf("%.2f", ($memUsed / $memTotal) * 100);

# Print memory information
print "$memUsedGB / $memTotalGB GB ($memUsedPerc%)\n";
print "$memUsedGB / $memTotalGB GB used, $memAvailable / $memTotal GB available\n";
