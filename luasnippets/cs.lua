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

--- Defines class snippet in csharp
local function CSNamespace()
    local context = {
        trig = "name", --trigeted with the for keyword
        name="namespace", -- The name of the snippet
        dscr="A C# namespace definition"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string= [[
    namespace {}{{
        {}
    }}
    ]]

    -- TODO: Have choice node that can either be the filename that is currently edided
    -- or have the user input the class name.
    local nodes ={
        i(1,"NamespaceName"),
        i(0,"CodeInput"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

--- Defines class snippet in csharp
local function CSTestClass()
    local context = {
        trig = "tclass", --trigeted with the for keyword
        name="A Test Class", -- The name of the snippet
        dscr="A C# MSTest class snippet"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string= [[
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    namespace {}{{

        [TestClass]
        public class {}{{

            [ClassInitialize()]
            static public void OnceBeforeAllTests(TestContext context){{

            }}

            [ClassCleanup()]
            static public void OnceAfterAllTests(){{

            }}

            [TestInitialize()]
            public void BeforeEveryTest(){{

            }}

            [TestCleanup()]
            public void AfterEachTest(){{

            }}

            [TestMethod]
            public void TestCase(){{

            }}
        }}
    }}
    ]]

    -- TODO: Have choice node that can either be the filename that is currently edided
    -- or have the user input the class name.
    local nodes ={
        i(1,"NamespaceName"),
        i(0,"ClassName"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

--- Defines class snippet in csharp
local function CSRecord()
    local context = {
        trig = "rec", --trigeted with the for keyword
        name="Record", -- The name of the snippet
        dscr="A C# record snippet"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    public record {} {{
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

local function CSDisableFormat()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "disfmt", --trigeted with the for keyword
        name="disfmt", -- The name of the snippet
        dscr="Disable Format"
    }

    -- Textnode does not support multiple. Instead it requires a table of strings
    local content = {
        "#pragma warning disable IDE0055",
        "#pragma warning restore IDE0055"

    }

    return s( context, t(content) )
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

--- Defines a parameter documentation in C# XML documentation
local function CSXMLParameter()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "<par", --trigeted with the for keyword
        name="Parameter", -- The name of the snippet
        dscr="An XML parameter documentation"
    }

    --We use a multiline string denoted by [[ and ]].
    -- we assume that the comments will be extended as we are already in
    -- a summary comment block

    local snippet_string = [[
    <param name="{paramname}">{doc}</param>
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        paramname = i(1,"Parameter Name"),
        doc       = i(0,"Parameter Documentation"),
    }
    return s( context, fmt(snippet_string, nodes) )
end

--- Defines a parameter documentation in C# XML documentation
local function CSXMLRemark()
    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "<re", --trigeted with the for keyword
        name="Remark", -- The name of the snippet
        dscr="A C# XML Remark"
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    <remarks>{remark}</remarks>
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        remark = i(1,"Write Remarks Here"),
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

local function CSSystemTextJsonProperty()

    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "jsonprop", --trigeted with the for keyword
        name="JSON Property", -- The name of the snippet
        dscr="A JSON property definition" -- The 
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
        [JsonPropertyName("{}")]
        public {} {}{{ get; set; }} = {};
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"PropertyName"),
        i(2,"Type"),
        rep(1),
        i(0,"PropertyValue")
    }
    return s( context, fmt(snippet_string, nodes) )
end


local function CSEnumDefinition()

    -- Defines a for snippet using a the fmt function of the luasnip
    local context = {
        trig = "enum", --trigeted with the for keyword
        name="Enum definition", -- The name of the snippet
        dscr="An enum definition" -- The 
    }

    --We use a multiline string denoted by [[ and ]].
    local snippet_string = [[
    <> enum <> {
        <>
    }
    ]]

    --Here are the nodes that are defined in the multiline string
    local nodes ={
        i(1,"AccessModifier"),
        i(2,"TheName"),
        i(0,"Value")
    }
    return s( context, fmta(snippet_string, nodes) )
end
return {
    CSNamespace(),
    --Regular snippets
    CSForLoop(),
    CSClass(),
    CSTestClass(),
    CSRecord(),
    --Documentation Related
    CSSummary(),
    CSInheritDoc(),
    CSXMLParameter(),
    CSXMLRemark(),
    -- JSON Related
    CSSystemTextJsonProperty(),
    CSEnumDefinition(),
    -- Behavior
    CSDisableFormat()



},{
    --autosnippets
}
