return {
  {
    "stevearc/conform.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        cwd = require("conform.util").root_file({
          ".editorconfig",
          "package.json",
          "pyproject.toml",
          "uv.lock",
        }),
        formatters = {
          prettier = { require_cwd = true },
          biome = { require_cwd = true },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff", "black", stop_after_first = true },
          typescriptreact = function(bufnr)
            if require("conform").get_formatter_info("biome", bufnr).available then
              return { "biome", "biome-organize-imports" }
            else
              return { "prettierd" }
            end
          end,
          javascript = { "biome", "prettierd", stop_after_first = true },
          javascriptreact = { "biome", "prettierd", stop_after_first = true },
          typescript = { "biome", "prettierd", stop_after_first = true },
          html = { "prettierd" },
          htmldjango = { "prettierd" },
          css = { "prettierd" },
        },
      })
    end,
  },
}
