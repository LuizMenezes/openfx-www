#!/usr/bin/perl
#
# $Id: resources.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the resources page for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

my @titles = (
    'About OpenFX',
    'Resources', 'serving the <b>OpenFX</b> community',
    'Update', 'tutorials are now available');

Ofx::start_page('resources/index.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/resources.txt');
OfxStyle::close_all();
Ofx::end_page();

