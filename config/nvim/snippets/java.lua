local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

local cptemplate = s(
  "cptemplate",
  fmt(
    [[
import java.io.*;
import java.util.*;

public class {} {{
    static Reader bf = new Reader();
    static PrintWriter out = new PrintWriter(System.out);

    public static void main(String[] args) throws IOException {{
        int testcases = 1;
        // testcases = bf.nextInt();
        for(int t=1; t<=testcases; t++) {{
            // out.print("Case " + t + ": ");
            solve();
        }}

        out.flush(); out.close();
    }}

    public static void solve() {{
        return;
    }}

    static class Reader {{ 
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer("");
        public String next() {{
            while(!st.hasMoreTokens()) {{
                try {{ st = new StringTokenizer(br.readLine()); }}
                catch(Exception e) {{ e.printStackTrace(); }}
            }}
            return st.nextToken();
        }}
        public int nextInt() {{ return Integer.parseInt(next()); }}
        public long nextLong() {{ return Long.parseLong(next()); }}
        public double nextDouble() {{ return Double.parseDouble(next()); }}
        public String nextLine() {{
            try {{ return br.readLine(); }}
            catch(Exception e) {{ e.printStackTrace(); }}
            return null;
        }}
        public boolean hasNext() {{
            String next = null;
            try {{ next = br.readLine(); }}
            catch(Exception e) {{}}
            if(next == null) return false;
            st = new StringTokenizer(next);
            return true;
        }}
    }}
}}
]],
    { i(1, "Main") }
  )
)

table.insert(snippets, cptemplate)

-- End Refactoring --

return snippets, autosnippets
