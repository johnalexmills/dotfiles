return {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            session_lens = {
                buftypes_to_ignore = {},
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },
        })

        vim.keymap.set("n", "<leader>Wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
        vim.keymap.set("n", "<leader>Ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
    end,
}
