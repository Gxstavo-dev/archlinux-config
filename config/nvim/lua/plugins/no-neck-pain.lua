return {
  "shortcuts/no-neck-pain.nvim",
  event = "VeryLazy",
  opts = {
    width = 120, -- ancho del área de texto, ajusta a tu gusto (100-140 es común)
  },
  keys = {
    { "<leader>np", "<cmd>NoNeckPain<cr>", desc = "Toggle No Neck Pain" },
  },
}
