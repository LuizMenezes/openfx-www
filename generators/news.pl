#!/usr/bin/perl
#
# $Id: news.pl,v 1.3 2005/09/22 11:10:17 avsm Exp $
#
# Generates the news page for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

my @news_titles = (
    'OpenFX',
    'Welcome', 'to <b>OpenFX</b> - 3D modelling, animation and rendering',
    'Update', 'OpenFX 2.0 beta 2 with hardware GPU rendering is now available!');

my @news_items = OfxContent::read_content('metacontent/news.info');


# Generate the actual html
#
Ofx::start_page('index.html');
OfxStyle::open_all @news_titles;
OfxStyle::draw_news(\@news_items);
OfxStyle::close_all();
Ofx::end_page();

