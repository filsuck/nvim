" !::exe [so %]
let easy_align_delimiters = {
\ ' ': { 'pattern': ' ',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ 'w': { 'pattern': ' ',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '=': { 'pattern': '===\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ ':': { 'pattern': ':',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
\ ';': { 'pattern': ':',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
\ ',': { 'pattern': ',',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
\ '|': { 'pattern': '|',  'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '.': { 'pattern': '\.', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ '#': { 'pattern': '#\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment']  },
\ '&': { 'pattern': '\\\@<!&\|\\\\',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '{': { 'pattern': '(\@<!{',
\                         'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
\ '}': { 'pattern': '}',  'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ '>': { 'pattern': '>>\|=>\|>' },
\ "'": { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ '[': { 'pattern': '[[\]]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ 'b': { 'pattern': '[()]', 'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\ 'd': { 'pattern': ' \(\S\+\s*[;=]\)\@=', 'left_margin': 0, 'right_margin': 0 },
\ }
