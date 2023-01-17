vim.opt.termguicolors = true
require("bufferline").setup {
  options = {
    numbers = 'ordinal',
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    show_close_icon = false,
  }
}
