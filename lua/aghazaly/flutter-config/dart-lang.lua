return {
  'dart-lang/dart-vim-plugin',
  config = function()
    -- Dart setup
    require('lspconfig').dartls.setup{
      on_attach = function(client, bufnr)
        -- Customize LSP keymaps
        local buf_map = function(bufnr, mode, lhs, rhs, opts)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or { silent = true })
        end

        buf_map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
        buf_map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
        buf_map(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
        buf_map(bufnr, 'n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
        buf_map(bufnr, 'n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
        buf_map(bufnr, 'n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
        buf_map(bufnr, 'n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
        buf_map(bufnr, 'n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
        buf_map(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>')
        buf_map(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
        buf_map(bufnr, 'n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
        buf_map(bufnr, 'n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
        buf_map(bufnr, 'n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
        buf_map(bufnr, 'n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
        buf_map(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
      end,
    }
  end
}
