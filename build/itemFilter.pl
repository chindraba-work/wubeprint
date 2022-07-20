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

    my $filteredSlot = 1;
    my $filterSet = [
        ['coal', 35],
        'rocket-fuel',
        ['wood', 400],
    ];
    my $itemFilters = buildItemFilter_list([
        [5, 'iron-ore'],
        [8, 'copper-plate],
        [7, 'copper-ore'],
    ]);
    my $realFirstSlot
    my $filterObjects = wubeItemFilter_list( buildItemFilter_list (\$realFirstSlot, $filterSet) );

=head1 DESCRIPTION

Helps in the creation of an B<ItemFilter> object for blueprint strings.

For object specs see L<Item filter object|https://wiki.factorio.com/Blueprint_string_format#Item_filter_object>

=head2 EXPORT

    buildItemFilter_list()

=head1 ROUTINES:

=cut

sub _buildItemFilter {

=head2 _buildItemFilter()

=over

Helper function for buildItemFilter_list 

=back

=head3 Arguments: intRefNextSlot, itemName, slotCount

        intRefNextSlot: ref to integer (1-based), what slot to assign the filter to
        itemName: string, name of the filtered item
        slotCount: integet, how many slots to filter

=head3 Return: list of arrayRefSlotFilter. I<Increments the value of intRefNextSlot>

        arrayRefSlotFilter: [slot-number, item-name]

=cut

    my $slotRef = shift;
    return (
        map { [$$slotRef++, $_[0]] } (1..$_[1])
    );
}

sub buildItemFilter_list {

=head2 buildItemFilter_list()

Convert a list of items and countd to a list for input to wubeItemFilter_list()

=head3 Arguments: intRefFirstSlot, itemDataList

        intRefFirstSlot: ref to integer (1-based), first slot to filter with the list
        itemDataList: list of item-name | [item-name, slot-count] (mixed ordering)
            item-name: string, name of the item to filter
            slot-count: how many slots to filter to the item

=head3 Return: arrayRefData. I<Increments the value of intRefFirstSlot>

        arrayOfArrayRedDataList: list of arrayRefData
            arrayRefData: [index-number, item-name]
                index-number: integer (1-based), slot position
                item-name: string, name of the item to filter

=cut

    my $indexRef = shift;
    return [
        map {
            _buildItemFilter(
                $indexRef,
                ( '' eq ref $_ )? $_ : $_->[1],
                ( '' eq ref $_ )? 1 : $_->[0],
            );
        } @_
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
