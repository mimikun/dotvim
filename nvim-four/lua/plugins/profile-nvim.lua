---@type LazyKeysSpec[]
local keys = {
    {
        "<leader>p",
        "<cmd>Profile<cr>",
        mode = "n",
        desc = "Open Profile",
        { silent = true },
    },
}

---@type LazySpec[]
local dependencies = {
    "3rd/image.nvim",
}

---@type table
local opts = {
    user = "mimikun",
}

---@type LazySpec
local spec = {
    "Kurama622/profile.nvim",
    --lazy = false,
    cmd = "Profile",
    keys = keys,
    dependencies = dependencies,
    config = function()
        require("profile").setup(opts)
        vim.keymap.set("n", "<leader>p", "<cmd>Profile<cr>", { silent = true })
    end,
    --cond = false,
    --enabled = false,
}

return spec
--[[

```lua
  {
    config = function()
      local comp = require("profile.components")
      local win_width = vim.o.columns
      require("profile").setup({
        avatar_path = "/home/arch/Github/profile.nvim/resources/profile.png",
        -- avatar position options
        avatar_opts = {
          avatar_width = 20,
          avatar_height = 20,
          avatar_x = math.floor((win_width - 20) / 2),
          avatar_y = 7,
        },

        -- git user
        user = "Kurama622",
        git_contributions = {
          start_week = 1, -- The minimum is 1
          end_week = 53, -- The maximum is 53
          empty_char = " ",
          full_char = { "", "󰧞", "", "", "" },
          fake_contributions = nil,
          --[ [
          -- If you want to fake git's contribution information,
          -- you can pass a function to fake_contributions.
          fake_contributions = function()
            local ret = {}
            for i = 1, 53 do
              ret[tostring(i)] = {}
              for j = 1, 7 do
                ret[tostring(i)][j] = math.random(0, 5)
              end
            end
            return ret
          end,
          ] ]
        },
        hide = {
          statusline = true,
          tabline = true,
        },

        -- Customize the content to render
        format = function()
          -- render avatar
          comp:avatar()
          -- customize text component
          comp:text_component_render({
            comp:text_component("git@github.com:Kurama622/profile.nvim", "center", "ProfileRed"),
            comp:text_component("──── By Kurama622", "right", "ProfileBlue"),
          })
          comp:seperator_render()

          -- Custom card component, render git repository by default
          comp:card_component_render({
            type = "table",
            content = function()
              return {
                {
                  title = "kurama622/llm.nvim",
                  description = [ [LLM Neovim Plugin: Effortless Natural
Language Generation with LLM's API] ],
                },
                {
                  title = "kurama622/profile.nvim",
                  description = [ [A Neovim plugin: Your Personal Homepage] ],
                },
              }
            end,
            hl = {
              border = "ProfileYellow",
              text = "ProfileYellow",
            },
          })
          comp:seperator_render()

          -- git contributions, Considering network latency, the module will render asynchronously.
          -- you can also configure `fake_contributions`, so it won't fetch data from the Github
          comp:git_contributions_render("ProfileGreen")
        end,
      })
      vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Profile<cr>", { silent = true })
    end,
  },
```

### image.nvim configuration

`backend` can be `ueberzug` or `kitty`: MacOS only supports `kitty`

```lua
  {
    "3rd/image.nvim",
    dependencies = {
      "leafo/magick",
    },
    config = function()
      require("image").setup({
        backend = "ueberzug",
        -- backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        -- window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
    end,
  },
```

## Define User Mappings

```lua
local user_mappings = {
  n = {
    ["r"] = "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
    ["f"] = "<cmd>lua require('telescope.builtin').find_files()<cr>",
    ["c"] = "<cmd>lua require('telescope.builtin').find_files({ cwd = '$HOME/.config/nvim' })<cr>",
    ["/"] = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
    ["n"] = "<cmd>enew<cr>",
    ["l"] = "<cmd>Lazy<cr>",
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "profile",
  callback = function()
    for mode, mapping in pairs(user_mappings) do
      for key, cmd in pairs(mapping) do
        vim.api.nvim_buf_set_keymap(0, mode, key, cmd, { noremap = true, silent = true })
      end
    end
  end,
})
```
Refer to my [config](https://github.com/Kurama622/.lazyvim/blob/main/lua/plugins/profile.lua).


## Some Unicode characters you might be interested in:

```lua
--[ [
full_char = { "█", "█", "█", "█", "█" },
full_char = { "■", "■", "■", "■", "■" },
full_char = { "▄", "▅", "▆", "▇", "█" },
full_char = { "", "󰧞", "", "", "" },
] ]
```
]]
