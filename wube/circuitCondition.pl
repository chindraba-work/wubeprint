#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: CircuitCondition object

=head1 SYNOPSIS

    my @conditions = ('<=', ['virtual','signal-info'], ['fluid'|'light-oil']);
    my $circuitCondition = wubeCircuitCondition(@conditions);
    my $conditions = ['≥', [item', 'iron-ore'], 500];
    my $circuitCondition = wubeCircuitCondition(@$conditions);
    my $hashRef = { condition => ['!=', ['virtual', 'signal-anything']] };
    my $circuitCondition = wubeCircuitCondition(@{$hashRef->{'condition'}});

=head1 DESCRIPTION

Creates a B<CircuitCondition> object for blueprint strings.

For object specs see L<CircuitCondition object|https://lua-api.factorio.com/latest/Concepts.html#CircuitCondition>


=head2 EXPORT

    wubeCircuitCondition()

=head1 ROUTINES:

=cut

sub wubeCircuitCondition {

=head2 wubeCircuitCondition()

Create a B<CircuitCondition> object

=head3 Arguments: compare-type, arrayRefSignal, value | arrayRefSignal

        compare-type: string, '='|'>'|'<'|'≥'|'>='|'=>'|'≤'|'<='|'=<'|'≠'|'!='|'<>'
        arrayRefSignal: [signal-type, signal-name]
            signal-type: string, 'item'|'fluid'|'virtual'
            signal-name: string, name of the item,fluid or virtual signal
        value: integer, numeric constant to compare against
            NB 1: The dual character compare-type strings are for convenience, they
            will be converted to their single character versions for saving.
            NB 2: The 2nd argument is required, unlike in Lau API. The 3rd is optional
            and will default to the constant 0. Unlike in the Lua API you cannot declare both.
            The API would replace the constant with the signal if you did anyway.

=head3 Return: CircuitCondition object

=cut

    $_[0] =
        ('<=' eq $_[0] or '=<' eq $_[0])? '≤' :
        ('>=' eq $_[0] or '=>' eq $_[0])? '≥' :
        ('!=' eq $_[0] or '<>' eq $_[0])? '≠' : $_[0];
    unless ( 'ARRAY' eq ref $_[2] ) {
        return {
            comparitor => $_[0],
            first_signal => wubeSignalID(@{$_[1]}),
            'constant' => (defined $_[2])? $_[2] : 0,
        };
    } else {
        return {
            comparitor => $_[0],
            first_signal => wubeSignalID(@{$_[1]}),
            second_signal => wubeSignalID(@{$_[2]}),
        };
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
