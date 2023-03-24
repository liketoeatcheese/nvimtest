--[[ require('aurora').setup() ]]
--[[ if vim.o.ft == 'yaml' then ]]
--[[   vim.api.nvim_set_hl(0, '@string', {fg='#59E343'}) ]]
--[[   vim.api.nvim_set_hl(0, '@field', {fg='#f93393'}) ]]
--[[   vim.api.nvim_set_hl(0, '@number', {fg='#e933e3'}) ]]
--[[ end ]]
vim.cmd("colorscheme nightfly")
local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "Normal", true)

 if hl["background"] == nil then

     bg = "NONE"

end


