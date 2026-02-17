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
          ruff = { require_cwd = true },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          typescript = { "biome-check", "prettierd", stop_after_first = true },
          typescriptreact = { "biome-check", "prettierd", stop_after_first = true },
          javascript = { "biome", "prettierd", stop_after_first = true },
          javascriptreact = { "biome-check", "prettierd", stop_after_first = true },
          html = { "prettierd" },
          htmldjango = { "prettierd" },
          css = { "prettierd" },
        },
      })
    end,
  },
}
