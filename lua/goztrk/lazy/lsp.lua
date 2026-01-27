return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
    },
    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      local function set_python_path(command)
        local path = command.args
        local clients = vim.lsp.get_clients {
          bufnr = vim.api.nvim_get_current_buf(),
          name = 'pyright',
        }
        for _, client in ipairs(clients) do
          if client.settings then
            client.settings.python =
                vim.tbl_deep_extend('force', client.settings.python --[[@as table]], { pythonPath = path })
          else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings,
              { python = { pythonPath = path } })
          end
          client:notify('workspace/didChangeConfiguration', { settings = nil })
        end
      end

      require("mason").setup({
        ensure_installed = {
          "prettierd",
          "html",
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "vtsls",
          "tailwindcss",
          -- "rust_analyzer",
          -- "gopls",
          -- "templ",
          -- "htmx",
          -- "ruff",
        },
        handlers = {
          function(server_name)
            vim.lsp.config(server_name, { capabilities = capabilities })
          end,
        },
        ['pyright'] = function()
          vim.lsp.config('pyright', {
            cmd = { 'pyright-langserver', '--stdio' },
            filetypes = { 'python' },
            root_markers = {
              'pyrightconfig.json',
              'pyproject.toml',
              'setup.py',
              'setup.cfg',
              'requirements.txt',
              'Pipfile',
              '.git',
            },
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = 'openFilesOnly',
                },
              },
            },
            on_attach = function(client, bufnr)
              vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
                local params = {
                  command = 'pyright.organizeimports',
                  arguments = { vim.uri_from_bufnr(bufnr) },
                }

                -- Using client.request() directly because "pyright.organizeimports" is private
                -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
                -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
                ---@diagnostic disable-next-line: param-type-mismatch
                client.request('workspace/executeCommand', params, nil, bufnr)
              end, {
                desc = 'Organize Imports',
              })
              vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
                desc = 'Reconfigure pyright with the provided python path',
                nargs = 1,
                complete = 'file',
              })
            end,
          })
        end,
        ['lua_ls'] = function()
          vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
              Lua = {
                format = {
                  enable = true,
                  -- Put format options here
                  -- NOTE: the value should be STRING!!
                  defaultConfig = {
                    indent_style = 'space',
                    indent_size = '2'
                  },
                },
              },
            },
          })
        end,
        ['tailwindcss'] = function()
          vim.lsp.config('tailwindcss', {
            capabilities = capabilities,
            filetypes = {
              'html', 'css', 'scss',
              'javascript', 'javascriptreact',
              'typescript', 'typescriptreact',
              'vue', 'svelte', 'heex',
            }
          })
        end,
      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
        }),
        sources = cmp.config.sources({
          { name = "copilot", group_index = 2 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        }),
      })

      vim.diagnostic.config({
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        }
      })
    end,
  },
}
