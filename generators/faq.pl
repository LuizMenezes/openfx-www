#!/usr/bin/perl
#
# $Id: faq.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the faq page for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

my @mail_titles = (
    'OpenFX',
    'Resources', 'serving the <b>OpenFX</b> community',
    'Answers', 'to some frequently asked questions');

Ofx::start_page('resources/faq.html');
OfxStyle::open_all @mail_titles;
OfxContent::include('metacontent/faq.txt');
OfxStyle::close_all();
Ofx::end_page();

