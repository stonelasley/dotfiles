-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/st1/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/st1/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/st1/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/st1/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/st1/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    config = { "require('config.ale')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/ale"
  },
  ["betterlua.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/betterlua.vim"
  },
  ["fzf.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  hop = {
    config = { "require('config.hop')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "require('config.indentguides')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["kartograaf.nvim"] = {
    config = { "require('mappings')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/kartograaf.nvim"
  },
  loupe = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/loupe"
  },
  ["lspkind-nvim"] = {
    config = { "require('config.lspkind')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "require('config.lspsaga')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('config.lualine')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ncm2 = {
    config = { "require('config.ncm2')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/ncm2"
  },
  ["ncm2-ultisnips"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/ncm2-ultisnips"
  },
  neon = {
    config = { "require('config.neon')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/neon"
  },
  ["nvim-autopairs"] = {
    config = { "require('config.autopairs')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-compe"] = {
    config = { "require('config.compe')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "require('config.lsp')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-luapad"
  },
  ["nvim-tree.lua"] = {
    config = { "require('config.nvim-tree')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.treesitter')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-yarp"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/nvim-yarp"
  },
  ["omnisharp-vim"] = {
    config = { "require('config.omnisharp')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle" },
    config = { "require('config.treesitterplayground')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "require('config.telescope')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "require('config.trouble')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["ts-snippets"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/ts-snippets"
  },
  ["typescript-vim"] = {
    config = { "require('config.typescript')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ultisnips = {
    config = { "require('config.ultisnips')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-prettier"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-sensible"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vue"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/opt/vim-vue"
  },
  ["vim-zoom"] = {
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vim-zoom"
  },
  vimwiki = {
    config = { "require('config.vimwiki')" },
    loaded = true,
    path = "/home/st1/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('config.indentguides')
time([[Config for indent-blankline.nvim]], false)
-- Config for: kartograaf.nvim
time([[Config for kartograaf.nvim]], true)
require('mappings')
time([[Config for kartograaf.nvim]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
require('config.lspkind')
time([[Config for lspkind-nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('config.lsp')
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('config.nvim-tree')
time([[Config for nvim-tree.lua]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
require('config.lspsaga')
time([[Config for lspsaga.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('config.lualine')
time([[Config for lualine.nvim]], false)
-- Config for: ncm2
time([[Config for ncm2]], true)
require('config.ncm2')
time([[Config for ncm2]], false)
-- Config for: neon
time([[Config for neon]], true)
require('config.neon')
time([[Config for neon]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
require('config.trouble')
time([[Config for trouble.nvim]], false)
-- Config for: vimwiki
time([[Config for vimwiki]], true)
require('config.vimwiki')
time([[Config for vimwiki]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('config.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: typescript-vim
time([[Config for typescript-vim]], true)
require('config.typescript')
time([[Config for typescript-vim]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
require('config.ultisnips')
time([[Config for ultisnips]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
require('config.compe')
time([[Config for nvim-compe]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require('config.autopairs')
time([[Config for nvim-autopairs]], false)
-- Config for: hop
time([[Config for hop]], true)
require('config.hop')
time([[Config for hop]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSPlaygroundToggle lua require("packer.load")({'playground'}, { cmd = "TSPlaygroundToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-prettier'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-prettier'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-prettier'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-prettier', 'vim-vue'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType vue ++once lua require("packer.load")({'vim-prettier', 'vim-vue'}, { ft = "vue" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'betterlua.vim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType cs ++once lua require("packer.load")({'omnisharp-vim', 'ale', 'fzf.vim'}, { ft = "cs" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-prettier'}, { ft = "css" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/cake.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/cake.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/cake.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/csx.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/csx.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/csx.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/omnisharplog.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/omnisharplog.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/omnisharp-vim/ftdetect/omnisharplog.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/svelte.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/svelte.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/svelte.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]], false)
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-vue/ftdetect/vue.vim]], true)
vim.cmd [[source /home/st1/.local/share/nvim/site/pack/packer/opt/vim-vue/ftdetect/vue.vim]]
time([[Sourcing ftdetect script at: /home/st1/.local/share/nvim/site/pack/packer/opt/vim-vue/ftdetect/vue.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
