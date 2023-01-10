------------------------------------------------------------------------------
--                   S N I P E T    D E F I N I T I O N                     --
------------------------------------------------------------------------------

-- A snippet is defined with the following function
-- require("luasnip").snippet which we have shorthanded to simply s
-- s({trig="", name="" dscr="" },{})
--
--
--- Defines the a luadoc header
local function LUALuadocHeader()
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

return {
    --Regular snippets
    --Documentation Related
    LUALuadocHeader()
},{
    --autosnippets
}
