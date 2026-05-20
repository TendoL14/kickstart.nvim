return { -- VimTeX
  'lervag/vimtex',
  lazy = false, -- no lazy load
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_mode = 0

    vim.g.vimtex_view_method = 'sioyek'
    vim.g.vimtex_view_sioyek_exe = 'sioyek'
    vim.g.vimtex_view_sioyek_options = '--reuse-window'
  end,
}
