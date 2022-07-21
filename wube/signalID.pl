#!/usr/bin/env perl

# SPDX-License-Identifier: MIT

use 5.0300;
use strict;
use warnings;

=pod

=encoding UTF-8

=head1 NAME

Factorio Print Maker: SignalID object

=head1 SYNOPSIS

    my $signalData = ['fluid', 'steam''];
    my $signal = wubeSignalID(@$signalData);
    my $signal = wubeSignalID('virtual', 'signal-H');

=head1 DESCRIPTION

Creates a B<SignalID> object for blueprint strings.

For object specs see L<SignalID object|https://wiki.factorio.com/Blueprint_string_format#SignalID_object>


=head2 EXPORT

    wubeSignalID()

=head1 ROUTINES:

=cut

sub wubeSignalID {

=head2 wubeSignalID()

Make a SignalID object

=head3 Arguments: signal-type, signal-name

        signal-type: string, 'item'|'fluid'|'virtual'
        signal-name: string, what the signal is

=head3 Return: SignalID object

=cut

    return {
        type => $_[0],
        name => $_[1]
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
