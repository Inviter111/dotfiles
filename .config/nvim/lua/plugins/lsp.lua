return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', opts = { PATH = 'append' } },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    { 'mrcjkb/rustaceanvim', version = '^5', lazy = false },
  },
  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  config = function()
    local on_attach = function(client, bufnr)
      print('LSP started: ' .. client.name)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

    require('mason').setup()
    require('mason-lspconfig').setup()
    -- require('typescript-tools').setup({
    --   expose_as_code_action = { 'add_missing_imports' },
    --   on_attach = on_attach,
    -- })

    local servers = {
      -- clangd = {},
      gopls = {},
      pyright = {},
      rust_analyzer = { _ignore = true },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      ts_ls = { _ignore = true },
      vtsls = { vtsls = { autoUseWorkspaceTsdk = true } },
      zls = {},

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          diagnostics = { globals = { 'vim', 'require' } },
        },
      },
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Filter out ignored servers
    local active_servers = {}
    for server_name, server_config in pairs(servers) do
      if not server_config._ignore then
        active_servers[server_name] = server_config
      end
    end

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(active_servers),
    }

    -- Setup LSP servers using vim.lsp.config
    for server_name, server_config in pairs(active_servers) do
      vim.lsp.config[server_name] = {
        cmd = server_config.cmd,
        root_markers = server_config.root_markers,
        filetypes = server_config.filetypes,
        capabilities = capabilities,
        on_attach = on_attach,
        settings = server_config,
      }
    end

    -- Disable ignored servers by setting empty filetypes
    for server_name, server_config in pairs(servers) do
      if server_config._ignore then
        vim.lsp.config[server_name] = {
          filetypes = {},  -- Empty filetypes prevents auto-start
          autostart = false,
        }
      end
    end

    -- Elixir LSP
    require('lspconfig').elixirls.setup {
      cmd = { os.getenv 'HOME' .. '/.config/elixir-ls/language_server.sh' },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Rust
    vim.g.rustaceanvim = {
      server = {
        on_attach = on_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      },
    }
  end,
}
