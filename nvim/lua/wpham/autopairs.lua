local autopair_status_ok, autopairs = pcall(require, "nvim-autopair")
if not autopair_status_ok then
  return
end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

