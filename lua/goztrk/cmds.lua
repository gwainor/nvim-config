local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

command("Format", function(args)
  local status_ok, conform = pcall(require, "conform")
  if not status_ok then
    return vim.notify "conform.nvim isn't installed!!!"
  end

  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format { async = true, lsp_fallback = true, range = range }
  vim.notify("Format Done", vim.log.levels.INFO, { title = "Format" })
end, { nargs = "*", desc = "Code Format", range = true })

autocmd('LspAttach', {
  callback = function(e)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover documentation" })
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Go to declaration" })
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Go to implementation" })
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Go to type definition" })
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "Go to reference" })
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Show function signature" })
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" })
    vim.keymap.set("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format file" })
    vim.keymap.set(
      "x",
      "<F3>",
      "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
      { desc = "Format selection" }
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { desc = "Execute code action" }
    )
  end
})
