test:
	nvim --headless --noplugin -u nvim/tests/minimal_init.vim -c "PlenaryBustedDirectory nvim/tests/st1 {minimal_init = 'nvim/tests/minimal_init.vim'}"
format:
	stylua nvim/lua/
