local nvimtree_status_ok, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_status_ok then
  return
end

nvimtree.setup({
  sort_by = "case_sensitive",
 update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = {},
        },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    symlink_destination = false
  },
  filters = {
    dotfiles = false,
  },
})

