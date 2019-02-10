let g:rainbow#pairs = [['[', ']'], ['{', '}'], ['(', ')']]
augroup rainbow_lisp
        autocmd!
        autocmd FileType lisp,clojure,scheme,typescript,javascript, RainbowParentheses
augroup END
