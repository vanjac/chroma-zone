#!/bin/sh
set -eu

case "$1" in
  *.redirect.md)
    echo "redirect.yaml" ;;
  */download.md)
    echo "wiki.yaml" ;;
  _site/index.frag.html)
    echo "home.yaml" ;;
  _site/winged/README.md)
    echo "winged.yaml" ;;
  _site/aodix-enhanced/README.md)
    echo "aodix-enhanced.yaml" ;;
  _site/aodix-repair/README.md)
    echo "aodix-repair.yaml" ;;
  _site/ar-recorder/README.md)
    echo "ar-recorder.yaml" ;;
  _site/chromafiler/README.md)
    echo "chromafiler.yaml" ;;
  _site/chromafiler/docs/*)
    echo "wiki.yaml" ;;
  _site/riscy-save/README.md)
    echo "riscy-save.yaml" ;;
  _site/spans/README.md)
    echo "spans.yaml" ;;
  _site/su-extensions/README.md)
    echo "su-extensions.yaml" ;;
  _site/tapedeck/README.md)
    echo "tapedeck.yaml" ;;
  _site/nspace/README.md)
    echo "nspace.yaml" ;;
  *)
    echo "empty.yaml" ;;
esac
