#
# $Id: Ofx.pm,v 1.3 2006/02/08 11:47:39 avsm Exp $
#
# OpenFX website master definitions
#

package Ofx;

use strict;

use OfxContent;

$Ofx::tutorial_steps_per_page = 5;

$Ofx::imagemap_pics_per_row = 3;
$Ofx::imagemap_pics_per_col = 4;

@Ofx::sections = (
    ['News',        'index.html'],
    ['About',       'about.html'],
    ['Gallery',     'gallery/index.html'],
    ['Mail',        'mail.html'],
    ['Forum',       'http://www.openfxforum.org/'],
    ['Development', 'development/index.html'],
    ['Resources',   'resources/index.html'],
    ['Download',    'download.html']
);

@Ofx::mirrors = (
    ['UK-1', 'http://download.openfx.org/pub/openfx'],
    ['UK-2', 'ftp://ftp.openfx.org/pub/openfx'],
);

$Ofx::url_prefix = '';
$Ofx::dest_dir = '';

sub url
{
    my $url = shift;

    return $Ofx::url_prefix . $url;
}

sub language
{
    my $into = shift;
    my $lang = shift;

    my @content = OfxContent::read_content("metacontent/languages-$into.info");

    return $content[0]->{$lang} if exists $content[0]->{$lang};

    die "No language translation for $lang into $into\n";
}

sub begin
{
    if ($#ARGV != 0)
    {
        print STDERR "Usage: $0 install-directory\n";
        print STDERR "Note: You shouldn't run this script directly: use the build.pl script instead\n";
        exit 1;
    }

    my $target = $ARGV[0];
    chop $target if $target =~ m(.*?/$);

    $Ofx::dest_dir = $target . '/';
}

sub start_page
{
    my $filename = shift;
    my $depth = ($filename =~ tr:/:/:);

    $Ofx::url_prefix = '../' x $depth;

    my $dir = $Ofx::dest_dir . (($filename =~ m:(.*)/.*:)[0]);

    unless (-e $dir)
    {
        system('mkdir', '-p', $dir) == 0 or die "Couldn't make directory $dir";
    }

    my $real_fn = $Ofx::dest_dir . $filename;
    open STDOUT, ">$real_fn" or die "Couldn't open $real_fn for writing: $!";
}

sub end_page
{
    close STDOUT;
}

1;

