return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                preview = {
                    -- Avoid Treesitter preview crashes across API changes.
                    treesitter = false,
                },
                mappings = {
                    n = {
                        ["q"] = require("telescope.actions").close,
                    },
                },
            },
        })
    end,
}

