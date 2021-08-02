require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "swap", 
      "node_modules",
      ".vendor",
      "yarn.lock",
      ".nuxt"
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true
    },
   frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {
        "*.git/*",
        "*/tmp/*",
        "*/swap/*",
        "*/node_modules/*"
      },
      workspaces = {
        ["conf"]    = "/home/st1/.st1",
        ["project"] = "/home/st1/projects",
        ["wiki"]    = "/home/st1/vimwiki"
      }
    } 
  }
}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('frecency')

