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
          biome = {
            require_cwd = true,
            cwd = require("conform.util").root_file({ "biome.json" })
          },
          ["biome-check"] = {
            require_cwd = true,
            cwd = require("conform.util").root_file({ "biome.json" })
          },
          eslint_d = {
            require_cwd = true,
            cwd = require("conform.util").root_file({
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
            }),
          },
          ruff = { require_cwd = true },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          typescript = { "eslint_d", "biome-check", "prettierd", stop_after_first = true },
          typescriptreact = { "eslint_d", "biome-check", "prettierd", stop_after_first = true },
          javascript = { "eslint_d", "biome-check", "prettierd", stop_after_first = true },
          javascriptreact = { "eslint_d", "biome-check", "prettierd", stop_after_first = true },
          html = { "prettierd" },
          htmldjango = { "prettierd" },
          css = { "prettierd" },
        },
      })
    end,
  },
}
