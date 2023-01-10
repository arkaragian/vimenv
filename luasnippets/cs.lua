------------------------------------------------------------------------------
--                   S N I P E T    D E F I N I T I O N                     --
------------------------------------------------------------------------------

-- A snippet is defined with the following function
-- require("luasnip").snippet which we have shorthanded to simply s
-- s({trig="", name="" dscr="" },{})
--
--


local function CSForLoop()
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

--- Defines class snippet in csharp
local function CSClass()
    local context = {
        trig = "class", --trigeted with the for keyword
        name="Class", -- The name of the snippet
        dscr="A C# class snippet"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    internal class {} {{
        public {}() {{
        }}
    }}
    ]]

    -- TODO: Have choice node that can either be the filename that is currently edided
    -- or have the user input the class name.
    local nodes ={
        i(1,"Hello"),
        rep(1) --The class can either be named from the file or have the name typed.
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
local function CSInheritDoc()
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

return {
    --Regular snippets
    CSForLoop(),
    CSClass(),
    --Documentation Related
    CSSummary(),
    CSInheritDoc()

},{
    --autosnippets
}
