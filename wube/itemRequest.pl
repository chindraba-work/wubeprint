#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: ItemRequest object

=head1 SYNOPSIS

    my $itemName = 'iron-ore';
    my $itemCount = 10;
    my $itemRequest = wubeItemRequest([$itemName, $itemCount]);
    my $itemRequest = wubeItemRequest(['an-item', 5], ['another-one', 15], ['something', 245]);

=head1 DESCRIPTION

Creates an B<ItemRequest> object for blueprint strings.

For object specs see L<Item request object|https://wiki.factorio.com/Blueprint_string_format#Item_request_object>

=head2 EXPORT

    wubeItemRequest()

=head1 ROUTINE:

=cut

sub wubeItemRequest {

=head2 wubeItemRequest()

=head3 Arguments: list of arrayRefRequestData

    arrarRefRequestData: [itemName, itemCount]
        itemName: name of the item to request
        itemCount: how many to request

=head3 Return: ItemRequest Object

=cut

    return [
        map { {$_->[0] => $_->[1] }; } @_
    ];
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
