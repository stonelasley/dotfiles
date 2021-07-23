require('telescope').setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    },
   frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
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

