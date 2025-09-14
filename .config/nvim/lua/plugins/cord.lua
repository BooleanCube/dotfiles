-- Vim APM Calculator and Discord Rich Presence

return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    config = function()
      -- Simple APM tracker with key filtering
      local apm_tracker = {
        actions = {},
        current_apm = 0,
        last_key = "",
        last_time = 0,
      }

      local function track_action(key)
        local now = vim.loop.now()

        -- Filter out rapid repeats of the same key (key repeat)
        if key == apm_tracker.last_key and (now - apm_tracker.last_time) < 50 then
          return -- Ignore if same key pressed within 50ms
        end

        -- Filter out special keys and modifiers
        if key:match("^<.*>$") or #key > 1 then
          return -- Skip special keys like <Left>, <Ctrl>, etc.
        end

        apm_tracker.last_key = key
        apm_tracker.last_time = now

        table.insert(apm_tracker.actions, now)

        -- Keep only actions from the last minute
        local cutoff = now - 60000
        apm_tracker.actions = vim.tbl_filter(function(timestamp)
          return timestamp > cutoff
        end, apm_tracker.actions)

        apm_tracker.current_apm = #apm_tracker.actions
      end

      -- Set up key tracking
      vim.on_key(track_action)

      require("cord").setup({
        enabled = true,
        log_level = vim.log.levels.ERROR,
        variables = {
          apm = function()
            return tostring(apm_tracker.current_apm)
          end,
        },
        text = {
          default = nil,
          workspace = "Working on ${workspace} | ⌨️ ${apm} APM",
          viewing = "🦥 Viewing ${filename} | ${diagnostics} problems",
          editing = "🦥 Editing ${filename} | ${diagnostics} problems",
          file_browser = "🦥 Browsing files in ${name}",
          plugin_manager = "🦥 Managing plugins in ${name}",
          lsp = "🦥 Configuring LSP in ${name}",
          docs = "🦥 Reading ${name}",
          vcs = "🦥 Committing changes in ${name}",
          notes = "🦥 Taking notes in ${name}",
          debug = "🦥 Debugging in ${name}",
          test = "🦥 Testing in ${name}",
          diagnostics = "🦥 Fixing problems in ${name}",
          games = "🦥 Playing ${name}",
          terminal = "🦥 Running commands in ${name}",
          dashboard = "🦥 Home",
        },
        editor = {
          client = "neovim",
          tooltip = "The One True Text Editor",
        },
        display = {
          theme = "atom",
          flavor = "dark",
          view = "full",
          swap_fields = true,
          swap_icons = false,
        },
        timestamp = {
          enabled = true,
          reset_on_idle = false,
          reset_on_change = false,
          shared = true,
        },
        idle = {
          enabled = true,
          show_status = true,
          timeout = 300000,
          unidle_on_focus = true,
          details = "Idle",
          tooltip = "💤",
          smart_idle = true,
        },
        plugins = {
          ["cord.plugins.diagnostics"] = {
            scope = "buffer", -- 'workspace'
            severity = { min = vim.diagnostic.severity.WARN },
          },
        },
        buttons = {
          {
            label = function(opts)
              return opts.repo_url and "View Repository" or "View Portfolio"
            end,
            url = function(opts)
              return opts.repo_url or "https://booleancube.space"
            end,
          },
        },
        advanced = {
          plugin = {
            autocmds = true,
            cursor_update = "on_hold",
            match_in_mappings = true,
          },
          discord = {
            pipe_paths = nil,
            reconnect = {
              enabled = false,
              interval = 5000,
              initial = true,
            },
          },
          workspace = {
            root_markers = {
              ".git",
              ".hg",
              ".svn",
            },
            limit_to_cwd = false,
          },
        },
      })
    end,
  },
}
