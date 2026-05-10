-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make commentstring work for Bicep files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "bicep", "bicep-params" },
  command = "set commentstring=//\\ %s",
})

-- Automatically set text width for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = "set tw=80",
})

-- Empty formatexpr for markdwon files to make gqq and gqap work again
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit" },
  command = "set formatexpr=",
})

-- Some filetypes should have wrapping enabled by default
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "json" },
  -- enable wrap mode
  command = "setlocal wrap",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "json", "jsonc" },
--   callback = function()
--     vim.opt.conceallevel = 0
--   end,
-- })

-- Set relative line numbers when not in insert mode
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = 'if &nu && mode() != "i" | set rnu   | endif',
})

-- Set absolute line numbers when in insert mode
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  pattern = "*",
  command = "if &nu | set nornu | endif",
})

-- Auto-build mkdocs-to-kirby projects on save
local mkdocs_kirby_group = vim.api.nvim_create_augroup("mkdocs_kirby_build", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = mkdocs_kirby_group,
  pattern = "*",
  callback = function()
    -- Find project root by locating .git directory
    local file_dir = vim.fn.expand("%:p:h")
    local git_dir = vim.fn.finddir(".git", file_dir .. ";")
    if git_dir == "" then
      return
    end
    -- Resolve to absolute path, then get parent of .git directory
    local project_root = vim.fn.fnamemodify(git_dir, ":p"):gsub("/$", ""):gsub("/%.git$", "")

    -- Check for mkdocs.yaml or mkdocs.yml
    local has_mkdocs = vim.fn.filereadable(project_root .. "/mkdocs.yaml") == 1
      or vim.fn.filereadable(project_root .. "/mkdocs.yml") == 1
    if not has_mkdocs then
      return
    end

    -- Check for mkdocs-to-kirby in requirements.txt
    local req_path = project_root .. "/requirements.txt"
    if vim.fn.filereadable(req_path) ~= 1 then
      return
    end
    local lines = vim.fn.readfile(req_path)
    local has_plugin = false
    for _, line in ipairs(lines) do
      if line:match("mkdocs%-to%-kirby") then
        has_plugin = true
        break
      end
    end
    if not has_plugin then
      return
    end

    -- Run the build asynchronously from the project root
    local stderr_chunks = {}
    vim.fn.jobstart(
      {
        "bash",
        "-c",
        'eval "$(conda shell.bash hook)" && cd ' .. project_root .. " && conda activate azure && mkdocs build",
      },
      {
        cwd = project_root,
        stderr_buffered = true,
        on_stderr = function(_, data)
          if data then
            vim.list_extend(stderr_chunks, data)
          end
        end,
        on_exit = function(_, exit_code)
          vim.schedule(function()
            if exit_code == 0 then
              vim.notify("mkdocs build completed", vim.log.levels.INFO)
            else
              local err = table.concat(stderr_chunks, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
              local msg = "mkdocs build failed (exit " .. exit_code .. ")"
              if err ~= "" then
                msg = msg .. ":\n" .. err
              end
              vim.notify(msg, vim.log.levels.ERROR)
            end
          end)
        end,
      }
    )
  end,
})
