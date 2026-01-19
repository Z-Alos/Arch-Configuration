vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    only_current_line = false, 
  },
  underline = true,
  signs = true,
  update_in_insert = false,
})

vim.diagnostic.show(nil, 0, nil, { virtual_lines = true })

