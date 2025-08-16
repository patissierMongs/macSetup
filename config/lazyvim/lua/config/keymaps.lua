-- ═══════════════════════════════════════════════════════════════
-- Keymaps
-- ═══════════════════════════════════════════════════════════════

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Better window navigation (avoid conflicts with zellij Ctrl-z leader)
keymap.set("n", "<leader>h", "<C-w>h", opts)
keymap.set("n", "<leader>j", "<C-w>j", opts)
keymap.set("n", "<leader>k", "<C-w>k", opts)
keymap.set("n", "<leader>l", "<C-w>l", opts)

-- Resize windows with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)

-- Move text up and down (avoid Alt conflicts with aerospace)
keymap.set("n", "<leader>mj", ":m .+1<CR>==", opts)
keymap.set("n", "<leader>mk", ":m .-2<CR>==", opts)
keymap.set("v", "<leader>mj", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<leader>mk", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Clear highlights (moved to avoid conflict with window navigation)
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", opts)

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
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.clear_breakpoints()<CR>", { desc = "Clear Breakpoints" })
keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Terminate Debug" })
keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle Debug UI" })

-- Build shortcuts  
keymap.set("n", "<leader>bb", "<cmd>OverseerRun<CR>", { desc = "Build: Run Task" })
keymap.set("n", "<leader>bt", "<cmd>OverseerToggle<CR>", { desc = "Build: Toggle Task List" })
keymap.set("n", "<leader>bc", "<cmd>OverseerRunCmd<CR>", { desc = "Build: Run Command" })

-- Language-specific shortcuts
keymap.set("n", "<leader>lr", "<cmd>RunCode<CR>", { desc = "Run: Execute Code" })
keymap.set("n", "<leader>lc", function()
  local ft = vim.bo.filetype
  if ft == "rust" then
    vim.cmd("terminal cargo build")
  elseif ft == "go" then
    vim.cmd("terminal go build .")
  elseif ft == "java" then
    vim.cmd("terminal javac " .. vim.fn.expand("%"))
  elseif ft == "c" or ft == "cpp" then
    local file = vim.fn.expand("%")
    local name = vim.fn.expand("%:r")
    vim.cmd("terminal gcc -g -o " .. name .. " " .. file)
  else
    print("No compile command for filetype: " .. ft)
  end
end, { desc = "Compile: Build current file" })

keymap.set("n", "<leader>lt", function()
  local ft = vim.bo.filetype
  if ft == "rust" then
    vim.cmd("terminal cargo test")
  elseif ft == "go" then
    vim.cmd("terminal go test ./...")
  elseif ft == "java" then
    vim.cmd("terminal mvn test")
  elseif ft == "python" then
    vim.cmd("terminal python -m pytest")
  else
    print("No test command for filetype: " .. ft)
  end
end, { desc = "Test: Run tests" })

-- Auto-save toggle
keymap.set("n", "<leader>as", "<cmd>ASToggle<CR>", { desc = "Toggle Auto Save" })

-- Quick terminal commands
keymap.set("n", "<leader>ts", "<cmd>TermSelect<CR>", { desc = "Terminal: Select" })
keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal: Float" })
keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal: Horizontal" })
keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal: Vertical" })
