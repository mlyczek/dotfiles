return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        view = {
            width = 40
        },
        renderer = {
            group_empty = true,
            highlight_opened_files = "icon"
        },
        actions = {
            open_file = {
                quit_on_open = true
            }
        }
    },
    keys = {
        { '<F5>', ':NvimTreeToggle<CR>', silent = true, noremap = true },
        { '<leader><F5>', ':NvimTreeFindFile<CR>', silent = true, noremap = true }
    }
}
