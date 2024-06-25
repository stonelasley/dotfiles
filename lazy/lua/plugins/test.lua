return {
  { "nvim-neotest/neotest-plenary", "issafalcon/neotest-dotnet" },

  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-plenary", "neotest-dotnet" } },
  },
}
