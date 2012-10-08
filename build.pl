#!/usr/bin/perl
#
# $Id: build.pl,v 1.1.1.1 2004/07/20 23:34:03 dom Exp $
#
# Build script.  This first copies the content directory into the staging directory then
# executes each of the generators, to create the complete website.  This is then
# (optionally) synced to webspace using rsync.
#

use strict;

if ($#ARGV != 0)
{
    printf "Usage: build.pl targetdir\n";
    printf "For more information, see the comments in the script itself.\n";
    exit 1;
}

my $target = $ARGV[0];
chop $target if $target =~ m(.*?/$);

if (! -e $target)
{
    system('mkdir', '-p', $target) == 0 or die "Failed to create $target: $!\n";
}


sub makedir
{
    my ($src, $dest) = @_;

    if (! -e $dest)
    {
        system('mkdir', $dest) == 0 or die "Failed to create $dest: $!\n";
    }

    traverse($src, $dest);
}

sub update
{
    my ($src, $dest) = @_;
    system('cp', '-fp', $src, $dest) == 0 or die "Failed to copy $dest: $!";
}

sub traverse
{
    my $src = shift;
    my $dest = shift;

    opendir DIR, $src or die "Failed to opendir $src: $!";
    my @allfiles = grep !/^\.\.?$/, readdir DIR;
    closedir DIR;

    foreach my $file (@allfiles)
    {
        next if $file =~ /^CVS$/;

        my $sfile = "$src/$file";
        my $dfile = "$dest/$file";

        makedir($sfile, $dfile), next if (-d $sfile);
        update($sfile, $dfile);
    }
}

sub generate
{
    opendir DIR, "generators" or die "Failed to opendir generators: $!";
    my @allfiles = grep /.*\.pl$/, readdir DIR;
    closedir DIR;

    foreach my $file (@allfiles)
    {
        print "Generating $file\n";
        system("perl -Ilib -- generators/$file $target") == 0 or die "Error executing $file: $!";
    }
}

print "Updating static content\n";
traverse('content', $target);
generate();

