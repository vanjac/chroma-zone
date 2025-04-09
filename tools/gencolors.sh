#!/bin/sh
set -eu

# Generate link colors for the navigation sidebar

# https://twitter.com/jon_barron/status/1388233935641976833
# https://basecase.org/env/on-rainbows
# https://krazydad.com/tutorials/makecolors.php

calc(){ awk "BEGIN{print($*)}"; }

f() {
  local result
  result=$(calc "sin(atan2(0,-1) * $1)^2 * 230")
  printf "%02X\n" "$result" 2> /dev/null || true
}

numcolors=$1
for i in $(seq 0 $(($numcolors - 1))); do
  h=$(calc "$i / $numcolors")
  r=$(f $(calc "3/6.0 - $h"))
  g=$(f $(calc "5/6.0 - $h"))
  b=$(f $(calc "7/6.0 - $h"))
  classname=".link-color$i"
  cat <<EOF
${classname}:hover {
    background-color: #${r}${g}${b};
}
${classname}:target {
    background-color: #${r}${g}${b};
}
EOF
done
