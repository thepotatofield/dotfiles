return {
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          sources = {
            explorer = {
              hidden = true,   -- show dotfiles (files starting with .)
              ignored = true,  -- show files ignored by .gitignore / global ignore
            },
          },
        },
      },
    },
  }