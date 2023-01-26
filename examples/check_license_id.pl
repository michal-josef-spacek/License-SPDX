#!/usr/bin/env perl

use strict;
use warnings;

use License::SPDX;

if (@ARGV < 1) {
        print STDERR "Usage: $0 license_id\n";
        exit 1;
}
my $license_id = $ARGV[0];

# Object.
my $obj = License::SPDX->new;

print 'License with id \''.$license_id.'\' is ';
if ($obj->check_license($license_id)) {
        print "suppored.\n";
} else {
        print "not suppored.\n";
}

# Output for 'MIT':
# License with id 'MIT' is suppored.

# Output for 'BAD':
# License with id 'BAD' is not suppored.