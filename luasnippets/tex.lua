--- Defines an inheritdoc header in csharp

local function TEXMinipage()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "bmin", --trigeted with the for keyword
        name="minipage", -- The name of the snippet
        dscr="Begin minipage" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{{minipage}}{{{}}}
        {}
    \end{{minipage}}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(0,"TextHere"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

local function TEXItemize()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "bbit", --trigeted with the for keyword
        name="itemize", -- The name of the snippet
        dscr="An itemize environment" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{{itemize}}
        \item {}
    \end{{itemize}}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(0,"TextHere"),
    }
    return s( context, fmt(snippet_string, nodes) )
end


-- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
-- \item as necessary by utilizing a choiceNode.
--s("ls", {
    --    t({ "\\begin{itemize}", "\t\\item " }),
    --    i(1),
    --    d(2, rec_ls, {}),
    --    t({ "", "\\end{itemize}" }),
    --}),

    return {
        TEXMinipage(),
        TEXItemize()
    },{
        --Autosnippets
    }
