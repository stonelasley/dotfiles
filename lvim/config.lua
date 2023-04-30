--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
--

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = "<cmd>Telescope find_files<cr>"
lvim.keys.normal_mode["<C-f>"] = "<cmd>Telescope live_grep<cr>"
lvim.keys.normal_mode["<C-n>"] = "<cmd>NvimTreeToggle<cr>"
-- lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('nvim-tmux-navigiation').NvimTmuxNavigateLeft()<cr>"
-- lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('nvim-tmux-navigiation').NvimTmuxNavigateRight()<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- LSP
-- lvim.lsp.buffer_mappings.normal_mode["<F2>"] = { "<CMD>lua require('renamer').rename()<CR>", "Rename Symbol" }
-- lvim.lsp.buffer_mappings.normal_mode["<F12>"] = { "<CMD>lua vim.lsp.buf.format({async = true})<CR>", "Rename Symbol" }
-- lvim.builtin.which_key.mappings["la"] = { "<CMD>CodeActionMenu<CR>", "Code Action Menu" }

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "tokyonight"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", file = { "lua" } },
	--   {
	--     command = "prettier",
	--     extra_args = { "--print-width", "100" },
	--     filetypes = { "typescript", "typescriptreact" },
	--   },
	{ command = "csharpier", filetypes = { "cs" } },
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "eslint_d", filetypes = { "typescript", "javascript" } },
	--   {
	--     command = "shellcheck",
	--     args = { "--severity", "warning" },
	--   },
})
-- DAP
-- lvim.builtin.dap.active = true

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	-- {
	-- 	"github/copilot.vim",
	-- 	config = function()
	-- 		vim.cmd([[
	--        let g:copilot_filetypes = {
	--          \ 'telescope': v:false,
	--          \ 'TelescopePrompt': v:false,
	--          \ 'TelescopeResult': v:false,
	--          \ 'help': v:false,
	--          \ }
	--        imap <silent><script><expr> <C-E> copilot#Accept("\<CR>")
	--        let g:copilot_no_tab_map = v:true
	--    ]])
	-- 	end,
	-- },
	--	{
	--		"alexghergh/nvim-tmux-navigation",
	--		opts = {
	--			disable_when_zoomed = true,
	--		},
	--	},
	--	{ "dhruvasagar/vim-zoom", event = "BufRead" },
	--	{
	--		"weilbith/nvim-code-action-menu",
	--		cmd = "CodeActionMenu",
	--	},
	--	{
	--		"filipdutescu/renamer.nvim",
	--		config = true,
	--		lazy = true,
	--	},
	--	{
	--		"max397574/better-escape.nvim",
	--		event = "InsertEnter",
	--		opts = {
	--			mapping = { "jk" },
	--		},
	--	},
}

-- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- local augroup = vim.api.nvim_create_augroup
-- local autocmd = vim.api.nvim_create_autocmd

-- augroup("st1", { clear = true })

-- autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank({ higroup = "IncSearch" })
-- 	end,
-- 	group = "st1",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
