#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: Tile object

=head1 SYNOPSIS

    my $polePad = [ {concrete => { x => 2, y => 3 } } ];
    my $poleTiles = buildTileList( @$polePad );
    my $beltLine = [ {'refined-concrete' => { x => [3..6], y => 10 } } ];
    my $beltTiles = buildTileList ( @$beltLine );
    my $launchPad = [
        {'refined-hazard-concrete' => { x => [32..42], y => 15}},
        {'refined-hazard-concrete' => { x => 32, y => [16..25] }},
        {'refined-hazard-concrete' => { x => 42, y => [16..25] }},
        {'refined-hazard-concrete' => { x => [33..41], y => 26 }},
        {'refined-concrete' => { x => [33..41], y => [16..24] }},
    ];
    my $ticketToSpace = [ map { wubeTile(@{$_}), } buildTileList(@$launchPad);

=head1 DESCRIPTION

Helper for creation of B<Tile> objects for blueprint strings.

For object specs see L<Tile object|https://wiki.factorio.com/Blueprint_string_format#Tile_object>


=head2 EXPORT

    buildTileList()

=head1 ROUTINES:

=cut

sub _buildTileRect {

=head2 _buildTileRect()

Helper function to convert one rectangle tile definition into data list.

Rather a pointless function for single tiles; data out is the same as data in. With a range in x or y, or both, it becomes useful to make a list of individual tiles to cover the given area.

=head3 Arguments: tile-name, x-coord, y-coord

        tile name: string, name of the tile used, typically 'landfill'
        x-coords: signed-integer | (range)
        y-coords: signed-integer | (range)
            The coordinates can be mixed with a number for one and a range for the other

=head3 Return: (arrayRefTileData, arrayRefTileData)

        arrayRefTileData: [tile-name, x, y]
            tile-name: string,
            x, y: signed-integer

=cut

    return [ (@_)] if ( '' eq ref $_[1]  and '' eq ref $_[2] );
    return map { [ $_[0], $_[1], $_ ]; } @{$_[2]} if ( '' eq ref $_[1] );
    return map { [ $_[0], $_, $_[2] ]; } @{$_[1]} if ( '' eq ref $_[2] );
    return map { my $x = $_; map { [ $_[0], $x, $_ ]; } @{$_[2]}; } @{$_[1]};
}

sub buildTileList {

=head2 buildTileList()

Convert a list of non-overlapping retangle tile definitions into a array of tile data 

=head3 Arguments: ( hashRefTileSet, hashRefTileSet )

        hashRefTileSet: {tile-name=> arrayRefCoordSet}
            tile-name: string, name of the tile to place
            arrayRefCoordSet: [hashRefX, hashRefY]
                hashRefX: { x => x-position | [x-range] }
                hashRefY: { y => y-position | [y-range] }
                
coordinates may be a single number or a range of numbers eg.,:

define a single tile:

    [ {concrete => { x => 2, y => 3 } } ]

define a 4 long 1 high block:

    [ {'refined-concrete' => { x => [3..6], y => 10 } } ]

define an outlined pad for a rocket silo:

    [
        {'refined-hazard-concrete' => { x => [32..42], y => 15}},
        {'refined-hazard-concrete' => { x => 32, y => [16..25] }},
        {'refined-hazard-concrete' => { x => 42, y => [16..25] }},
        {'refined-hazard-concrete' => { x => [33..41], y => 26 }},
        {'refined-concrete' => { x => [33..41], y => [16..24] }},
    ]

=head3 Return: (arrayRefTileData, arrayRefTileData)

        arrayRefTileData: [tile-name, x, y]
            tile-name: string,
            x, y: signed-integer

=cut

    return 
        map {
            _buildTileRect (
                (keys %$_)[0],
                $_->{(keys %$_)[0]}->{'x'},
                $_->{(keys %$_)[0]}->{'y'},
            );
        } @_,
    ;
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
