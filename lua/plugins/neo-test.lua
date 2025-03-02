return
{
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "fredrikaverpil/neotest-golang", version = "*",
      dependencies = {
        "uga-rosa/utf8.nvim", -- Additional dependency required
      },
    },
  },
  config = function()
    local neotest_golang_opts = {}  -- Specify custom configuration
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({ sanitize_output = true }), -- Registration
      },
    })
  end,
}
