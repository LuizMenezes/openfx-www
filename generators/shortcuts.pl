#!/usr/bin/perl
#
# $Id: shortcuts.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the shortcut resource pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

# First generate the shortcuts index page
#
my @titles = (
    'OpenFX',
    'Resources', 'serving the <b>OpenFX</b> community',
    'Shortcuts', 'making OpenFX easier to use');

Ofx::start_page('resources/shortcuts/index.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/shortcuts.txt');
OfxStyle::close_all();
Ofx::end_page();


# Now the designer shortcuts page
#
my @titles = (
    'OpenFX',
    'Resources', 'serving the <b>OpenFX</b> community',
    'Shortcuts', 'making OpenFX easier to use');

Ofx::start_page('resources/shortcuts/designer.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/shortcuts-designer.txt');
OfxStyle::close_all();
Ofx::end_page();


# Now the animator shortcuts page
#
my @titles = (
    'OpenFX',
    'Resources', 'serving the <b>OpenFX</b> community',
    'Shortcuts', 'making OpenFX easier to use');

Ofx::start_page('resources/shortcuts/animator.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/shortcuts-animator.txt');
OfxStyle::close_all();
Ofx::end_page();



