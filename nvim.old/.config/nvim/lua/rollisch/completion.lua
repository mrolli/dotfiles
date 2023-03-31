-- nvim-cmp plugin configuration {{{
-- see https://github.com/hrsh7th/nvim-cmp
--     https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
--     https://www.youtube.com/watch?v=_DnmphIwnjo

local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

-- Use lspkind to have icons in the completion window
-- see https://github.com/onsails/lspkind-nvim
local lspkind = require('lspkind')
lspkind.init()

vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

cmp.setup({
--  formatting = {
--    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
--  },
  mapping = {
    ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    -- ['<C-y>'] = cmp.config.disable, -- if you want to remove the mapping
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  -- documentation = {
  --   border = 'rounded',
  -- },
  -- other options t add:
  --   keyword_lenth
  --   priority (though order already gives priority
  --   max_item_count
  sources = cmp.config.sources({
    { name = 'gh_issues' },

    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },

    -- for vsnip users
    { name = 'vsnip' },

    -- for ultisnips users
    -- { name = 'ultisnips' },
  }, {
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  }),
  snippet = {
    expand = function(args)
      -- for vsnip users
      vim.fn["vsnip#anonymous"](args.body)

      -- for ultisnips users
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[API]",
        path = "[Path]",
        vsnip = "[Snippet]",
        gh_issues = "[Issue]",
        tn = "[TabNine]",
      },
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

--[[
" Setup buffer configuration (nvim-lua source only enables in Lua filetype).
" This will override the global setup.
autocmd FileType lua lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'nvim_lua' },
\     { name = 'buffer' },
\   },
\ }
--]]

-- Add vim-dadbod-completion in sql files
vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]]

--[[
" Disable cmp for a telescope buffer
autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
--]]

-- }}}
