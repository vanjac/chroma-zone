#!/usr/bin/env tclsh
package require Tcl 8.6

set pattern_defaults [source _pandoc/pattern-defaults.tcl]
proc file_defaults path {
  global pattern_defaults
  foreach {pattern def_file} $pattern_defaults {
    if [string match $pattern $path] {
      return $def_file
    }
  }
}

proc navgen path {
  set path [regsub /index.html$ $path /]
  set path [regsub ^_site/ $path ""]
  set path [regsub /$ $path ""]

  set nav_chan [open _site/nav.yaml w]
  puts $nav_chan "
variables:
  nav:
    -
      name: chroma.zone/
      url: /"

  set url /
  set count 1
  foreach part [split $path /] {
    if [string match *.html $part] {
      set url $url$part
      set part [regsub {\.html$} $part ""]
    } else {
      set url $url$part/
      set part $part/
    }
    incr count
    puts $nav_chan "
    -
      name: $part
      url: $url"
  }

  for {} {$count < 8} {incr count} {
    puts $nav_chan "
    -"
  }
  close $nav_chan
}

exec rsync -a --delete --exclude=.* --exclude=_* ./ _site

foreach path [exec find _site -printf {{%p} } -name *.frag.html -o -name *.md -o -name *.org] {
  if [string match *.md $path] {
    set from gfm-autolink_bare_uris+wikilinks_title_before_pipe
    set outpath [regsub md$ $path html]
  } elseif [string match *.org $path] {
    set from org
    set outpath [regsub org$ $path html]
  } else {
    set from commonmark
    set outpath $path
  }
  set outpath [regsub {\.[^.]*\.html$} $outpath .html]
  set outpath [regsub /README.html$ $outpath /index.html]

  if {! [file exists $outpath]} {
    puts "Build $path as $outpath"

    # used for wiki pages
    set pagetitle [lindex [split $outpath /] end]
    set pagetitle [regsub {\.html} $pagetitle ""]
    set pagetitle [string map {- { }} $pagetitle]
    set pagetitle [string toupper $pagetitle 0]

    navgen $outpath

    exec pandoc \
      --data-dir=_pandoc --from=$from \
      --defaults=common --defaults=[file_defaults $path] \
      --defaults=_site/nav.yaml -M pagetitle=$pagetitle $path -o $outpath
  }
}

file delete _site/nav.yaml
