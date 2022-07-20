#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: _ object

=head1 SYNOPSIS

    my $gIDs = [1,3,5];
    my $rIDs = [3,5];
    my $singleConnection = wubeConnection( [[{red => $rIDs}, {green => $gIDs}]] );
    my $doubleConnection = wubeConnection([
        [
            {green => $gIDs},
            {red => $rIDs}
        ],
        [
            {red => [1]}
        ]
    ]);

=head1 DESCRIPTION

Creates a B<Connection> object for blueprint strings.

Includes the internal creation of B<ConnectionPoint> and B<ConnectionData> objects.

For object specs see:

L<Connection object|https://wiki.factorio.com/Blueprint_string_format#Connection_object>

L<ConnectionPoint object|https://wiki.factorio.com/Blueprint_string_format#Connection_point_object>

L<ConnectionData object|https://wiki.factorio.com/Blueprint_string_format#Connection_data_object>


=head2 EXPORT

    wubeConnection()

=head1 ROUTINES:

=cut

sub _wubeConnectionData {

=head2 _wubeConnectionData()

Creates a ConnectionData object

=head3 Argument: entryID

        entryID: integer (1-based), index of the entity at the other end of the wire

=head3 Return: ConnectionData object

=cut

    return { entity_id => shift };
}

sub _wubeConnectionPoint {

=head2 _wubeConnectionPoint()

Creates a ConnectionPoint object

=head3 Argument: arrayRefConnectionPoints

        arrayRefConnectionPoints: [ color-name, arrrayRefEntityList ]
            color-name: string, 'red'|'green', which wire is being connected
            arrayRefEntityList: [entityID, entityID, ]
                entityID: integer (1-based), index of the entity at the other end of a wire

=head3 Return: ConnectionPoint object

=cut

    return { map {
        (%{$_})[0] =>
        [ map { _wubeConnectionData($_); } @{(%{$_})[1]} ] ;
    } (@_) };
}

sub wubeConnection {

=head2 wubeConnection()

Create a Connection object

=head3 Arguments: arrayRefConnectionData, arrayRefConnectionData

        arrayRefConnectionData: [arrayRefWireList] (one per "connection", normally one)
            arrayRefWireList: [hashRefWireData,] (one per wire color, max two)
                hashRefWireData: {wire-color, arrayRefEntities}
                    wire-color: string 'red'|'green'
                    arrayRefEntities: [entityID, entityID,]
                        entityID: integer, index (1-based) of the entity connected to
        _The second arrayRefConnectionData is only used for items with a second connection.
        Such as the output for decider/arithmetic combinators.

=head2 Return: Connection object

=cut

    my $connection_number = 0;
    return {
       map {;
            { ++$connection_number => _wubeConnectionPoint(@$_) };
        } @_ 
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
