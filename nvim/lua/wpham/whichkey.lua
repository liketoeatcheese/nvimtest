local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,    -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,   -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,   -- default bindings on <c-w>
      nav = true,       -- misc bindings to work with windows
      z = true,         -- bindings for folds, spelling and others prefixed with z
      g = true,         -- bindings for prefixed with g
    },
  },
  key_labels = {},
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",    -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",     -- none, single, double, shadow
    position = "bottom",    -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                            -- min and max height of the columns
    width = { min = 20, max = 50 },                                            -- min and max width of the columns
    spacing = 3,                                                               -- spacing between columns
    align = "left",                                                            -- align columns left, center or right
  },
  ignore_missing = true,                                                       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                            -- show help message on the command line when the popup is visible
  triggers = "auto",                                                           -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",    -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file to Harpoon" },
  ["b"] = {
    "<cmd>ChatGPT<cr>",
    "ChatGPT",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["h"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Harpoon menu" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>FzfLua colorschemes<cr>", "Colorscheme" },
  ["s"] = { "<cmd>so %<cr>", "Source file" },
  ["u"] = { "<cmd>ZenMode<cr>", "ZenMode" },
  ["o"] = { "<cmd>LspSymbols<cr>", "Outline" },

	v = {
		name = "Visit",
		l = { "<cmd>VisitLinkUnderCursor<cr>", "Visit Link" },
		f = {
			function()
				local file_path = vim.fn.expand("<cfile>")
				if string.match(file_path, "/home/wpham/") then
					os.execute(
						"nohup cmd.exe /C start file://wsl.localhost/fedora" .. file_path .. " > /dev/null 2>&1 &"
					)
				else
					print("Please get a full path")
				end
			end,
			"Visit WSL file in browser using full path",
		},
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  r = {
    n = { "<cmd>bufdo e<cr>", "Reload buffer" },
  },
  f = {
    name = "Fuzzy Finder",
    cw = {
      ":lua require('fzf-lua').files({ cwd = '/mnt/c/Users/William/Downloads' })<CR>",
      "Search files on C drive - Downloads",
    },
    cd = {
      ":lua require('fzf-lua').files({ cwd = '/mnt/c/Users/William/Documents' })<CR>",
      "Search files on C drive - Documents",
    },
    h = { ":lua require('fzf-lua').command_history()<CR>", "Search command history" },
    s = { ":lua require('fzf-lua').search_history()<CR>", "Search search history" },
    f = { ":lua require('fzf-lua').files()<CR>", "Find files in the current directory" },
    on = { ":set foldmethod=indent<cr>za", "fold objects" },
    of = { ":set nofoldenable<cr>", "unfold objects" },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    r = { "<cmd>LspInstallInfo<cr>", "Find references" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
  },
  t = {
    name = "Troubleshoot",
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "NCDU" },
    lr = { "<cmd>TroubleToggle lsp_references<cr>", "Htop" },
    ld = { "<cmd>TroubleToggle lsp_definitions<cr>", "Python" },
    ltd = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Python" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Float" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Horizontal" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
