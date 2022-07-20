#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: Color object helper routine

=head1 SYNOPSIS

    my $redValue = 153;
    my $greenValue = 204;
    my $blueValue = 51;
    my $colorSet = buildColor([$redValue, $greenValue, $blueValue]);
    my $hecColor = '#993366';
    my $colorSet = buildColor($hexColor);
    my $colorObject = wubeColor( buildColor([255, 255, 0]) );

=head1 DESCRIPTION

Helps in the creation a B<Color> object for blueprint strings.

Converts an hex string color code to floating point triplet (0..1)

-or-

Converts a triplet of RGB values (0..255) to floating point triplet (0..1)

The returned list can be passed directly to wubeColor().

For object specs see L<Color object|https://wiki.factorio.com/Blueprint_string_format#Color_object>

=head2 EXPORT

    buildColor()

=head1 ROUTINES:

=cut

sub buildColor {

=head2 buildColor()

=head3 Argument: 'hex-color' | [redVal, greenVal, blueVal]

        hex-color: string, include the leading C<#> '#993366'
        redVal, greenVal, blueVal: integer, color values (0..255) for a color
            [153, 51, 102]

=head3 Return: [r, g, b]

        r, g, b: floating point, color values (0..1) for wubeColor() to use.

=cut

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
