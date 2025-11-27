-- disable mini.surround default mappings (including 's')
require("mini.surround").setup({
  mappings = {
    add = "", -- s
    delete = "", -- ds
    replace = "", -- cs
  },
})
