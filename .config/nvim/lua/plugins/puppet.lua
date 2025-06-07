return {
  {
    "rodjek/vim-puppet",
    ft = { "puppet" },
    init = function()
      -- Add file detection for .pp files
      vim.filetype.add({
        extension = {
          pp = "puppet",
        },
      })
    end,
  }
}

