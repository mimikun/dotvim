---@type table
local opts = {
    open_programs = { "wsl-open", "xdg-open", "open" },
    text = {
        searching = "   Searching",
        loading = "   Loading",
        version = "   %s",
        prerelease = "   %s",
        yanked = "   %s",
        nomatch = "   No match",
        upgrade = "   %s",
        error = "   Error fetching crate",
    },
    null_ls = {
        enabled = false,
        name = "crates.nvim",
    },
    lsp = {
        enabled = false,
        name = "crates.nvim",
        on_attach = function(client, bufnr) end,
        actions = false,
        completion = false,
        hover = false,
    },
    popup = {
        text = {
            title = " %s",
            pill_left = "",
            pill_right = "",
            description = "%s",
            created_label = " created        ",
            created = "%s",
            updated_label = " updated        ",
            updated = "%s",
            downloads_label = " downloads      ",
            downloads = "%s",
            homepage_label = " homepage       ",
            homepage = "%s",
            repository_label = " repository     ",
            repository = "%s",
            documentation_label = " documentation  ",
            documentation = "%s",
            crates_io_label = " crates.io      ",
            crates_io = "%s",
            lib_rs_label = " lib.rs         ",
            lib_rs = "%s",
            categories_label = " categories     ",
            keywords_label = " keywords       ",
            version = "  %s",
            prerelease = " %s",
            yanked = " %s",
            version_date = "  %s",
            feature = "  %s",
            enabled = " %s",
            transitive = " %s",
            normal_dependencies_title = " Dependencies",
            build_dependencies_title = " Build dependencies",
            dev_dependencies_title = " Dev dependencies",
            dependency = "  %s",
            optional = " %s",
            dependency_version = "  %s",
            loading = "  ",
        },
    },
    completion = {
        text = {
            prerelease = "  pre-release ",
            yanked = "  yanked ",
        },
        cmp = {
            enabled = false,
        },
        crates = {
            enabled = false,
        },
    },
}

require("crates").setup(opts)
