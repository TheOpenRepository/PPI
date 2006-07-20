#!/usr/bin/perl -w

# Unit testing for PPI, generated by Test::Inline

use strict;
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	$PPI::XS_DISABLE = 1;
	$PPI::XS_DISABLE = 1; # Prevent warning
}
use PPI;

# Execute the tests
use Test::More [% plan %];

[% tests %]

1;
