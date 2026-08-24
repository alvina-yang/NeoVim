return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          python = { "black" },
          ruby = { "rubocop" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          sql = { "sql_formatter" },
          java = { "google_java_format" },
        },
        format_on_save = false,
      })
    end,
  },

  -- Auto-install formatters via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "black",
          "rubocop",
          "clang-format",
          "sql-formatter",
          "google-java-format",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}
