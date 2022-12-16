--print('Loading the LuaSnip file')

local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = false,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

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

-----------------------------
---   SNIPET DEFINITION   ---
-----------------------------

--Definting snippets. Using VS Code style snippets
--ls.parser.parser(<text>, <VS style snippet>)

-- This is the snippet table. It defines snippets for each filetype
-- $1, $2 .. are the placeholders where we jump to complete the snippet.
-- $0 is counterintuitively the final placeholder.
ls.snippet = {
    all = {
        -- Available snippets for all filetypes
        ls.parser.parse_snippet('expand','-- this is what expanded'),
    },

    lua = {
        --Lua specific snippets
    },


    c = {
        -- C specific snippets
        --
        ls.parser.parse_snippet('for','for(int $1=$2; $1$3$4){\n}'),
    },
}


----------------------------------
---     KEYMAP DEFINITIONS     ---
----------------------------------

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
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

-- shorcut to source my luasnips file again, which will reload my snippets
--vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')
