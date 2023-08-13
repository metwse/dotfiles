require('metw.packer')
require('metw.set')
require('metw.remap')

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'javascript', 'css', 'sql', 'html', 'c', 'lua', 'vim' },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
    },
}


require('presence').setup({
    -- General options
    auto_update         = true,
    eovim_image_text   = 'The One True Text Editor',
    main_image          = 'file',
    client_id           = '793271441293967371',
    log_level           = nil,
    debounce_timeout    = 10,
    enable_line_number  = true,
    blacklist           = {},
    buttons             =
    function(_, repo_url)
        if repo_url ~= nil then return {{ label = 'View Repository: ' .. string.match(repo_url, '/([^/]*/[^/]*)$'), url = repo_url }} end
    end,
    file_assets         = {},
    show_time           = true,
    editing_text        = 'Editing %s',
    file_explorer_text  = 'Browsing %s',
    git_commit_text     = 'Committing changes',
    plugin_manager_text = 'Managing plugins',
    reading_text        = 'Reading %s',
    workspace_text      = 'Working on %s',
    line_number_text    = 'Line %s out of %s',
})


require('neoclip').setup({
    history = 1000,
    enable_persistent_history = false,
    length_limit = 1048576,
    continuous_sync = false,
    db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    prompt = nil,
    default_register = '"',
    default_register_macros = 'q',
    enable_macro_history = true,
    content_spec_column = false,
    on_select = { move_to_front = false, close_telescope = true },
    on_paste = { set_reg = false, move_to_front = false, close_telescope = true }, 
    on_replay = { set_reg = false, move_to_front = false, close_telescope = true },
    on_custom_action = { close_telescope = true },
    keys = {
        telescope = {
            i = { select = '<cr>', paste = '<c-p>', paste_behind = '<c-k>', replay = '<c-q>', delete = '<c-d>', edit = '<c-e>' },
            n = { select = '<cr>', paste = 'p', paste_behind = 'P', replay = 'q', delete = 'd', edit = 'e' }
            },
        fzf = { select = 'default', paste = 'ctrl-p', paste_behind = 'ctrl-k' }
    }
})
