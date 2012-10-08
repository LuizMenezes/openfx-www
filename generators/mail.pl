#!/usr/bin/perl
#
# $Id: mail.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates the mail pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();

my @mail_titles = (
    'OpenFX mailing lists',
    'Email', 'lists to get in touch with other <b>OpenFX</b> users',
    'Archives', 'will be available soon');

Ofx::start_page('mail.html');
OfxStyle::open_all @mail_titles;
OfxContent::include('metacontent/mail.txt');
OfxStyle::close_all();
Ofx::end_page();

