#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

# Factorio Blueprint String objects defined at
# <https://wiki.factorio.com/Blueprint_string_format>

sub buildColor {
# Convert hex or RGB values to list of floating points
#   Arg:
#       string '#abcd87' hex code of color
#       OR arrayRef of 0..255 color values [ red, green, blue ]
#   Return:
#       arrayRef of floats 0..1 [red,green,blue]
    if ( '' eq ref $_[0] ) {
        return [
            map {
                (hex $_)/255 ;
            } ($_[0] =~ m[\#([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})$])
        ];
    } else {
        return [
            map { $_/255; } @{$_[0]}
        ];
    }
}

1;
__END__

=head1 NAME

Factorio Railway Print Maker

=head1 SYNOPSIS

  $ perl wube_print.pl
  $ wube_print.pl

=head1 DESCRIPTION

Reads a data file with specific information about a blueprint or
blueprint book and makes the blueprints, and books, to meet that
definition. Targeted at train stops and trains, but possible use
for other prints later.

Intended as an autmoated method for making many very similar prints
with minor variations between them. For complex prints, or low
numbers of prints, the in-game system is much faster and easier.

=head2 EXPORT

None.

=head1 AUTHOR

Chindraba, E<lt>projects@chindraba.workE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright © 2022  Chindraba (Ronald Lamoreaux)
                  <projects@chindraba.work>
- All Rights Reserved

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
