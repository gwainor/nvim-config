return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        mode = "n",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "[t",
        mode = "n",
        function() require("trouble").next({ skip_groups = true, jump = true }) end,
        desc = "Next diagnostic (Trouble)"
      },
      {
        "]t",
        mode = "n",
        function() require("trouble").previous({ skip_groups = true, jump = true }) end,
        desc = "Previous diagnostic (Trouble)"
      },
    },
  },
}
