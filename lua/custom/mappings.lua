---@type MappingsTable
local M = {}

--vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)

M.general = {
  n = {
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["H"] = { "0" },
    ["K"] = { "^" },
    ["L"] = { "$" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

-- sets gx to open urls
local open_command = "xdg-open"
if vim.fn.has "mac" == 1 then
  open_command = "open"
end

local function url_repo()
  local cursorword = vim.fn.expand "<cfile>"
  if string.find(cursorword, "^[a-zA-Z0-9-_.]*/[a-zA-Z0-9-_.]*$") then
    cursorword = "https://github.com/" .. cursorword
  end
  return cursorword or ""
end

vim.keymap.set("n", "gx", function()
  vim.fn.jobstart({ open_command, url_repo() }, { detach = true })
end, { silent = true })

return M
