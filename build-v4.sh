#!/bin/sh
set -eu

navgen() {
  local IFS path url part count
  path="$1"
  path="${path#_site/}"
  path="${path%index.html}"

  cat <<EOF > _site/nav.yaml
variables:
  nav:
    -
      name: chroma.zone/
      url: /
EOF

  url=/
  count=1
  IFS=/
  for part in $path;
  do
    case "$part" in
      *.html)
        url="${url}$part"
        part="${part%.html}"
        ;;
      *)
        url="${url}$part/"
        part="${part}/"
        ;;
    esac
    count=$(($count + 1))
    cat <<EOF >> _site/nav.yaml
    -
      name: $part
      url: $url
EOF
  done

  unset IFS
  for i in $(seq $count 7);
  do
    cat <<EOF >> _site/nav.yaml
    -
EOF
  done
}

md_format=gfm-autolink_bare_uris

pandoc_version=$(pandoc --version | head -1)
pandoc_older=$(printf "%s\n%s\n" "$pandoc_version" "pandoc 3.0" | sort | head -1)
if [ "$pandoc_older" = "pandoc 3.0" ]; then
  echo "Pandoc supports wikilinks."
  md_format="$md_format+wikilinks_title_before_pipe"
else
  echo "Pandoc does not support wikilinks."
fi

rsync -a --delete --exclude=.* --exclude=_* ./ _site

find _site -name '*.frag.html' -o -name '*.md' | while read path; do
  from=commonmark
  outpath="$path"
  case "$path" in
    *.md)
      from="$md_format"
      outpath="${path%.md}.html"
      ;;
  esac
  case "$outpath" in *.*.html)
    outpath="${outpath%.*.html}.html"
  esac
  case "$outpath" in */README.html)
    outpath="${outpath%README.html}index.html"
  esac

  if [ ! -e "$outpath" ]; then
    echo "Build $path as $outpath"

    pagetitle="${outpath##*/}" # used for wiki pages
    pagetitle="${pagetitle%.html}"
    pagetitle=$(printf "%s" "$pagetitle" | tr '-' ' ')

    navgen "$outpath"

    pandoc --data-dir=_pandoc --from="$from" \
           --defaults=common --defaults=$(_pandoc/file-defaults.sh "$path") \
           --defaults=_site/nav.yaml -M pagetitle="$pagetitle" "$path" -o "$outpath"
  fi
done

rm -f _site/nav.yaml
