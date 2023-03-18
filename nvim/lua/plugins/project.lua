-- Setup project plugin
-- see https://github.com/ahmedkhalf/project.nvim

return {
  {
    "ahmedkhalf/project.nvim",
    enabled = true,
    lazy = false,
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
      })
      require("telescope").load_extension("projects")
      -- TODO: Add projects entry to dashboard
      -- local dashboard = require("alpha.themes.dashboard")
      -- dashboard.button("g", " " .. " Recent projects", ":Telescope projects <CR>")
    end,
  },
}
