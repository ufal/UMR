#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Spreadsheet::ParseXLSX;

my $parser    = 'Spreadsheet::ParseXLSX'->new;
my $workbook  = $parser->parse(shift);
my $worksheet = $workbook->worksheet('events');

my %event;
my ($row_min, $row_max) = $worksheet->row_range;
for my $row ($row_min .. $row_max) {
    my $type = $worksheet->get_cell($row, 1);
    next unless $type;

    if ('event' eq $type->value) {
        my $concept = $worksheet->get_cell($row, 2);
        next unless $concept;

        $concept = $concept->value;
        next if $concept =~ /\?{3}|["#]/;

        undef $event{$concept};
    }
}
for my $concept (sort keys %event) {
    say $concept;
}
