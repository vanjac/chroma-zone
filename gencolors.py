import sys
import math

# https://twitter.com/jon_barron/status/1388233935641976833
# https://basecase.org/env/on-rainbows
# https://krazydad.com/tutorials/makecolors.php
num_colors = int(sys.argv[1])
f = lambda x: int(math.sin(math.pi * x)**2 * 230)
for i in range(0, num_colors):
    h = i / num_colors
    r = f(3/6-h); g = f(5/6-h); b = f(7/6-h)
    print("{}: {:02X}{:02X}{:02X}".format(i, r, g, b))
