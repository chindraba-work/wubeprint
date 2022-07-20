#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: Color object

=head1 SYNOPSIS

    my $redValue = 0.25;
    my $greenValue = 0.33;
    my $blueValue = 0.78;
    my $colorObject = wubeColor([$redValue, $greenValue, $blueValue]);

=head1 DESCRIPTION

Creates a B<Color> object for blueprint strings.

For object specs see L<Color object|https://wiki.factorio.com/Blueprint_string_format#Color_object>

=head2 EXPORT

    wubeColor()

=head1 ROUTINES:

=cut

sub wubeColor {

=head2 wubeColor()

=head3 Argument: arrayRefData

        arrayRefData: arrayRef of [red, green, blue]
            red, green, blue: floating point, color value (0 .. 1)

=head3 Return: Color Object

=cut

    return {
        r => 1 * sprintf("%.16f", $_[0]->[0]),
        b => 1 * sprintf("%.16f", $_[0]->[1]),
        g => 1 * sprintf("%.16f", $_[0]->[2]),
        a => 0.498039215803146,
    };
}

1;
__END__

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

=cut
# Vim: syntax=perl ts=4 sts=4 sw=4 et sr:
