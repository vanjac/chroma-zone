#!/bin/sh
set -eu

navquery() {
  local path
  path="${1%.html}"
  echo $(basename "${path%/index}")
}

rsync -a --delete --exclude=.* --exclude=_* ./ _site

find _site -type f -name '*.html' | while read path; do
  firstline=$(head -n 1 "$path")
  if [ "$firstline" = "---" ]; then
    echo "Build $path"

    template=default.html5
    case $path in */navigation.html)
      template=nav
    esac

    navquery=$(navquery "$path")
    pandoc --from=commonmark+yaml_metadata_block --to=html --standalone --wrap=preserve \
           --data-dir=pandoc --metadata-file=$(pandoc/metadata-file.sh "$path") \
           --template="$template" -M navquery="$navquery" "$path" -o "$path"
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

    navquery=$(navquery "$outpath")
    pandoc --from=gfm-autolink_bare_uris --to=html --standalone --wrap=preserve \
           --data-dir=pandoc --metadata-file=$(pandoc/metadata-file.sh "$path") \
           -M title="$title" -M navquery="$navquery" "$path" -o "$outpath"
  fi
done
