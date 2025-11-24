return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  config = function()
    require("osc52").setup({
      max_length = 0, -- no limit
      silent = false,
      trim = false,
    })

    -- Simple keymaps:
    -- <leader>yy -> copy current line to local clipboard
    -- <leader>y  -> copy motion / text object (e.g. <leader>yaw)
    -- visual mode: select + <leader>y
    vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
    vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
    vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
  end,
}
