-- All LuaSnip snippets

return {
  "L3MON4D3/LuaSnip",
  config = function()
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

    -- Your C++ template
    local cppcptemplate = s(
      "cptemplate",
      fmt(
        [[
#include <bits/stdc++.h>
using namespace std;


/* TYPES  */
#define ll long long
#define ld long double
#define pii pair<int, int>
#define pll pair<long long, long long>
#define vi vector<int>
#define vll vector<long long>
#define mii map<int, int>
#define si set<int>
#define sc set<char>

/* CONSTANTS */
#define f first
#define s second
#define sp <<" "
#define endl '\n'
const int MAXN = 1e5+5;
const ll MOD = 1e9+7;
const ll HMOD = 998244353;
const ll INF = 1e9;
const ld PI = 3.1415926535897932384626433832795;
const ld EPS = 1e-9;

/* UTILS */
#define read(type) readInt<type>()
ll min(ll a,int b) {{ if (a<b) return a; return b; }}
ll min(int a,ll b) {{ if (a<b) return a; return b; }}
ll max(ll a,int b) {{ if (a>b) return a; return b; }}
ll max(int a,ll b) {{ if (a>b) return a; return b; }}
ll gcd(ll a,ll b) {{ if (b==0) return a; return gcd(b, a%b); }}
ll lcm(ll a,ll b) {{ return a/gcd(a,b)*b; }}
string to_upper(string a) {{ for (int i=0;i<(int)a.size();++i) if (a[i]>='a' && a[i]<='z') a[i]-='a'-'A'; return a; }}
string to_lower(string a) {{ for (int i=0;i<(int)a.size();++i) if (a[i]>='A' && a[i]<='Z') a[i]+='a'-'A'; return a; }}
bool prime(ll a) {{ if (a==1) return 0; for (int i=2;i<=round(sqrt(a));++i) if (a%i==0) return 0; return 1; }}
void yes() {{ cout<<"YES\n"; }}
void no() {{ cout<<"NO\n"; }}

/* FUNCTIONS */
#define sz(a) ((int)a.size())
#define all(a) (a).begin(), (a).end()
#define fr(i,s,e) for(ll i=(s);i<(e);i++)
#define frn(i,n) fr(i,0,(n))
#define cfr(i,s,e) for(ll i=(s);i<=(e);i++)
#define rfr(i,e,s) for(ll i=(e)-1;i>=(s);i--)
#define afr(a) for(auto u:a)
#define pb push_back
#define eb emplace_back

/* DEBUGGING && PRINTING */
#define printv(a) {{for(auto u:a) cout<<u<<" "; cout<<endl;}}
#define printm(a) {{for(auto u:a) cout<<u.f sp u.s<<endl;}}

/*  All Required define Pre-Processors and typedef Constants */
typedef long int int32;
typedef unsigned long int uint32;
typedef long long int int64;
typedef unsigned long long int uint64;


void solve() {{
    return;
}}

int main() {{
    ios_base::sync_with_stdio(0);
    cin.tie(0); cout.tie(0);

    int tc = 1;
    // cin >> tc;
    cfr(t, 1, tc) {{
        // cout << "Case #" << t << ": ";
        solve();
    }}
}}

]],
        {}
      )
    )

    -- Your Python template
    local pycptemplate = s(
      "cptemplate",
      fmt(
        [[
import random
import math
from collections import defaultdict, Counter, deque, OrderedDict
from queue import PriorityQueue
from heapq import heapify, heappush, heappop
from functools import lru_cache, reduce
from bisect import bisect_left, bisect_right
from types import GeneratorType
import sys

MOD = 10**9+7
HMOD = 998244353
MAXN = 10**5+5
INF = 1e20
EPS = 1e-9

input = lambda : sys.stdin.readline().strip()
print = lambda *args : sys.stdout.write(" ".join(map(str, args)) + "\n")
write = lambda *args : sys.stdout.write(" ".join(map(str, args)))

getint = lambda : int(input())
getlist = lambda : list(map(int, input().split()))
getstr = lambda : list(input()) # mutable string

def solve():
    pass

testcases = 1
#testcases = getint()
for c in range(1, testcases+1):
    #write(f"Case {{c}}: ")
    solve()
]],
        {}
      )
    )

    -- Your Java template
    local javacptemplate = s(
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

    table.insert(snippets, cppcptemplate)
    table.insert(snippets, pycptemplate)
    table.insert(snippets, javacptemplate)
    -- Add snippets to their respective filetypes
    -- ls.add_snippets("cpp", { cppcptemplate })
    -- ls.add_snippets("python", { pycptemplate })
    -- ls.add_snippets("java", { javacptemplate })

    return snippets, autosnippets
  end,
}
