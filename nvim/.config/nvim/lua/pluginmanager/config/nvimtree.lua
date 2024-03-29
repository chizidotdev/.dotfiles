require('nvim-tree').setup({
    filters = {
        dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        adaptive_size = true,
        side = 'left',
        width = 45,
        preserve_window_proportions = true,
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    filesystem_watchers = {
        enable = true,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = 'none',
        root_folder_label = false,
        indent_markers = {
            enable = false,
        },
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },
            glyphs = {
                default = '',
                symlink = '',
                folder = {
                    default = '',
                    empty = '',
                    empty_open = '',
                    open = '',
                    symlink = '',
                    symlink_open = '',
                    arrow_open = '',
                    arrow_closed = '',
                },
                git = {
                    unstaged = '✗',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    untracked = '★',
                    deleted = '',
                    ignored = '◌',
                },
            },
        },
    },
})

require('keymaps').nvimtree()
