#!/bin/sh
set -eu

case $1 in
  _build/WingEd/README.md)
    echo "winged.yaml" ;;
  _build/WingEd/*.html)
    echo "winged-docs.yaml" ;;
  _build/aodix-enhanced/*)
    echo "aodix-enhanced.yaml" ;;
  _build/aodix-repair/*)
    echo "aodix-repair.yaml" ;;
  _build/ar-recorder/*)
    echo "ar-recorder.yaml" ;;
  _build/chromafiler/*)
    echo "chromafiler.yaml" ;;
  _build/riscy-save/*)
    echo "riscy-save.yaml" ;;
  _build/spans/*)
    echo "spans.yaml" ;;
  _build/su-extensions/*)
    echo "su-extensions.yaml" ;;
  _build/tapedeck/*)
    echo "tapedeck.yaml" ;;
  _build/voxel-editor/*)
    echo "voxel-editor.yaml" ;;
  *)
    echo "default.yaml" ;;
esac
