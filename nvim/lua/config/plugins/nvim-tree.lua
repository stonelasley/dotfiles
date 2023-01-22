require("nvim-tree").setup {
  filters = {
    dotfiles = false,
    custom = { ".git", "bin/", "obj/", ".vendor/" },
  },
}
