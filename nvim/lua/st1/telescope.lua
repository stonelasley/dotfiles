local find_files = require("telescope.builtin").find_files
local M = {}

M.focus_find = function(path)
    local wd = "$HOME/.st1"
    if path ~= nil then
        wd = wd.."/"..path
    end
    find_files({
        prompt_title = "< St1 Config >",
        cwd = wd,
        hidden = true,
        file_ignore_patterns = {'.git'}
    })
end

return M
