local function TEXFigure()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "mpfig", --trigeted with the for keyword
        name="Figure", -- The name of the snippet
        dscr="A minipage figure" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{{minipage}}[b]{{{}}}
        \includegraphics[width=\linewidth]{{{}}}
        \captionsetup{{hypcap=false}}
        \captionof{{figure}}{{{}}}
        \label{{fig:{}}}
    \end{{minipage}}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(2,"FigurePath"),
        i(3,"Caption"),
        i(0,"Label"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

local function TEXResizeBox()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "rbox", --trigeted with the for keyword
        name="resizebox", -- The name of the snippet
        dscr="A Resize Box" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \resizebox{{{}}}{{!}}{{
        {}
    }}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(0,"TextHere"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

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

local function TEXTwoColumnMinipage()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "twocol", --trigeted with the for keyword
        name="twocolumn", -- The name of the snippet
        dscr="Two Column Minipage Structure" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{{minipage}}{{\linewidth}}
        \begin{{minipage}}{{0.5\linewidth}}
            {}
        \end{{minipage}}
        \begin{{minipage}}{{0.5\linewidth}}
            {}
        \end{{minipage}}
    \end{{minipage}}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"Column 1 Text"),
        i(0,"Column 2 Text"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

local function TEXCenter()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "bcen", --trigeted with the for keyword
        name="center", -- The name of the snippet
        dscr="Begin center" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{{center}}
        {}
    \end{{center}}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
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
        TEXResizeBox(),
        TEXMinipage(),
        TEXTwoColumnMinipage(),
        TEXFigure(),
        TEXCenter(),
        TEXItemize()
    },{
        --Autosnippets
    }
