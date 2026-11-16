return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        -- Parser (language) names, not filetypes
        local parsers = {
            'bash', 'markdown', 'markdown_inline', 'query', 'css', 'dockerfile', 'git_config', 'gitcommit',
            'haskell', 'javascript', 'json', 'python', 'sql', 'tmux', 'typescript', 'tsx', 'yaml',
            'clojure', 'astro', 'html', 'scss', 'gotmpl', 'qmljs', 'go', 'gomod', 'toml'
        }

        require('nvim-treesitter').install(parsers)

        -- Parser names don't always equal filetype names (qmljs -> qml, git_config -> gitconfig,
        -- tsx -> typescriptreact), so translate them.
        local filetypes = {}
        for _, lang in ipairs(parsers) do
            vim.list_extend(filetypes, vim.treesitter.language.get_filetypes(lang))
        end
        -- Fallbacks in case the mapping isn't registered before the parser is installed
        vim.list_extend(filetypes, { 'qml', 'gitconfig', 'typescriptreact', 'javascriptreact' })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function(args)
                -- Don't error when the parser isn't installed yet (e.g. first launch)
                pcall(vim.treesitter.start, args.buf)
            end
        })
    end
}
