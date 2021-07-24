"/* --------------------- Color Scheme ------------------------ */
set background=dark
if(has('termguicolors'))
  set termguicolors
endif

colorscheme OceanicNext

hi Normal guibg=NONE ctermbg=NONE
hi clear SignColumn
hi clear LineNr 
hi clear CursorLine
hi clear CursorLineNr
hi clear EndOfBuffer 
hi clear VertSplit 

hi LineNr guifg=#62b3b2 ctermfg=DarkGrey
hi CursorLineNr guifg=#FFFFFF ctermfg=white
hi Visual guibg=#EBCB8B guifg=#000000 ctermbg=Grey ctermfg=DarkGrey
