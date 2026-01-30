return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local filetypes = {
            'bash', 'markdown', 'markdown_inline', 'query', 'css', 'dockerfile', 'git_config', 'gitcommit',
            'haskell', 'javascript', 'json', 'python', 'sql', 'tmux', 'typescript', 'yaml', 'clojure',
            'astro', 'html', 'scss'
        }

        require('nvim-treesitter').install(filetypes)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
            end
        })
    end
}
