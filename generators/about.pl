#!/usr/bin/perl
#
# $Id: about.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the about pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

# First generate the about.html page
#
my @about_titles = (
    'About OpenFX',
    'About', 'this freely available 3D package and who wrote it',
    'Website', 'is fully XHTML 1.0 compliant');

Ofx::start_page('about.html');
OfxStyle::open_all @about_titles;
OfxContent::include('metacontent/about.txt');
OfxStyle::close_all();
Ofx::end_page();

# Next generate the about-plugins.html page
#
my @plugins_titles = (
    'About OpenFX',
    'About', 'the OpenFX plugins',
    'Free D', 'has come of age');

Ofx::start_page('about-plugins.html');
OfxStyle::open_all @plugins_titles;
OfxContent::include('metacontent/about-plugins.txt');
OfxStyle::close_all();
Ofx::end_page();

