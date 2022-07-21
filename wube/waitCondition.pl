#!/usr/bin/env perl

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: WaitCondition object

=head1 SYNOPSIS

    my $inactiveWaitData = ['or', 'inactivity', 300];
    my $inactiveWait = wubeWaitCondition(@$inactiveWaitData);
    my $scheduleRecordData = {
        waitConditions => [
            ['or', 'full'],
            ['or', 'circuit', ['>', ['virtual', 'signal-green'], 0]],
        ],
    };
    my $scheduleRecord = {
        wait_conditions => [
            map {
                wubeWaitCondition(@{$_})
            } @{$scheduleRecordData->{'waitConditions'}},
        ],
    };
    

=head1 DESCRIPTION

Creates a B<WaitCondition> object for blueprint strings.

For object specs see L<WaitCondition object|https://wiki.factorio.com/Blueprint_string_format#Wait_Condition_object>


=head2 EXPORT

    wubeWaitCondition()

=head1 ROUTINES:

=cut
sub wubeWaitCondition {

=head2 wubeWaitCondition()

Create B<WaitCondition> object.

=head3 Arguments: compare-type, wait-type, ticks | [arrayRefCircuitCondition]

        compare-type: string, 'or'|'and'
        wait-type: string, 'time'|'inactivity'|'full'|'empty'|'item_count'|'circuit'|'fluid_count'|'passenger_present'|'passenger_not_present'
        ticks: integer,
                (only present for 'time' and 'inactivity' types)
        [arrayRefCircuitCondition]: [compare-type, arrayRefSignal, value | arrayRefSignal]
                (only present for 'item_count', 'fluid_count' or 'circuit' types.)
            compare-type: string, '='|'>'|'<'|'≥'|'>='|'=>'|'≤'|'<='|'=<'|'≠'|'!='|'<>'
            arrayRefSignal: [signal-type, signal-name]
                signal-type: string, 'item'|'fluid'|'virtual'
                signal-name: string, name of the item,fluid or virtual signal
            value: integer, numeric constant to compare against
        NB 1: The dual character compare-type strings are for convenience, they
        will be converted to their single character versions for saving.
        NB 2: The 2nd argument is required, unlike in Lau API. The 3rd is optional and
        will default to the constant 0. Unlike in the Lua API you cannot declare both.
        The API would replace the constant with the signal if you did anyway.

=head3 Return: WaitCondition object

=cut

    if ( $_[1] =~ /count|circuit/ ) {
        return {
            condition => wubeCircuitCondition(@{$_[2]}),
            compare_type => $_[0],
            type => $_[1],
        };
    } elsif ( $_[1] =~ /time|inactivity/ ) {
        return {
            ticks =>$_[2],
            compare_type => $_[0],
            type => $_[1],
        };
    } else {
        return {
            compare_type => $_[0],
            type => $_[1],
        }
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
