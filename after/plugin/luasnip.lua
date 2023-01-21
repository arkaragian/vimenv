-- Sorthand definitions that are in the official luasnip documentation
-- This allows us to easily copy and modify existing examples
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,


  --load_ft_func =
  -- Also load tex when a plaintex-file is opened,
  -- javascript for html.
  -- Other filetypes just load themselves.
  --require("luasnip.extras.filetype_functions").extend_load_ft({
  --    plaintex = {"tex"},
  --}),

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}


------------------------------------------------------------------------------
--                             L O A D E R S                                --
------------------------------------------------------------------------------

--the files may return two lists of snippets, the snippets in the first are all
--added as regular snippets, while the snippets in the second will be added as
--autosnippets (both are the defaults, if a snippet defines a different snippet-
--Type, that will have preference)
--
-- Make lusnip to load all latex plugins even though we might have multiple tex
-- variations.
--ls.filetype_extend("tex", { "latex", "plaintex" })
--ls.filetype_extend("latex", { "tex", "plaintex" })
--ls.filetype_extend("plaintex", { "tex", "latex" })
--This will look for a folder named luasnippet and lazy load any snippets that
--may be required based on the filetype.
require("luasnip.loaders.from_lua").lazy_load()


------------------------------------------------------------------------------
---                  K E Y M A P   D E F I N I T I O N S                   ---
------------------------------------------------------------------------------

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
    print("Expanding Snippet!")
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set('i', '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set('i', '<c-u>', require 'luasnip.extras.select_choice')

local sourcePath = os.getenv("NVCONF") .. "/after/plugin/luasnip.lua"
-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set('n', '<Leader>L', '<Cmd>lua require("luasnip.loaders.from_lua").load()<CR>',{desc = "Reload Lua snippets"})
