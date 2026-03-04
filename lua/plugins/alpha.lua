return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC fr", "  > Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
      dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
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
      { type = "padding", val = 2 },
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

    alpha.setup(dashboard.config)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
