-- File explorer that lets you edit your files like a normal Neovim buffer
return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function ()
    require('oil').setup({
      default_file_explorer = true,
      columns = {
        "size",
        "mtime",
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
    })
  end,
}
