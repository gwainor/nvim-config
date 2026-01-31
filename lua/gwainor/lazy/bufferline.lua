return {
  {
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = { persist_buffer_sort = false },
      })
    end,
  },
}
