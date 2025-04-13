#!/bin/sh
set -eu

case $1 in
  _site/index.html)
    echo "home.yaml" ;;
  _site/updates.html)
    echo "updates.yaml" ;;
  _site/WingEd/README.md)
    echo "winged.yaml" ;;
  _site/WingEd/*.html)
    echo "winged-docs.yaml" ;;
  _site/aodix-enhanced/*)
    echo "aodix-enhanced.yaml" ;;
  _site/aodix-repair/*)
    echo "aodix-repair.yaml" ;;
  _site/ar-recorder/*)
    echo "ar-recorder.yaml" ;;
  _site/chromafiler/*)
    echo "chromafiler.yaml" ;;
  _site/riscy-save/*)
    echo "riscy-save.yaml" ;;
  _site/spans/*)
    echo "spans.yaml" ;;
  _site/su-extensions/*)
    echo "su-extensions.yaml" ;;
  _site/tapedeck/*)
    echo "tapedeck.yaml" ;;
  _site/voxel-editor/*)
    echo "voxel-editor.yaml" ;;
  *)
    echo "default.yaml" ;;
esac
