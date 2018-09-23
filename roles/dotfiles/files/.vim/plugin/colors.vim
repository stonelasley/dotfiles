let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
"/* --------------------- Color Scheme ------------------------ */
let base16colorspace=256
colorscheme base16-twilight
hi SpellCap ctermfg=082 ctermbg=019 guifg=#000000 guibg=#AB4642
hi SpellBad ctermfg=082 ctermbg=019 guifg=#000000 guibg=#AB4642

"/* -------------------- AirLine Theme ------------------------ */
let g:airline_theme='base16_twilight'
