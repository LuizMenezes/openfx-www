#
# $Id: OfxStyle.pm,v 1.3 2006/02/08 11:47:39 avsm Exp $
#
# OpenFX website style and templates
#

package OfxStyle;

use strict;

use Ofx;


#
# Toplevel page header and footer
#
sub open_page
{
    my $title = shift;
    my $link = Ofx::url('style.css');

    print <<EOF;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
 <title>$title</title>
 <link href="$link" rel="stylesheet" type="text/css" />
</head>

<body>

EOF
}

sub close_page
{
    print <<EOF;
</body>
</html>
EOF
}


#
# Logo bar and section bar
#
sub draw_logo_bar
{
    my $limg = Ofx::url('images/ofxl4.jpg');
    my $rimg = Ofx::url('images/cool3d3wb.gif');
    my $blank = Ofx::url('images/blank.gif');

    print <<EOF;
<!-- main logo table -->
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<tr>
<td width="3" height="3"><img src="$blank" width="3" height="3" alt="" /></td>
</tr>
<tr>
<td class="logo"><img src="$limg" width="336" height="88" alt="" /></td>
<td width="3" height="3"><img src="$blank" width="3" height="3" alt="" /></td>
<td class="logo" align="center" width="100%"><img src="$rimg" height="8" width="308" alt="" /></td>
</tr>
</table>
<!-- end main logo table -->

EOF
}

sub draw_section_bar
{
    my $ltext = shift;
    my $rtext = shift;

    my $blank = Ofx::url('images/blank.gif');

#    $ltext =~ s/(\w)/$1 /g;
#    $ltext =~ s/  / \&nbsp; /g;

    $rtext = "$rtext... &gt;&gt;" unless $rtext eq '';

    print <<EOF;
<!-- header -->
<table cellpadding="0" cellspacing="0" border="0" width="100%">
 <tr>
  <td width="3" height="3"><img src="$blank" width="3" height="3" alt="" /></td>
 </tr>
 <tr>
  <td class="barleft" width="110">
   <b> &nbsp; $ltext </b>
  </td>
  <td width="3" height="3">
   <img src="$blank" width="3" height="3" alt="" />
  </td>
  <td class="barright" width="600">
   &nbsp; $rtext
  </td>
 </tr>
</table>
<!-- end header -->

EOF
}


#
# Content (and menu)
#
sub open_content
{
    my $blank = Ofx::url('images/blank.gif');

    print <<EOF;
<!-- content table -->
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<tr>
<td width="3" height="3"><img src="$blank" width="3" height="3" alt="" /></td>
</tr>
<tr>

<!-- menu -->
<td width="150" class="logo" valign="top">
<table cellpadding="2" cellspacing="4" width="100%" border="0">
EOF

    foreach my $idx (0 .. $#Ofx::sections)
    {
        my $link = $Ofx::sections[$idx];
        my $name = $link->[0];
        my $href = Ofx::url($link->[1]);
        my $cls = 'menu2';

        $cls = 'menu1' if ($idx == 0 || $idx == $#Ofx::sections);

        print <<EOF;
<tr><td class="$cls"><a class="menu" href="$href">$name</a></td></tr>
EOF
    }
    print <<EOF;
<tr><td>&nbsp;</td></tr>
<tr><td>
<!-- SiteSearch Google -->
<form method="get" action="http://www.google.com/custom" target="_top">
<input type="hidden" name="domains" value="openfx.org;www.openfx.org"></input>
<input type="text" name="q" size="15" maxlength="255" value=""></input>
<br />
<input type="hidden" name="sitesearch" value="" />
<input type="hidden" name="sitesearch" value="www.openfx.org" checked="checked" />
<input type="hidden" name="client" value="pub-6272390678956753"></input>
<input type="hidden" name="forid" value="1"></input>
<input type="hidden" name="safe" value="active"></input>
<input type="hidden" name="ie" value="ISO-8859-1"></input>
<input type="hidden" name="oe" value="ISO-8859-1"></input>
<input type="hidden" name="cof" value="GALT:#008000;GL:1;DIV:#336699;VLC:663399;AH:c
enter;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;F
ORID:1;"></input>
<input type="hidden" name="hl" value="en"></input>
<input type="submit" name="sa" value="Search"></input>
</form>
<!-- SiteSearch Google -->
<!-- Analytics -->
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-285384-1";
urchinTracker();
</script>
<!-- Analytics end -->
</td></tr>
<tr><td>
<script type="text/javascript"><!--
google_ad_client = "pub-6272390678956753";
google_alternate_color = "DDDDDD";
google_ad_width = 120;
google_ad_height = 600;
google_ad_format = "120x600_as";
google_ad_type = "text";
google_ad_channel ="";
google_color_border = "CCCCCC";
google_color_bg = "DDDDDD";
google_color_link = "000000";
google_color_url = "555555";
google_color_text = "333333";
//--></script>
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</td></tr>
</table>
</td>
<!-- end of menu -->

<td width="3" height="3"><img src="$blank" width="3" height="3" alt="" /></td>

<td valign="top" class="content">
<!-- start of content -->

EOF
}

sub close_content
{
    print <<EOF;
<!-- end of content -->
</td>
</tr>
</table>
<!-- end of content table -->

EOF
}


#
# News page
#
sub draw_news
{
    my $items = shift;

    print "<table cellpadding=\"2\" cellspacing=\"2\" border=\"0\" width=\"100%\">\n";

    foreach my $item (@$items)
    {
        my $date = $item->{'date'};
        my $heading = $item->{'heading'};
        my $poster = $item->{'poster'};
        my $body = $item->{'body'};
        my $ogif = Ofx::url('images/o.gif');

        print <<EOF;
<tr>
 <td colspan="2" class="newshead">
  <span class="recent">$date</span>
  <b>$heading</b><span class="newsname"> -- posted by $poster</span>.
 </td>
</tr>
<tr>
 <td width="50" valign="top"><img src="$ogif" vspace="4" width="12" height="9" alt="O" /></td>
 <td class="newsbody">$body</td>
</tr>
EOF
    }

    print "</table>\n";
}


#
# Convenience functions which use the above to create the standard
# page header and footer.
#
sub open_all
{
    my ($title, $l1, $r1, $l2, $r2) = @_;

    open_page($title);
    draw_section_bar($l1, $r1);
    draw_logo_bar();
    draw_section_bar($l2, $r2);
    open_content();
}

sub close_all
{
    close_content();
    draw_section_bar('', '');
    close_page();
}


#
# Content headings
#
sub make_heading
{
    my $text = shift;
    my $img = Ofx::url('images/o.gif');
    my $res = '';

    $res .= "<p class=\"rhead\">";
    $res .= "<img src=\"$img\" alt=\"\" width=\"12\" height=\"9\" />\n";
    $res .= "&nbsp;$text</p>";

    return $res;
}


#
# Ftp sites and mirrors
#
sub make_ftp
{
    my $href = shift;
    my $res = '';

    $res .= "<ul>\n";

    foreach my $site (@Ofx::mirrors)
    {
        my ($loc, $ftp) = @$site;

        $res .= "<li>[<i>$loc</i>]\n";
        $res .= "<a href=\"$ftp/$href\">$ftp/$href</a>\n";
        $res .= "&nbsp;<small>(<a href=\"$ftp/$href.md5\">md5</a>)</small>\n";
        $res .= "</li>\n";
    }

    $res .= "</ul>\n";
    return $res;
}


#
# Tutorial index
#
sub draw_tutorial_index
{
    my $tutorials = shift;
    my %sorted;

    # Sort the tutorials by package
    #
    foreach my $tutorial (@$tutorials)
    {
        my $package = $tutorial->{'package'};
        $sorted{$package} = [] unless exists $sorted{$package};
        push @{$sorted{$package}}, $tutorial;
    }

    # Output the packages
    #
    foreach my $key (sort keys %sorted)
    {
        print OfxStyle::make_heading("$key tutorials");

        print <<EOF;
<table border="0" cellpadding="2" cellspacing="10" width="100%">
<tr>
<th class="tidx-cell" width="13%" align="left">Title</th>
<th class="tidx-cell" width="58%" align="left">Description</th>
<th class="tidx-cell" width="15%" align="left">Author</th>
<th class="tidx-cell" width="15%" align="left">Support files</th>
</tr>
EOF

        foreach my $tutorial (@{$sorted{$key}})
        {
            my $dir = $tutorial->{'directory'};
            my $name = $tutorial->{'name'};
            my $desc = $tutorial->{'description'};
            my $page = Ofx::url("resources/tutorials/$dir/page1.html");
            my $author = $tutorial->{'author'};
            my $support = 'None';

            if (exists $tutorial->{'support'})
            {
                my $sup = $tutorial->{'support'};
                my $url = Ofx::url("resources/tutorials/$dir/$sup");
                $support = "<a href=\"$url\">$sup</a>";
            }

            print <<EOF;
<tr>
<td class="tidx-cell" width="13%"><a href="$page"><b>$name</b></a></td>
<td class="tidx-cell" width="58%">$desc</td>
<td class="tidx-cell" width="15%">$author</td>
<td class="tidx-cell" width="15%">$support</td>
</tr>
EOF
        }

        print <<EOF;
</table>
EOF
    }
}


#
# Tutorial page
#
sub draw_tutorial_languages
{
    my ($base, $langs, $clang) = @_;

    if (scalar(@$langs) > 1)
    {
        print "<center><p>\n";

        foreach my $lang (@$langs)
        {
            my $text = '[' . Ofx::language($clang, $lang) . ']';
            my $sfx = ($lang eq 'en') ? '' : "-$lang";
            my $url = Ofx::url("$base/page1$sfx.html");

            $text = "<a href=\"$url\">$text</a>" unless $clang eq $lang;

            print "$text\n";
        }

        print "</p></center>\n";
    }
}

sub draw_tutorial_pages
{
    my ($base, $page, $pages, $suffix) = @_;

    my $prev = "&lt;&lt; Prev ";
    my $next = " Next &gt;&gt;";
    my $prev_url = Ofx::url("$base/page" . ($page - 1) . "$suffix.html");
    my $next_url = Ofx::url("$base/page" . ($page + 1) . "$suffix.html");
    my $page_list = '&nbsp;&nbsp;';

    $prev = "<a href=\"$prev_url\">$prev</a>" unless $page == 1;
    $next = "<a href=\"$next_url\">$next</a>" unless $page == $pages;

    foreach my $i (1 .. $pages)
    {
        my $url = Ofx::url("$base/page$i$suffix.html");

        $page_list .= "[$i]&nbsp;&nbsp;\n" if $i == $page;
        $page_list .= "<a href=\"$url\">[$i]</a>&nbsp;&nbsp;\n" unless $i == $page;
    }

    print "<center><p>\n";
    print "$prev\n$page_list$next\n";
    print "</p></center>\n";
}

sub draw_tutorial_credits
{
    my $info = shift;

    my $author = $info->{'author'};
    my $trans = exists $info->{'translator'} ? $info->{'translator'} : '';

    print "<center><p>$author</p></center>\n";
    print "<center><p>$trans</p></center>\n" unless $trans eq '';
}

sub draw_tutorial
{
    my ($base, $page, $pages, $spp, $langs, $clang, $info) = @_;

    my $suffix = ($clang eq 'en' ? '' : "-$clang");
    my $start = (($page - 1) * $spp) + 1;
    my $end = $start + $spp - 1;
    my $imgsuffix = exists $info->{'imagesuffix'} ? $info->{'imagesuffix'} : 'png';

    draw_tutorial_languages($base, $langs, $clang);
    draw_tutorial_pages($base, $page, $pages, $suffix);

    print <<EOF;
<table width="95%" align="center" border="0" cellspacing="10" cellpadding="5">
EOF

    foreach my $step ($start .. $end)
    {
        last unless exists $info->{"step$step"};

        my $simg = Ofx::url("$base/step-$step-sm.$imgsuffix");
        my $limg = Ofx::url("$base/step-$step.$imgsuffix");
        my $text = $info->{"step$step"};
        my $hint = exists $info->{"hint$step"} ? $info->{"hint$step"} : '';

        $text =~ s/\{resources\}/&Ofx::url($base)/eg;
        $hint =~ s/\{resources\}/&Ofx::url($base)/eg;

        $hint = "<br /><br /><i>$hint</i>\n" unless $hint eq '';

        print <<EOF;
<tr>
<td class="tut-cell"><a href="$limg">
<img src="$simg" alt="step $step" /></a></td>
<td class="tut-cell">
$text
$hint
</td>
</tr>
EOF
    }

    print <<EOF;
</table>
EOF

    draw_tutorial_credits($info);
    draw_tutorial_pages($base, $page, $pages, $suffix);
}


#
# Gallery index and pages
#
sub draw_gallery_index
{
    my $galleries = shift;

    # Output the packages
    #
    foreach my $gallery (@$galleries)
    {
        my $title = $gallery->{'title'};
        my $id = $gallery->{'id'};
        my $url = Ofx::url("gallery/$id/index.html");

        print make_heading("<a href=\"$url\">$title</a>");
        print "\n";
    }
}

sub draw_gallery
{
    my ($base, $title, $info) = @_;
    my $index = 0;

    print make_heading("$title gallery");

    foreach my $img (@$info)
    {
        my $simg = Ofx::url("$base/" . $img->{'smallimg'});
        my $limg = Ofx::url("$base/" . $img->{'largeimg'});
        my $brief = $img->{'brief'};
        my $image = '';
        my ($r, $l);

        if (exists $img->{'artist'})
        {
            $brief = "Contributed by " . $img->{'artist'} . "<br /><br />\n$brief";
        }

        if (exists $img->{'info'})
        {
            my $url = Ofx::url("$base/" . $img->{'name'} . ".html");
            $brief .= "<br /><br /><a href=\"$url\">More info</a>\n";
        }

        $image .= "<a href=\"$limg\">";
        $image .= "<img src=\"$simg\" width=\"320\" height=\"200\" alt=\"Gallery picture\" />";
        $image .= "</a>\n";

        ($l, $r) = ($brief, $image) if ($index % 2 == 0);
        ($r, $l) = ($brief, $image) if ($index % 2 == 1);
        $index++;

        print <<EOF;
<center><p>
<table width="85%" border="0" cellspacing="5" cellpadding="5"><tr>
<td>$l</td>
<td>$r</td>
</tr></table>
</p></center>
EOF
    }
}

sub draw_gallery_info
{
    my ($base, $title, $img) = @_;

    print make_heading("$title gallery");

    my $simg = Ofx::url("$base/" . $img->{'smallimg'});
    my $limg = Ofx::url("$base/" . $img->{'largeimg'});

    print "<center><table width=\"80%\"><tr><td>\n";

    print <<EOF;
<center><p>
<a href="$limg"><img src="$simg" width="320" height="200" alt="Gallery image" /></a>
</p></center>
EOF

    for (my $i = 1;; $i++)
    {
        last unless exists $img->{"xsmallimg$i"};

        my $simg = Ofx::url("$base/" . $img->{"xsmallimg$i"});
        my $limg = Ofx::url("$base/" . $img->{"xlargeimg$i"});

        print <<EOF;
<center><p>
<a href="$limg"><img src="$simg" width="320" height="200" alt="Gallery image" /></a>
</p></center>
EOF
    }

    if (exists $img->{'artist'})
    {
        print "<p>Contributed by " . $img->{'artist'} . "</p>\n";
    }

    print $img->{'info'};
    print "</td></tr></table></center>\n";
}


#
# Imagemap index and pages
#
sub draw_imagemap_index
{
    my $imagemaps = shift;

    print <<EOF;
<table border="0" cellpadding="2" cellspacing="10" width="100%">
<tr>
<th class="tidx-cell" align="left">Title</th>
<th class="tidx-cell" align="left">Description</th>
<th class="tidx-cell" align="left">Artist</th>
<th class="tidx-cell" align="left">Download</th>
</tr>
EOF

    foreach my $imap (@$imagemaps)
    {
        my $id = $imap->{'id'};
        my $name = $imap->{'name'};
        my $desc = $imap->{'description'};
        my $artist = $imap->{'artist'};
        my $page = Ofx::url("resources/imagemaps/$id/page1.html");
        my $file = Ofx::url("resources/imagemaps/$id.zip");
        my $filename = "$id.zip";
        my $licence = '';

        if (exists $imap->{'licence'})
        {
            my $lurl = Ofx::url("resources/imagemaps/$id/licence.html");
            $licence = "<br />(<a href=\"$lurl\">licence</a>)";
        }

        print <<EOF;
<tr>
<td class="tidx-cell"><a href="$page"><b>$name</b></a></td>
<td class="tidx-cell">$desc</td>
<td class="tidx-cell">$artist$licence</td>
<td class="tidx-cell"><a href="$file">$filename</a></td>
</tr>
EOF
    }

    print <<EOF;
</table>
EOF
}

sub draw_imagemap_pagelinks
{
    my ($base, $page, $npages) = @_;

    my $prev = "&lt;&lt; Prev ";
    my $next = " Next &gt;&gt;";
    my $prev_url = Ofx::url("$base/page" . ($page - 1) . ".html");
    my $next_url = Ofx::url("$base/page" . ($page + 1) . ".html");
    my $page_list = '&nbsp;&nbsp;';

    $prev = "<a href=\"$prev_url\">$prev</a>" unless $page == 1;
    $next = "<a href=\"$next_url\">$next</a>" unless $page == $npages;

    foreach my $i (1 .. $npages)
    {
        my $url = Ofx::url("$base/page$i.html");

        $page_list .= "[$i]&nbsp;&nbsp;\n" if $i == $page;
        $page_list .= "<a href=\"$url\">[$i]</a>&nbsp;&nbsp;\n" unless $i == $page;
    }

    print "<center><p>\n";
    print "$prev\n$page_list$next\n";
    print "</p></center>\n";
}

sub draw_imagemap_page
{
    my ($base, $page, $npages, $start, $files, $info) = @_;

    my $per_row = $Ofx::imagemap_pics_per_row;
    my $per_col = $Ofx::imagemap_pics_per_col;

    draw_imagemap_pagelinks($base, $page, $npages);

    print <<EOF;
<center><table>
EOF

LOOP:
    foreach my $row (1 .. $per_row)
    {
        print "<tr>\n";

        foreach my $col (1 .. $per_col)
        {
            last LOOP if $start == scalar(@$files);

            my $name = $files->[$start];
            my $bname = ($name =~ /([^.]+)\..*/)[0];
            my $small = Ofx::url("$base/thumbnails/$bname.png");
            my $large = Ofx::url("$base/$name");

            print <<EOF;
<td><a href="$large"><img src="$small" alt="Imagemap thumbnail" /></a></td>
EOF
            $start++;
        }

        print "</tr>\n";
    }

    print <<EOF;
</table></center>
EOF

    if (exists $info->{'licence'})
    {
        my $year = $info->{'cr-year'};
        my $holder = $info->{'cr-holder'};
        my $url = Ofx::url("$base/licence.html");

        print <<EOF;
<br />
<center>
Copyright (C) $year $holder<br />
<a href="$url">Licencing information</a>
</center>
EOF
    }

    draw_imagemap_pagelinks($base, $page, $npages);
}


#
# Plugins index and pages
#
sub draw_plugins_index
{
    my $plugins = shift;

    my %sorted;

    # Group the plugins by type
    #
    foreach my $plugin (@$plugins)
    {
        my $type = $plugin->{'type'};
        $sorted{$type} = [] unless exists $sorted{$type};
        push @{$sorted{$type}}, $plugin;
    }
    
    # Output the packages
    #
    foreach my $key (sort keys %sorted)
    {
        print OfxStyle::make_heading("$key plugins");

        print <<EOF;
<table border="0" cellpadding="2" cellspacing="10" width="100%">
<tr>
<th class="tidx-cell" width="13%" align="left">Title</th>
<th class="tidx-cell" width="58%" align="left">Description</th>
<th class="tidx-cell" width="15%" align="left">Author</th>
<th class="tidx-cell" width="15%" align="left">Open Source</th>
</tr>
EOF

        my @plugins = sort { $a->{'name'} cmp $b->{'name'} } @{$sorted{$key}};

        foreach my $plugin (@plugins)
        {
            my $dir = $plugin->{'directory'};
            my $name = $plugin->{'name'};
            my $desc = $plugin->{'info'};
            my $page = Ofx::url("resources/plugins/$dir/index.html");
            my $author = $plugin->{'author'};
            my $source = ($plugin->{'source'} eq 'yes') ? "Yes" : "No";

            print <<EOF;
<tr>
<td class="tidx-cell" width="13%"><a href="$page"><b>$name</b></a></td>
<td class="tidx-cell" width="58%">$desc</td>
<td class="tidx-cell" width="15%">$author</td>
<td class="tidx-cell" width="15%">$source</td>
</tr>
EOF
        }

        print <<EOF;
</table>
<br />
EOF
    }
}

sub draw_plugin_page
{
    my ($base, $detail) = @_;

    my $title = $detail->{'title'};
    my $author = $detail->{'author'};
    my $modules = $detail->{'modules'};
    my $install = $detail->{'install'};
    my $overview = $detail->{'overview'};
    my $file = Ofx::url("$base/" . $detail->{'file'});
    my $has_src = exists $detail->{'source'};
    my $source = $has_src ? Ofx::url("$base/" . $detail->{'source'}) : '';

    print make_heading("Download");
    print <<EOF;
<p>
<ul>
<li><a href="$file"><b>Download the plugin library</b></a></li>
EOF

    print "<li><a href=\"$source\"><b>Download the source code</b></a></li>\n" if $has_src;
    print "</ul>\n</p>\n";

    print make_heading("Installation");
    print <<EOF;
<p>
$install
</p>
EOF

    print make_heading("Information");
    print <<EOF;
<p>
$overview
</p>
EOF

    print "<p>This plugin contains 1 plugin:</p>\n" if $modules == 1;
    print "<p>This plugin contains $modules plugins:</p>\n" unless $modules == 1;
    print "<ul>\n";

    foreach my $i (1 .. $modules)
    {
        my $name = $detail->{"name$i"};
        my $info = $detail->{"info$i"};

        print <<EOF;
<li>
<b>$name</b><br />
$info<br /><br />
</li>
EOF
    }
}


1;

