local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- TODO fix the config and install nvim-jdtls later if needed
-- https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-jar', 'C:/Users/boole/AppData/Local/nvim-data/lsp-servers/jdtls/plugins/org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar',
    '-configuration', vim.fn.stddata("config") .. "/lua",
    '-data', vim.fn.expand('.cache/jdtls-workspace') .. workspace_dir,

  },

  root_dir = require('jdtls.setup').find_root({'mvnw', 'gradlew'}),
  capabilities = capabilities,

  settings = {
    java = {
    }
  },
  
  init_options = {
    bundles = {}
  },
}


require('jdtls').start_or_attach(config)
