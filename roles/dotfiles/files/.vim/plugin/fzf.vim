"/* --------------------------- FzF ---------------------------- */
map <C-p> :FZF<cr>

let $FZF_DEFAULT_COMMAND = 'ag --follow --hidden
  \ --ignore .git
  \ --ignore .oh-my-zsh
  \ --ignore .nuxt 
  \ --ignore .lang 
  \ --ignore node_modules
  \ -g ""'

let g:fzf_action = { 'ctrl-t': 'tab split',  'ctrl-h': 'split',  'ctrl-v': 'vsplit' }

