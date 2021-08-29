require('kartograaf').map({
  n = {
    {
      mod = 'C',
      { 'n', ':NvimTreeToggle<CR>' },
    },
    {
      prefix = 'leader',
      { 'r', ':NvimTreeRefresh<CR>' },
      { 'n', ':NvimTreeFindFile<CR>' },
    }
  }
})
