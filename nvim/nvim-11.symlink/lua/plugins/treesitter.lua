return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.config').setup {
            ensure_installed = {
                "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "css", "dockerfile",
                "git_config", "git_rebase", "gitcommit", "haskell", "java", "javascript", "json", "python",
                "scala", "sql", "tmux", "typescript", "yaml", "terraform", "hcl", "clojure", "astro", "html"
            },

            highlight = { enable = true }
        }
    end
}
