return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                   ",
      "                                              ___  ",
      "                                           ,o88888 ",
      "                                        ,o8888888' ",
      "                  ,:o:o:oooo.        ,8O88Pd8888\"  ",
      "              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'\"    ",
      "            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O\"      ",
      "           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8\"        ",
      "          , ..:.::o:ooOoOO8O888O8O,COCOO\"          ",
      "         , . ..:.::o:ooOoOOOO8OOOOCOCO\"            ",
      "          . ..:.::o:ooOoOoOO8O8OCCCC\"o             ",
      "             . ..:.::o:ooooOoCoCCC\"o:o             ",
      "             . ..:.::o:o:,cooooCo\"oo:o:            ",
      "          `   . . ..:.:cocoooo\"'o:o:::'            ",
      "          .`   . ..::ccccoc\"'o:o:o:::'             ",
      "         :.:.    ,c:cccc\"':.:.:.:.:.'              ",
      "       ..:.:'`::::c:\"'..:.:.:.:.:.'               ",
      "     ...:.'.:.::::\"'    . . . . .'                 ",
      "    .. . ....:.\"' `   .  . . ''                    ",
      "  . . . ....\"'                                     ",
      "  .. . .\"'                                         ",
      " .                                                 ",
      "",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New File", "<cmd>ene<CR>"),
      dashboard.button("e", "  File Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("f", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "  Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("p", "󰁯  Restore Session", "<cmd>AutoSession restore<CR>"),
      dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
    }

    local recent = {
      type = "group",
      val = function()
        local oldfiles = vim.v.oldfiles or {}
        local cwd = vim.fn.getcwd()
        local items = {}
        local count = 0
        for _, file in ipairs(oldfiles) do
          if count >= 5 then break end
          local path = vim.fn.fnamemodify(file, ":p")
          if vim.fn.filereadable(path) == 1 and path:find(cwd, 1, true) then
            count = count + 1
            local short = vim.fn.fnamemodify(path, ":~:.")
            local btn = dashboard.button(tostring(count), "  " .. short, "<cmd>e " .. path .. "<CR>")
            table.insert(items, btn)
          end
        end
        if count == 0 then
          for _, file in ipairs(oldfiles) do
            if count >= 5 then break end
            local path = vim.fn.fnamemodify(file, ":p")
            if vim.fn.filereadable(path) == 1 then
              count = count + 1
              local short = vim.fn.fnamemodify(path, ":~")
              local btn = dashboard.button(tostring(count), "  " .. short, "<cmd>e " .. path .. "<CR>")
              table.insert(items, btn)
            end
          end
        end
        return items
      end,
    }

    local recent_header = {
      type = "text",
      val = "  Recent Files",
      opts = { hl = "SpecialComment", position = "center" },
    }

    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      recent_header,
      { type = "padding", val = 1 },
      recent,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    -- Color highlights for the header
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#a6e3a1" })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#f9e2af" })

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    alpha.setup(dashboard.config)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
