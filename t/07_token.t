#!/usr/bin/perl -w

# Formal unit tests for specific PPI::Token classes

use strict;
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	$PPI::XS_DISABLE = 1;
	$PPI::XS_DISABLE = 1; # Prevent warning
}
use PPI;

# Execute the tests
use Test::More tests => 23;

my $testdir = catdir( 't', 'data', '07_token' );









#####################################################################
# PPI::Token::Symbol Unit Tests

{
	# Test both creation methods
	my $Token = PPI::Token::Symbol->new( '$foo' );
	isa_ok( $Token, 'PPI::Token::Symbol' );
	$Token = PPI::Token->new( 'Symbol', '$foo' );
	isa_ok( $Token, 'PPI::Token::Symbol' );
	
	# Check the creation of a number of different values
	my @symbols = (
		'$foo'       => '$foo',
		'@foo'       => '@foo',
		'$ foo'      => '$foo',
		'$::foo'     => '$main::foo',
		'@::foo'     => '@main::foo',
		'$foo::bar'  => '$foo::bar',
		'$ foo\'bar' => '$foo::bar',
		);
	while ( @symbols ) {
		my ($value, $canon) = ( shift(@symbols), shift(@symbols) );
		my $Symbol = PPI::Token::Symbol->new( $value );
		isa_ok( $Symbol, 'PPI::Token::Symbol' );
		is( $Symbol->content,   $value, "Symbol '$value' returns ->content   '$value'" );
		is( $Symbol->canonical, $canon, "Symbol '$value' returns ->canonical '$canon'" );
	}
}

1;
