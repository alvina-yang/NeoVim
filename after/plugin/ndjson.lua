-- NDJSON / JSON Lines support: filetype detection, treesitter highlighting,
-- and conform formatting that keeps one compact JSON object per line.
vim.filetype.add({ extension = { ndjson = "jsonl" } })

vim.treesitter.language.register("json", "jsonl")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "jsonl",
  group = vim.api.nvim_create_augroup("NdjsonFormatting", { clear = true }),
  callback = function()
    local ok, conform = pcall(require, "conform")
    if not ok then return end
    conform.formatters.jq_jsonl = { command = "jq", args = { "-c", "." } }
    conform.formatters_by_ft.jsonl = { "jq_jsonl" }
  end,
})
