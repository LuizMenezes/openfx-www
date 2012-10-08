#!/usr/bin/perl
#
# $Id: misc.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates misc pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

# Generate the release page
#
my @release_titles = (
    'OpenFX',
    'Welcome', 'to <b>OpenFX</b> - 3D modelling, animation and rendering',
    'Release', 'announcement of OpenFX-1.0');

Ofx::start_page('misc/release.html');
OfxStyle::open_all @release_titles;
OfxContent::include('metacontent/release.txt');
OfxStyle::close_all();
Ofx::end_page();
