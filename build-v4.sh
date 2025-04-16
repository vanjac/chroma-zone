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
    case $part in
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

find _site -type f -name '*.html' | while read path; do
  outpath="$path"
  case $outpath in *.frag.html)
    outpath="${path%.frag.html}.html"
  esac
  firstline=$(head -n 1 "$path")
  if [ "$firstline" = "---" ]; then
    echo "Build $path as $outpath"

    navgen "$outpath"
    pandoc --data-dir=_pandoc --defaults=common --from=commonmark+yaml_metadata_block \
           --metadata-file=$(_pandoc/metadata-file.sh "$path") \
           --defaults=_site/nav.yaml "$path" -o "$outpath"
  fi
done

find _site -type f -name '*.md' | while read path; do
  outpath="${path%.md}.html"
  case $outpath in */README.html)
    outpath="${outpath%README.html}index.html"
  esac
  if [ ! -e "$outpath" ]; then
    echo "Build $path as $outpath"

    navgen "$outpath"
    pandoc --data-dir=_pandoc --defaults=common --from=gfm-autolink_bare_uris \
           --metadata-file=$(_pandoc/metadata-file.sh "$path") \
           --defaults=_site/nav.yaml "$path" -o "$outpath"
  fi
done

rm -f _site/nav.yaml
