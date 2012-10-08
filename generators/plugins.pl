#!/usr/bin/perl
#
# $Id: plugins.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates all the plugin pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();


my @titles = (
    'OpenFX plugins',
    'Plugins', 'enhance the functionality of <b>OpenFX</b>',
    'Submit', 'your own plugin for the benefit of the community');

my @plugins = OfxContent::read_content('metacontent/plugins.info');


sub make_plugin
{
    my $info = shift;
    my $dir = $info->{'directory'};

    my @alldetail = OfxContent::read_content("metacontent/plugins/$dir.info");
    my $detail = $alldetail[0];
    my $base = "resources/plugins/$dir";

    Ofx::start_page("$base/index.html");
    OfxStyle::open_all @titles;
    OfxStyle::draw_plugin_page($base, $detail);
    OfxStyle::close_all();
    Ofx::end_page();
}


# Make the index page
#
Ofx::start_page('resources/plugins/index.html');
OfxStyle::open_all @titles;
OfxContent::include('metacontent/plugins-index.txt');
OfxStyle::draw_plugins_index(\@plugins);
OfxStyle::close_all();
Ofx::end_page();


# Make the actual plugin pages
#
foreach my $plugin (@plugins)
{
    make_plugin($plugin);
}

