-- Format on save and linters
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- list of formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'checkmake',
        'prettierd', -- ts/js formatter
        'prettier',  -- ts/js formatter
        'stylua',    -- lua formatter
        'prismals',
        'terraform_fmt',
        'eslint_d', -- ts/js linter
        'shfmt',
        'ruff',
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with {
        filetypes = {
          'html',
          'json',
          'yaml',
          'markdown',
          'markdown_inline',
          'css',
          'scss',
          'javascript',
          'typescript',
          'typescriptreact',
          'javascriptreact',
          'vue',
          'prisma',
          'svelte',
        },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.prismals,
      formatting.terraform_fmt,
      null_ls.builtins.formatting.prettier.with {
        extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote', '--trailing-comma', 'all' },
      },
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
