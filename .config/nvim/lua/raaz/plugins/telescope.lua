return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", {desc = "Find files" })
    keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",{desc =  "Find all" })
    keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>",{desc =  "Live grep" })
    keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>",{desc =  "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>",{desc =  "Help page" })
    keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>",{desc =  "Find oldfiles" })
    keymap.set("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>",{desc =  "Find in current buffer" })

  end,
}
