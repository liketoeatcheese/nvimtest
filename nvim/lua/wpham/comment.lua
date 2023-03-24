local comment_status_ok, comment = pcall(require, "Comment")
if not comment_status_ok then
  print("can't not pull comment plugin")
  return
end

local comment_context_status_ok, comment_context = pcall(require, "nvim-treesitter.configs")
if not comment_context_status_ok then
  print("can't not pull comment context plugin")
  return
end

comment_context.setup {
  context_commentstring = {
    enable = true
  }
}
comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
