return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<leader>ee', '<cmd>Neotree filesystem reveal left toggle<CR>', desc = 'Neotree: Explore File Tree' },
      { '<leader>eb', '<cmd>Neotree buffers reveal left toggle<CR>', desc = 'Neotree: Explore Buffers' },
      { '<leader>eg', '<cmd>Neotree git_status reveal left toggle<CR>', desc = 'Neotree: Explore Git Status' },
    }
  }
}
