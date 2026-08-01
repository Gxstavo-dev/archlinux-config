return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        emmet_ls = {
          filetypes = {
            "html", "css", "javascriptreact", "typescriptreact",
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html", "css" },
    },
  },
}
