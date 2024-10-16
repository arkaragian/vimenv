-- vim.cmd.colorscheme("kanagawa")
-- local default_colors = require("kanagawa.colors").setup()
--
-- local tex_color_overrides = {
--     -- create a new hl-group using default palette colors and/or new ones
--     -- This matches the names returned from :TSHighlightCapturesUnderCursor
--     -- The colors are selected after looking alot in the kanagawa repository.
--     ["@text.environment"] = { fg = default_colors.co },
--     ["@text.environment.name"] = { fg = default_colors.st },
--     -- Variables use color fg
-- }
--
-- -- TODO: Maybe make this adjustment based on the filetype
-- require("kanagawa").setup({ overrides = tex_color_overrides})

-- :lua print(vim.inspect(require("kanagawa.colors").setup()))
return {
    {
        "rebelot/kanagawa.nvim",
        commit = 'f491b0fe68fffbece7030181073dfe51f45cda81',
        lazy = false,
        priority = 1000,
        opts = {
            overrides = function(colors)
                return {
                    -- Override LaTeX-specific highlights
                    --["@text.environment"] = { fg = "#957FB8" }, -- Set the foreground color for LaTeX environments
                    ["@text.environment"] = { fg = "#FFFFFF" }, -- Set the foreground color for LaTeX environments
                    -- Add more overrides as needed
                }
            end,
        },
        -- opts = {
        --     overrides = {
        --     -- create a new hl-group using default palette colors and/or new ones
        --     -- This matches the names returned from :TSHighlightCapturesUnderCursor
        --     -- The colors are selected after looking alot in the kanagawa repository.
        --     {
        --         ["@text.environment"] = { fg = "#957FB8" },
        --         -- ["@text.environment.name"] = { fg = default_colors.st },
        --     }
        --     }
        -- }
        -- -- config = function()
        --     --     vim.cmd.colorscheme("kanagawa")
        --     -- end
        -- },
        -- opts = {
        --     overrides = function(colors)
        --         return {
        --             -- Override LaTeX-specific highlights
        --             ["@text.environment"] = { fg = "#957FB8" }, -- Set the foreground color for LaTeX environments
        --             -- Add more overrides as needed
        --         }
        --     end,
        -- },
        -- config = function(_, opts)
        --     require('kanagawa').setup(opts)
        --     -- Apply the colorscheme
        --     vim.cmd('colorscheme kanagawa')
        -- end,
    }
}
