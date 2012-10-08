#!/usr/bin/perl
#
# $Id: galleries.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates all the gallery pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();


my @titles = (
    'OpenFX gallery',
    'Gallery', 'of images and animations created using <b>OpenFX</b>',
    'Add', 'any creations of your own to this collection');

my @galleries = OfxContent::read_content('metacontent/galleries.info');


sub make_gallery
{
    my $info = shift;

    my $title = $info->{'title'};
    my $id = $info->{'id'};
    my $base = "gallery/$id";
    my @gallery = OfxContent::read_content("metacontent/galleries/$id.info");

    # Generate the gallery index page
    #
    Ofx::start_page("$base/index.html");
    OfxStyle::open_all @titles;
    OfxStyle::draw_gallery($base, $title, \@gallery);
    OfxStyle::close_all();
    Ofx::end_page();

    # Generate the 'more info' pages
    #
    foreach my $img (@gallery)
    {
        next unless exists $img->{'info'};
        my $name = $img->{'name'};

        Ofx::start_page("$base/$name.html");
        OfxStyle::open_all @titles;
        OfxStyle::draw_gallery_info($base, $title, $img);
        OfxStyle::close_all();
        Ofx::end_page();
    }
}


# Make the index page
#
Ofx::start_page('gallery/index.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/gallery-index.txt');
OfxStyle::draw_gallery_index(\@galleries);
OfxStyle::close_all();
Ofx::end_page();


# Make the actual gallery pages
#
foreach my $gallery (@galleries)
{
    make_gallery($gallery);
}

