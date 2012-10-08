#!/usr/bin/perl
#
# $Id: tutorials.pl,v 1.1.1.1 2004/07/20 23:50:08 dom Exp $
#
# Generates all the tutorial pages for the OpenFX website.
#

use strict;

use Ofx;
use OfxStyle;
use OfxContent;

Ofx::begin();


my @index_titles = (
    'OpenFX tutorials',
    'Tutorials', 'improve your OpenFX skills',
    'Submit', 'your own tutorial to this list');

my @tutorials = OfxContent::read_content('metacontent/tutorials.info');


sub make_tutorial_info
{
    my ($dir, $langs, $clang, $infofile) = @_;

    my @allinfo = OfxContent::read_content($infofile);
    my $info = $allinfo[0];
    my $spp = $Ofx::tutorial_steps_per_page;

    my $base = "resources/tutorials/$dir";
    my $suffix = ($clang eq 'en' ? "" : "-$clang");

    my $title = $info->{'title'};
    my $scope = $info->{'scope'};
    my $steps = $info->{'steps'};

    my $pages = int(($steps + $spp - 1) / $spp);

    my @titles = (
        "OpenFX tutorial - $title",
        "Tutorial", "improve your OpenFX skills",
        "Scope", $scope);

    foreach my $page (1 .. $pages)
    {
        Ofx::start_page("$base/page$page$suffix.html");
        OfxStyle::open_all @titles;
        OfxStyle::draw_tutorial($base, $page, $pages, $spp, $langs, $clang, $info);
        OfxStyle::close_all();
        Ofx::end_page();
    }
}

sub make_tutorial
{
    my $tutorial = shift;

    my @infolist = glob("metacontent/tutorials/$tutorial*.info");
    my @langs = map { (/[^-]*-([^.]+).info/)[0] } @infolist;

    foreach my $i (0 .. $#langs)
    {
        make_tutorial_info($tutorial, \@langs, $langs[$i], $infolist[$i]);
    }
}


# Make the index page
#
Ofx::start_page('resources/tutorials/index.html');
OfxStyle::open_all @index_titles;
OfxContent::include('metacontent/tutorials-index.txt');
OfxStyle::draw_tutorial_index(\@tutorials);
OfxStyle::close_all();
Ofx::end_page();


# Make the actual tutorial pages
#
foreach my $tutorial (@tutorials)
{
    make_tutorial($tutorial->{'directory'});
}

