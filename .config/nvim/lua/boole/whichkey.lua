local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  preset = "modern", -- choose layouts from these options: classic, modern, and helix
  plugins = { marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
    ellipsis = "…",
    -- set to false to disable all mapping icons,
    -- both those explicitely added in a mapping
    -- and those from rules
    mappings = true, --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    ---@type wk.IconRule[]|false
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰘴 ",
      M = "󰘵 ",
      D = "󰘳 ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  win = {
    no_overlap = true,
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "center", -- left, center, right
    zindex = 1000,
    bo = {},
    wo = {
      winblend = 20,
    },

    -- border = "rounded", -- none, single, double, shadow
    -- position = "bottom", -- bottom, top
    -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = {
    { "<auto>", mode = "nixsotc" }, -- automatically setup triggers
  },
  -- triggers = {"<leader>"} -- or specify a list manually
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)

which_key.add({
  { "<leader>a", "<cmd>Alpha<cr>", group = "Dashboard", mode = "n" },

  { "<leader>b",
    group = "Buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
    mode = "n"
  },
  { "<leader>c", "<cmd>Bdelete!<cr>", group = "Close Buffer", mode = "n" },

  { "<leader>e", "<cmd>NvimTreeToggle<cr>", group = "Explorer", mode = "n" },

  { "<leader>w", "<cmd>w!<cr>", group = "Save", mode = "n" },
  { "<leader>q", "<cmd>q!<cr>", group = "Quit", mode = "n" },

  { "<leader>h", "<cmd>nohlsearch<cr>", group = "Clear Highlights", mode = "n" },

  { "<leader>P", "<cmd>Telescope projects<cr>", group = "Open Project", mode = "n" },


  { "<leader>p", group = "Packer", mode = "n" },
  { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile", mode = "n" },
  { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install", mode = "n" },
  { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync", mode = "n" },
  { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status", mode = "n" },
  { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update", mode = "n" },


  { "<leader>g", group = "Git", mode = "n" },
  { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit", mode = "n" },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", mode = "n" },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", mode = "n" },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", mode = "n" },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", mode = "n" },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", mode = "n" },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", mode = "n" },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", mode = "n" },
  {
    "<leader>gu",
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    desc = "Undo Stage Hunk",
    mode = "n"
  },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", mode = "n" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", mode = "n" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", mode = "n" },
  {
    "<leader>gd",
    "<cmd>Gitsigns diffthis HEAD<cr>",
    desc = "Diff",
    mode = "n"
  },


  { "<leader>k", group = "Keylab", mode = "n" },
  { "<leader>kl", "<cmd>KeylabStart<cr>", desc = "Start New Keylab Session", mode = "n" },
  { "<leader>ks", "<cmd>KeylabStop<cr>", desc = "Stop Current Keylab Session", mode = "n" },


  { "<leader>l", group = "LSP", mode = "n" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "n" },
  { "<leader>ld", "<cmd>lua vim.lsp.buf.definition<cr>", desc = "Definition", mode = "n" },
  { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Declaration", mode = "n" },
  {
    "<leader>lf",
    "<cmd>lua vim.lsp.buf.format({async=true, formatting_options={tabSize=4}})<cr>",
    desc = "Format",
    mode = "n"
  },
  { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover", mode = "n" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", mode = "n" },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info", mode = "n" },
  { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>", desc = "Next Diagnostic", mode = "n" },
  { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>", desc = "Prev Diagnostic", mode = "n" },
  { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", mode = "n" },
  { "<leader>ln", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature", mode = "n" },
  { "<leader>lo", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<cr>", desc = "Open Diagnostics", mode = "n" },
  { "<leader>lp", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Implementation", mode = "n" },
  { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix", mode = "n" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
  { "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References", mode = "n" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", mode = "n" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workplace Symbols", mode = "n" },


  { "<leader>m", group = "Minimap", mode = "n" },
  { "<leader>mo", "<cmd>lua require 'codewindow'.open_minimap()<cr>", desc = "Open Minimap", mode = "n" },
  { "<leader>mc", "<cmd>lua require 'codewindow'.close_minimap()<cr>", desc = "Close Minimap", mode = "n" },
  { "<leader>mm", "<cmd>lua require 'codewindow'.toggle_minimap()<cr>", desc = "Toggle Minimap", mode = "n" },
  { "<leader>mf", "<cmd>lua require 'codewindow'.toggle_focus()<cr>", desc = "Toggle Minimap Focus", mode = "n" },


  { "<leader>n", group = "Comment", mode = "nv" },
  { "<leader>nf", "<cmd>lua require('neogen').generate()<cr>", desc = "Generate Function Documentation", mode = "n" },
  { "<leader>nc", "<cmd>lua require('neogen').generate({ type = 'class' })<cr>", desc = "Generate Class Documentation", mode = "n" },


  { "<leader>s", group = "Search", mode = "n" },
  { "<leader>st", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "File Text", mode = "n" },
  {
    "<leader>sf",
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    desc = "Open File",
    mode = "n"
  },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Documentation", mode = "n" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", mode = "n" },
  { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers", mode = "n" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n" },


  { "<leader>t", group = "Terminal", mode = "n" },
  { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", mode = "n" },
  { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", mode = "n" },
  { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", mode = "n" },
  { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", mode = "n" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", mode = "n" },
  { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", mode = "n" },
  { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", mode = "n" },
})
