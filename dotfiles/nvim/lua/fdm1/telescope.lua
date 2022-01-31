require('telescope').setup({
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
    defaults = {
      file_ignore_patterns = {
        "nvim/plugged",
        "node_modules",
      }
    }
})

-- require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzy_native")
