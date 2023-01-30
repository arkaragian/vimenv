------------------------------------------------------------------------------
--                   G L O B A L  D E F I N I T I O N S                     --
------------------------------------------------------------------------------
local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local isn = require("luasnip.nodes.snippet").ISN
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local f = require("luasnip.nodes.functionNode").F
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
--local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


---Generate a generic snippet environment that contains a single node.
-- This node can then be populated with a snippet node with the appropriate
-- contents.
local function Environment(name)
    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{SnipPlaceholder}
        <>
    \end{SnipPlaceholder}
    ]]

    return string.gsub(snippet_string,"SnipPlaceholder",name)
end

------------------------------------------------------------------------------
--                      S N I P P E T  N O D E S                            --
--  Function Nodes insert text based on the content of other nodes using a  --
--  user-defined function. All of the functions here accept a number as     --
--  their first argument. This is to define the placement of each node      --
--  within the calling snippet. All functions start with the SN prefix      --
------------------------------------------------------------------------------

local function SNIncludeGraphics(number)
    local snippet_string = "\\includegraphics[width=<>]{<>}<>"

    -- Nodes contained in the snippet node
    local nodes ={
        i(1,"\\linewidth"),
        i(2,"FilePath"),
        t({"",""}) -- Append those nodes in order to have a new line
    }

    return sn(number, fmta(snippet_string, nodes))
end

local function SNCaption(number)
    local snippet_string ="\\caption{<>}<>"

    -- Nodes contained in the snippet node
    local nodes ={
        i(1,"Caption"),
        t({"",""}) -- Append those nodes in order to have a new line
    }

    return isn(number, fmta(snippet_string, nodes),"$PARENT_INDENT" )
end

local function SNGenericLabel(prefix,number)
    local snippet_string = "\\label{PlaceHolder:<>}"

    snippet_string = string.gsub(snippet_string,"PlaceHolder",prefix)

    -- Nodes contained in the snippet node
    local nodes ={
        i(1,"LabelName"),
    }
    return isn(number, fmta(snippet_string, nodes),"$PARENT_INDENT" )
end

local function SNFigureLabel(number)
    return SNGenericLabel("fig",number)
end

-- This is a playground function not meant to be used.
local function GenericEnvironment()
    local context = {
        trig = "gen", --trigeted with the for keyword
        name="Figure", -- The name of the snippet
        dscr="A figure" -- The
    }

    local snippet_string = Environment("Hello")

    local nodes ={
        isn(1,{
            t({"\\centering",""}),
            SNIncludeGraphics(1),
            SNCaption(2),
            SNFigureLabel(3)
        },"$PARENT_INDENT")
    }
    return s( context, fmta(snippet_string, nodes) )
end

local function TEXFigure()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "fig", --trigeted with the for keyword
        name="Figure", -- The name of the snippet
        dscr="A figure" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{figure}
        \centering
        \includegraphics[width=<>]{<>}
        \caption{<>}
        \label{fig:<>}
    \end{figure}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(2,"FigurePath"),
        i(3,"Caption"),
        i(0,"Label"),
    }
    return s( context, fmta(snippet_string, nodes) )
end

local function TEXMinipageFigure()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "mpfig", --trigeted with the for keyword
        name="Figure", -- The name of the snippet
        dscr="A minipage figure" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \begin{minipage}[b]{<>}
        \includegraphics[width=\linewidth]{<>}
        \captionsetup{hypcap=false}
        \captionof{figure}{<>}
        \label{fig:<>}
    \end{minipage}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(2,"FigurePath"),
        i(3,"Caption"),
        i(0,"Label"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
    \resizebox{<>}{!}{
        <>
    }
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(0,"TextHere"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
    \begin{minipage}{<>}
        <>
    \end{minipage}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"\\linewidth"),
        i(0,"TextHere"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
    \begin{minipage}{\linewidth}
        \begin{minipage}{0.5\linewidth}
            <>
        \end{minipage}%This comment is required in order to not produce whitespace
        \begin{minipage}{0.5\linewidth}
            <>
        \end{minipage}
    \end{minipage}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"Column 1 Text"),
        i(0,"Column 2 Text"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
    \begin{center}
        <>
    \end{center}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(0,"TextHere"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
    \begin{itemize}
        \item <>
    \end{itemize}
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(0,"TextHere"),
    }
    return s( context, fmta(snippet_string, nodes) )
end


local function TIKZNode()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "tnode", --trigeted with the for keyword
        name="node", -- The name of the snippet
        dscr="A tikz node" -- The
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    \node at (<>,<>) [<>] {<>};
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"xcoord"),
        i(2,"ycoord"),
        i(3,"style"),
        i(0,"text"),
    }
    return s( context, fmta(snippet_string, nodes) )
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
        GenericEnvironment(),
        TEXResizeBox(),
        TEXMinipage(),
        TEXTwoColumnMinipage(),
        TEXFigure(),
        TEXMinipageFigure(),
        TEXCenter(),
        TEXItemize(),
        TIKZNode()
    },{
        --Autosnippets
    }
