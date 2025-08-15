-- ═══════════════════════════════════════════════════════════════
-- Keymaps
-- ═══════════════════════════════════════════════════════════════

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)

-- Move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Clear highlights
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Terminal
keymap.set("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Compile and run based on file type
local function compile_and_run()
  local ft = vim.bo.filetype
  local file = vim.fn.expand("%")
  local name = vim.fn.expand("%:r")

  local commands = {
    python = "python3 " .. file,
    javascript = "node " .. file,
    typescript = "ts-node " .. file,
    java = "javac " .. file .. " && java " .. name,
    c = "gcc -o " .. name .. " " .. file .. " && ./" .. name,
    cpp = "g++ -o " .. name .. " " .. file .. " && ./" .. name,
    rust = "rustc " .. file .. " && ./" .. name,
    go = "go run " .. file,
  }

  local cmd = commands[ft]
  if cmd then
    vim.cmd("split | terminal " .. cmd)
  else
    print("No run command for filetype: " .. ft)
  end
end

keymap.set("n", "<leader>r", compile_and_run, { desc = "Compile and run" })

-- Debugging shortcuts
keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug: Continue" })
keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debug: Step Over" })
keymap.set("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debug: Step Into" })
keymap.set("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debug: Step Out" })
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", { desc = "Open REPL" })
