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
--                   S N I P E T    D E F I N I T I O N                     --
------------------------------------------------------------------------------

-- A snippet is defined with the following function
-- require("luasnip").snippet which we have shorthanded to simply s
-- s({trig="", name="" dscr="" },{})
--
--


local function ForLoop()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "for", --trigeted with the for keyword
        name="for", -- The name of the snippet
        dscr="for loop" -- The 
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    for(int {counter}={start}; {counter2}<{limit}; {counter3}++){{
        {text}
    }}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        counter = i(1,"i"),
        start = i(2,"0"),
        counter2 = rep(1),
        limit = i(3),
        counter3 = rep(1),
        text = i(0)
    }
    return s( context, fmt(snippet_string, nodes) )
end

--- Defines an inheritdoc header in csharp
local function CSSummary()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "///", --trigeted with the for keyword
        name="summary", -- The name of the snippet
        dscr="An xml summary"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    /// <summary>
    /// {text}
    /// </summary>
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        text = i(1,"Summary"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

--- Defines an inheritdoc header in csharp
local function InheritDoc()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "inherit", --trigeted with the for keyword
        name="inheritdoc", -- The name of the snippet
        dscr="An xml documentaiton inheritdoc statement" -- The 
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    ///<inheritdoc cref={cref}/>
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        cref = i(1,"i"),
    }
    return s( context, fmt(snippet_string, nodes) )
end


--- Defines the a luadoc header
local function LuadocHeader()
    local context = {
        trig = "luadoc", --trigeted with the for keyword
        name="for", -- The name of the snippet
        dscr="A Luadoc Header" -- The 
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    --- {Header}
    -- {Description}
    -- @param {ParameterName} {ParameterDescription}
    ]]

    local nodes ={
        Header = i(1,"Header"),
        Description = i(2,"Description"),
        ParameterName = i(3,"Parameter Name"),
        ParameterDescription = i(0,"Parameter Description"),
    }
    return s( context, fmt(snippet_string, nodes) )
end


--Definting snippets. Using VS Code style snippets
--ls.parser.parser(<text>, <VS style snippet>)

-- This is the snippet table. It defines snippets for each filetype
-- $1, $2 .. are the placeholders where we jump to complete the snippet.
-- $0 is counterintuitively the final placeholder.

ls.add_snippets(nil, {
    lua = { LuadocHeader()},
    cs = {ForLoop(), CSSummary(),InheritDoc()}
})


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
vim.keymap.set('n', '<leader><leader>ss', '<cmd>source ' .. sourcePath ..'<CR>')
