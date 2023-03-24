local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
	print("couldn't load buffer line")
	return
end

bufferline.setup({
	highlights = {
		background = {
			italic = true,
			fg = "#9d9d9d",
		},
		buffer_selected = {
			--[[ fg = "#eeedf0", ]]
			fg = "#56daed",
			bold = true,
			italic = true,
		},
		buffer_visible = {
			fg = "#9d9d9d",
		},
	},
	options = {
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		diagnostics = "nvim_lsp",
		separator_style = "slant",
		show_tab_indicators = true,
	},
})
