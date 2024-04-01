-- main module file
local module = require("order-of-formatters.module")

---@class Config
---@field default_formatters table {{filetype: string, order: number, command: string}}
local config = {
  default_formatters = {},
}

---@class OrderOfFormattersModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})

  for _, option in ipairs(M.config.default_formatters) do
    module.add_format_option(option)
  end
end

-- This is a function that will be called by the user to register the formatter
-- @param option {filetype: string, order: number, command: string}
M.register = function(option)
  module.add_format_option(option)
end

-- This is a function that will be called by the user to reset the format options
M.reset = function()
  module.reset_format_options()
end

-- This is a function that will be called by the user to get the format options list
M.get_format_options = function()
  return module.format_options
end

-- This is a function that will be called by the user to execute the formatters
-- @param filetype string
M.execute = function(filetype)
  local options = module.options_by_filetype_sorted(filetype)

  for _, option in ipairs(options) do
    vim.cmd(option.command)
  end
end

return M
