vim.api.nvim_create_user_command("MyFirstFunction", require("order-of-formatters").hello, {})
