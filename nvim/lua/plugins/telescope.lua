return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
            defaults = {
                mappings = {
                    n = {
                        ["q"] = require('telescope.actions').close
                    },
                },
            },
        })
    end
}

