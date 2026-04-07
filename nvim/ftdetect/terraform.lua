vim.api.nvim_create_autocmd(
  {'BufRead', 'BufNewFile'},
  {
    pattern = '*.tf',
    callback = function()
      vim.cmd('setfiletype terraform')
    end
  }
)
