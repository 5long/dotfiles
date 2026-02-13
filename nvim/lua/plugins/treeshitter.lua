return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      ts.install({
        'bash',
        'bpftrace',
        'c',
        'css',
        'html',
        'diff',
        'fish',
        'go',
        'html',
        'javascript',
        'json',
        'just',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'ruby',
        'toml',
        'vim',
        'zig',
      }):wait(180000)

      local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        desc = 'Enable treesitter highlighting and indentation',
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match) or event.match
          local buf = event.buf

          -- Start highlighting immediately (works if parser exists)
          pcall(vim.treesitter.start, buf, lang)

          -- Enable treesitter indentation
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
