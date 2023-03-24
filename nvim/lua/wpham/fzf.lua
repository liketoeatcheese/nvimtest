local fzf_status_ok, fzf = pcall(require, "fzf-lua")
if not fzf_status_ok then
  return
end

fzf.setup({
  files = {
    fd_opts = "--color=never --type f --hidden --follow --exclude '{.local,.jbang,.m2,,.jdt,n/n/*,n/include/*,.*/n/.*,apisix,.npm,camel,bin/.git*,perl5,.nix-profile,.cpanm,.cache,.git,graalvm*,bin/graalvm*,n/*,nvimconfig,.nix-defexpr,.config/TabNine*,.config/yarn*,go/pkg*,.config/nvim/vscode-java-test*,.config/nvim/node_modules,.config/nvim/java-debug*,perl,.sdkman}'",
  },
  previewers = {
    builtin = {
      syntax = true, -- preview syntax highlight?
      syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
      syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
      limit_b = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
      -- preview extensions using a custom shell command:
      -- for example, use `viu` for image previews
      -- will do nothing if `viu` isn't executable
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["png"] = { "viu", "-b" },
      },
    },
  },
  keymap = {
    fzf = {
      ["ctrl-d"]     = "half-page-down",
      ["ctrl-u"]     = "half-page-up",
      ["tab"]        = "down",
      ["shift-tab"]  = "up",
    }
  }
})
