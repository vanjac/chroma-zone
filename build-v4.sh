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

rsync -a --delete --exclude=.* --exclude=_* ./ _site

find _site -name '*.frag.html' -o -name '*.md' | while read path; do
  from=commonmark
  outpath="$path"
  case "$path" in
    *.md)
      from=gfm
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

    navgen "$outpath"
    pandoc --data-dir=_pandoc --from="$from" \
           --defaults=common --defaults=$(_pandoc/file-defaults.sh "$path") \
           --defaults=_site/nav.yaml "$path" -o "$outpath"
  fi
done

rm -f _site/nav.yaml
