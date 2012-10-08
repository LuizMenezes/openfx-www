#
# $Id: OfxContent.pm,v 1.1.1.1 2004/07/20 23:50:04 dom Exp $
#
# OpenFX website content processing
#

package OfxContent;

use strict;

use Ofx;


#
# Text based content inclusion with certain substitutions.
#
sub include
{
    my $filename = shift;

    # Save the magic separator variable and unset it so we can read the entire file
    #
    my $sep = $/;
    undef $/;

    # Read the file content and restore the separator
    #
    open FH, $filename or die "Couldn't open $filename: $!";
    my $content = <FH>;
    close FH;
    $/ = $sep;

    # Substitute the special sequences
    #
    $content =~ s/\{url:([^}]+)\}/&Ofx::url($1)/eg;
    $content =~ s/\{heading:([^}]+)\}/&OfxStyle::make_heading($1)/eg;
    $content =~ s/\{ftp:([^}]+)\}/&OfxStyle::make_ftp($1)/eg;

    # Print the content, and we've finished.
    #
    print $content;
}


#
# Simple content parser
#
sub read_content
{
    my $filename = shift;
    my @result = ();
    my $current = {};
    my $ckey = '';

    open FH, $filename or die "Can't open file $filename: $!";

    while (my $line = <FH>)
    {
        if ($ckey ne '' && $line =~ /^\s+.*$/)
        {
            $line =~ s/^\s+(.*)$/ $1/;
            $current->{$ckey} .= $line;
            next;
        }

        $line =~ s/^\s*(.*?)\s*$/$1/;
        next if $line eq "";

        if ($line eq "---")
        {
            push @result, $current;
            $current = {};
            next;
        }

        my ($key, $value) = $line =~ /^(\S+):\s*(.*)$/;

        $current->{$key} = $value;
        $ckey = $key;
    }

    close FH;

    push @result, $current;
    return @result;
}


1;

