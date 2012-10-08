#!/usr/bin/perl
#
# $Id: imagemaps.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates all the imagemap pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();


my @titles = (
    'OpenFX imagemaps',
    'Imagemaps', 'making the polygons pretty',
    'Submit', 'your own imagemaps to help others');

my @imagemaps = OfxContent::read_content('metacontent/imagemaps.info');


sub make_imagemap_page
{
    my $info = shift;
    my $id = $info->{'id'};
    my $dir = "content/resources/imagemaps/$id";

    my $per_row = $Ofx::imagemap_pics_per_row;
    my $per_col = $Ofx::imagemap_pics_per_col;
    my $per_page = $per_row * $per_col;

    # Gather the imagemap information
    #
    opendir DIR, $dir or die "Failed to opendir $dir: $!";
    my @allfiles = grep /^.*\.(tga)|(jpg)|(gif)|(png)\$/, readdir DIR;
    closedir DIR;

    sort @allfiles;

    my $base = "resources/imagemaps/$id";
    my $npages = int(($#allfiles + $per_page - 1) / $per_page);

    # Generate the gallery page
    #
    foreach my $p (1 .. $npages)
    {
        Ofx::start_page("$base/page$p.html");
        OfxStyle::open_all @titles;
        OfxStyle::draw_imagemap_page($base, $p, $npages, ($p - 1) * $per_page, \@allfiles, $info);
        OfxStyle::close_all();
        Ofx::end_page();
    }

    # Generate the licence pages
    #
    if (exists $info->{'licence'})
    {
        Ofx::start_page("$base/licence.html");
        OfxStyle::open_all @titles;
        print "<pre>\n";
        OfxContent::include("$dir/" . $info->{'licence'});
        print "</pre>\n";
        OfxStyle::close_all();
        Ofx::end_page();
    }
}

# Make the index page
#
Ofx::start_page('resources/imagemaps/index.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/imagemaps-index.txt');
OfxStyle::draw_imagemap_index(\@imagemaps);
OfxStyle::close_all();
Ofx::end_page();


# Make the actual imagemap pages
#
foreach my $imap (@imagemaps)
{
    make_imagemap_page($imap);
}

