#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: ItemFilter object

=head1 SYNOPSIS

    my $itemIndex = 1;
    my $itemName = 'iron-ore';
    my $itemFilter = wubeItemFilter([$itemIndex, $itemName]);
    my $itemFilters = wubeItemFilter_list([
        [5, 'iron-ore'],
        [8, 'copper-plate],
        [7, 'copper-ore'],
    ]);

=head1 DESCRIPTION

Creates an B<ItemFilter> object for blueprint strings.

For object specs see L<Item filter object|https://wiki.factorio.com/Blueprint_string_format#Item_filter_object>

=head2 EXPORT

    wubeItemFilter()
    wubeItemFilter_list()

=head1 ROUTINES:

=cut

sub wubeItemFilter {

=head2 wubeItemFilter()

=head3 Argument: arrayRefData

        arrayRefData: [index-number, item-name]
            index-number: integer, 1-based slot position
            item-name: string, name of the item to filter

=head3 Return: ItemFilter Object

=cut

    return {
        index => $_[0]->[0],
        name => $_[0]->[1],
    }
}

sub wubeItemFilter_list {

=head2 wubeItemFilter_list()

=over

I<Helper function to create many filters in one call>

=back

=head3 Argument: arrayOfArrayRefDataList

        arrayOfArrayRefDataList: list of arrayRefData
            arrayRefData: [index-number, item-name]
                index-number: integer, 1-based slot position
                item-name: string, name of the item to filter

=head3 Return: arrayRef of [ItemFilter object, ItemFilter object, ]

=cut

    return [
        map { wubeItemFilter($_); } @{$_[0]}
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
