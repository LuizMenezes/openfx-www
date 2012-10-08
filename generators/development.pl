#!/usr/bin/perl
#
# $Id: development.pl,v 1.2 2004/07/22 14:32:30 avsm Exp $
#
# Generates the development pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

# First generate the index page
#
my @index_titles = (
    'About OpenFX',
    'Helping', 'contribute to <b>OpenFX</b>',
    'Update', '<b>OpenFX</b> 1.1 has been released');

Ofx::start_page('development/index.html');
OfxStyle::open_all @index_titles;
OfxContent::include('metacontent/development.txt');
OfxStyle::close_all();
Ofx::end_page();

# Next generate the other pages
#
my @pages = (
    'bugs',
    'building',
    'plugins');

foreach my $page (@pages)
{
    Ofx::start_page("development/$page.html");
    OfxStyle::open_all @index_titles;
    OfxContent::include("metacontent/development-$page.txt");
    OfxStyle::close_all();
    Ofx::end_page();
}

