local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< St1 Config >",
        cwd = "$HOME/.st1",
        hidden = true,
    })
end

return M
