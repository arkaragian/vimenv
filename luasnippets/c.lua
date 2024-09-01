------------------------------------------------------------------------------
--                   S N I P E T    D E F I N I T I O N                     --
------------------------------------------------------------------------------

-- A snippet is defined with the following function
-- require("luasnip").snippet which we have shorthanded to simply s
-- s({trig="", name="" dscr="" },{})
--
--
--
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")
local isn = ls.indent_snippet_node
local events = require("luasnip.util.events")


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
local function Doxy_Summary()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "///", --trigeted with the for keyword
        name="doxyfn", -- The name of the snippet
        dscr="Doxygen function documentation"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    /**
    * {brief}
    *
    * {description}
    *
    * @param {param_name}
    */
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        brief = i(1,"brief"),
        description = i(2,"description"),
        param_name = i(3,"Parameter Name"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

return {
    --Regular snippets
    ForLoop(),
    --Documentation Related
    Doxy_Summary(),
},{
    --autosnippets
}
