"use strict";

// https://twitter.com/jon_barron/status/1388233935641976833
// https://basecase.org/env/on-rainbows
// https://krazydad.com/tutorials/makecolors.php
let numColors = process.argv[2];
let f = x => Math.floor(Math.sin(Math.PI * x)**2 * 230).toString(16).toUpperCase().padStart(2, '0');
for (let i = 0; i < numColors; i++) {
    let h = i / numColors;
    let r = f(3/6 - h), g = f(5/6 - h), b = f(7/6 - h);
    console.log(`${i}: ${r}${g}${b}`);
}
