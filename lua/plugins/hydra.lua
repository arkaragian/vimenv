return {
    {
        "https://github.com/anuvyklack/hydra.nvim",
        version = "v1.0.2",
        config = function()
            local Hydra = require('hydra')
            Hydra({
                name = "Window Hydra",
                mode = 'n',
                body = '<C-w>',
                heads = {
                    -- When we enter the hydra with ctrl+w then
                    -- pushing only the + key equals to the <C-w>+ five times
                    -- etc
                    {'+' , '5<C-w>+' , {desc="Increase Window Height" }  } ,
                    {'-' , '5<C-w>-' , {desc="Decrease Window Height" }  } ,
                    {'>' , '5<C-w>>' , {desc="Increase Window Width"  }  } ,
                    {'<' , '5<C-w><' , {desc="Decrease Window Width"  }  } ,
                },
            })

            --Hydra({
            --    name = "Downwards Jump Movement Hydra",
            --    mode = 'n',
            --    body = '<leader>]',
            --    heads = {
            --        -- When we enter the hydra with ctrl+w then
            --        -- pushing only the + key equals to the <C-w>+ five times
            --        -- etc
            --        {'m' , ']m' , {desc="Jump to next function" }  } ,
            --        {'d' , ']d' , {desc="Jump to next diagnostic" }  } ,
            --    },
            --})
            --
            --Hydra({
            --    name = "Upwards Jump Movement Hydra",
            --    mode = 'n',
            --    body = '<leader>[',
            --    heads = {
            --        -- When we enter the hydra with ctrl+w then
            --        -- pushing only the + key equals to the <C-w>+ five times
            --        -- etc
            --        {'m' , '[m' , {desc="Jump to next function" }  } ,
            --        {'d' , '[d' , {desc="Jump to next diagnostic" }  } ,
            --    },
            --})

            -- TODO: Implement function movement hydra using nvim text objects
            -- TODO: Implement LSP diagnostics movement hydra
        end
    }
}
