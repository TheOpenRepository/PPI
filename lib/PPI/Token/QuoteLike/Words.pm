package PPI::Token::QuoteLike::Words;

=pod

=head1 NAME

PPI::Token::QuoteLike::Words - Word list constructor quote-like operator

=head1 INHERITANCE

PPI::Token::QuoteLike::Words
isa PPI::Token::QuoteLike
    isa PPI::Token
        isa PPI::Element

=head1 DESCRIPTION

A C<PPI::Token::QuoteLike::Words> object represents a quote-like operator
that acts as a constructor for a list of words.

  # Create a list for a significant chunk of the alphabet
  my @list = qw{a b c d e f g h i j k l};

=head1 METHODS

There are no methods available for C<PPI::Token::QuoteLike::Words>
beyond those provided by the parent L<PPI::Token::QuoteLike>,
L<PPI::Token> and L<PPI::Element> classes.

Got any ideas for methods? Submit a report to rt.cpan.org!

=cut

use strict;
use base 'PPI::Token::_QuoteEngine::Full',
         'PPI::Token::QuoteLike';

use vars qw{$VERSION};
BEGIN {
	$VERSION = '1.199_02';
}

1;

=pod

=begin testing

use PPI;

# This primarily to ensure that qw() with non-balanced types
# are treated the same as those with balanced types.

for my $q ('qw()', 'qw<>', 'qw//', 'qw##', 'qw,,') {
  my $d = PPI::Document->new(\$q);
  my $o = $d->{children}->[0]->{children}->[0];

  no warnings 'deprecated'; # pseudohashes--
  for my $x ( [operator  => 'qw'   ],
              [_sections => 1      ],
              [braced    => 1      ],
              [separator => undef ],
              [content   => $q     ] ) {
    is($o->{$x->[0]}, $x->[1], "correct $x->[0]")
  }
  for my $x ( [position => 3    ],
              [type     => '()' ],
              [size     => 0    ] ) {
    is($o->{sections}->[0]->{$x->[0]}, $x->[1], "correct sections/$x->[0]")
  }
}

# And again, for incomplete qw()

for my $q ( [ qw-( )- ],
            [ qw-< >- ],
            [ qw-/ /- ],
            [ '#','#' ],
            [ ',',',' ] ) {
  my $d = PPI::Document->new(\"qw$q->[0]");
  my $o = $d->{children}->[0]->{children}->[0];

  no warnings 'deprecated'; # pseudohashes--
  for my $x ( [operator => 'qw'       ],
              [_sections => 1         ],
              [braced => 1            ],
              [separator => undef     ],
              [content => "qw$q->[0]" ] ) {
    is($o->{$x->[0]}, $x->[1], "correct $x->[0]")
  }
  for my $x ( [_close => $q->[1]           ],
              [type =>   $q->[0] . $q->[1] ] ) {
    is($o->{sections}->[0]->{$x->[0]}, $x->[1], "correct sections/$x->[0]")
  }
}

=end testing

=head1 SUPPORT

See the L<support section|PPI/SUPPORT> in the main module.

=head1 AUTHOR

Adam Kennedy E<lt>adamk@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2001 - 2006 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
