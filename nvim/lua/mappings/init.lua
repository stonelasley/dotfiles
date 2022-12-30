local M = {}

M.normal = {
  f = {
    [[<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = false })<cr>]],
    "Hop forward",
  },
  F = {
    [[<cmd>lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>]],
    "Hop backward",
  },
  [","] = { ",<c-g>u", "break undo ','" },
  ["."] = { ".<c-g>u", "break undo '.'" },
  [";"] = { ";<c-g>u", "break undo ';'" },
  ["<C-h>"] = { "<cmd> :TmuxNavigateLeft<CR>", "TmuxNavLeft" },
  ["<C-j>"] = { "<cmd> :TmuxNavigateDown<CR>", "TmuxNavigateDown " },
  ["<C-k>"] = { "<cmd> :TmuxNavigateUp<CR>", "TmuxNavigateUp" },
  ["<C-l>"] = { "<cmd> :TmuxNavigateRight<CR>", "TmuxNavigateRight" },
  ["<C-n>"] = { "<cmd> :NvimTreeToggle<CR>", "פּ Nvim Tree" },
  ["<C-p>"] = { "<cmd>Telescope find_files<CR>", " Find Files" },
  ["<C-f>"] = { "<cmd> :Telescope live_grep<CR>", " Live Grep" },
  ["<C-=>"] = { "zm", " Zoom In" },
  ["<C-->"] = { "zr", " Zoom Out" },
  ["<M-h>"] = { "<cmd>:vertical resize+2<CR>", "Vertical Resize +2" },
  ["<M-j>"] = { "<cmd>:resize-2<CR>", "Resize -2" },
  ["<M-k>"] = { "<cmd>:resize+2<CR>", "Resize +2" },
  ["<M-l>"] = { "<cmd>:vertical resize-2<CR>", "Vertical Resize -2" },
}

M.normal_leader = {
  g = {
    name = " +Git",
    b = { "<cmd>Telescope git_branches<CR>", " Branches" },
    B = { "<cmd>Git blame<cr>", "什Blame" },
    c = { "<cmd>Telescope git_bcommits<CR>", " Commits" },
    p = { "<cmd>Git push<cr>", " push" },
    s = { "<cmd>Git<cr>", " Status" },
    u = { "<cmd>Git pull<cr>", " pull" },
  },
  y = { '"+y', "yank" },
  d = { '"_d', "delete" },
  Y = { 'gg"+yG', "Select All" },
  t = {
    name = " +Telescope",
    f = { "<cmd>Telescope find_files<CR>", " Find Files" },
    g = { "<cmd>Telescope live_grep<CR>", " Live Grep" },
    b = { "<cmd>Telescope buffers<CR>", "﬘ Buffers" },
    c = { "<cmd>Telescope command_history<CR>", " Commands" },
    t = { "<cmd>Telescope tags<CR>", " Tags" },
    o = { "<cmd>Telescope vim_options<CR>", " Vim Options" },
    r = { "<cmd>Telescope reloader<CR>", "勒 Reload" },
    h = { "<cmd>Telescope help_tags<CR>", "ﬤ Help Tags" },
    s = { "<cmd>:lua require('st1.telescope').focus_find()<CR>", " Dot Files" },
  },
  P = {
    name = " +Packer",
    s = { "<cmd>PackerStatus<CR>", "  Status" },
    u = { "<cmd>PackerUpdate<CR>", "מּ  Update" },
    i = { "<cmd>PackerInstall<CR>", "  Install" },
    c = { "<cmd>PackerCompile<CR>", "  Compile" },
    l = { "<cmd>PackerClean<CR>", "  Clean" },
    y = { "<cmd>PackerSync<CR>", "מּ  Sync" },
  },
  c = {
    name = " Terminal",
    o = { "<cmd>ToggleTerm<CR>", "烙 Open" },
  },
}

M.vis_sel_leader = {
  p = { '"_dP', "delete" },
  y = { '"+y', "yank" },
}

M.visual_leader = {
  p = { '"_dP', "delete" },
  y = { '"+y', "yank" },
}

M.command = {
  ["w!!"] = { "w !sudo tee %", "Sudo Write" },
}

M.terminal = {
  ["<C-h>"] = { "<Cmd>wincmd h<CR>", "Terminal Left" },
  ["<C-j>"] = { "<Cmd>wincmd j<CR>", "Terminal Down" },
  ["<C-k>"] = { "<Cmd>wincmd k<CR>", "Terminal Up" },
  ["<C-l>"] = { "<Cmd>wincmd l<CR>", "Terminal Right" },
  ["<Esc>"] = { [[<C-\><C-n>]], "Terminal Escape" },
  ["jk"] = { [[<C-\><C-n>]], "Terminal Escape" },
}

return M
