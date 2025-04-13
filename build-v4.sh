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
      name: chroma.zone
      url: /
EOF

  url=/
  count=1
  IFS=/
  for part in $path;
  do
    case $part in
      *.html) url="${url}$part" ;;
      *) url="${url}$part/" ;;
    esac
    part="${part%.html}"
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
  firstline=$(head -n 1 "$path")
  if [ "$firstline" = "---" ]; then
    echo "Build $path"

    navgen "$path"
    pandoc --data-dir=_pandoc --defaults=common --from=commonmark+yaml_metadata_block \
           --metadata-file=$(_pandoc/metadata-file.sh "$path") \
           --template=v4 --defaults=_site/nav.yaml "$path" -o "$path"
  fi
done

find _site -type f -name '*.md' | while read path; do
  outpath="${path%.md}.html"
  case $outpath in */README.html)
    outpath="${outpath%README.html}index.html"
  esac
  if [ ! -e "$outpath" ]; then
    echo "Build $path as $outpath"

    title=
    firstline=$(head -n 1 "$path")
    case $firstline in \#*)
      title=${firstline#\# }
    esac

    navgen "$outpath"
    pandoc --data-dir=_pandoc --defaults=common --from=gfm-autolink_bare_uris \
           --metadata-file=$(_pandoc/metadata-file.sh "$path") \
           --template=v4 --defaults=_site/nav.yaml -M title="$title" "$path" -o "$outpath"
  fi
done
