#!/usr/bin/perl
#
# $Id: download.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the about pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

my @download_titles = (
    'OpenFX downloads',
    'Download', 'binary and source releases of <b>OpenFX</b>',
    'Mirrors', 'if you can provide mirror sites, please let us know!');

Ofx::start_page('download.html');
OfxStyle::open_all @download_titles;
OfxContent::include('metacontent/download.txt');
OfxStyle::close_all();
Ofx::end_page();

