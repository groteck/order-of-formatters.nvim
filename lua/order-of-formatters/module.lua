---@class OrderOfFormatters
local M = {}

-- Here we will store the format options we will have
-- a filetype, an order element and then the command to run
--
-- @type table {filetype: string, order: number, command: string}
M.format_options = {}

---@param option {filetype: string, order: number, command: string}
M.add_format_option = function(option)
  table.insert(M.format_options, option)
end

M.reset_format_options = function()
  M.format_options = {}
end

---@param filetype string
---@return table {filetype: string, order: number, command: string}
M.options_by_filetype_sorted = function(filetype)
  local options = {} -- the options we will return

  -- filter the options by filetype
  for _, option in ipairs(M.format_options) do
    if option.filetype == filetype then
      table.insert(options, option)
    end
  end

  -- sort the options by order
  table.sort(options, function(a, b)
    return a.order < b.order
  end)

  return options
end

return M
