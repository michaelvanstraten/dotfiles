return {
	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Toggle file explorer (Neotree)",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		opts = {
			sources = {
				"filesystem",
			},
			enable_git_status = false,
			enable_modified_markers = false, -- Don't show markers for files with unsaved changes.
			enable_cursor_hijack = true, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
			hide_root_node = true, -- Hide the root node.
			retain_hidden_root_indent = true, -- IF the root node is hidden, keep the indentation anyhow.
			popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				},
				symlink_target = {
					enabled = true,
				},
			},
			renderers = {
				directory = {
					{ "indent" },
					-- { "icon" },
					{ "current_filter" },
					{
						"container",
						content = {
							{ "name", zindex = 10 },
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{
								"diagnostics",
								errors_only = true,
								zindex = 20,
								align = "right",
								hide_when_expanded = true,
							},
							{
								"git_status",
								zindex = 10,
								align = "right",
								hide_when_expanded = true,
							},
							{ "file_size", zindex = 10, align = "right" },
							{ "type", zindex = 10, align = "right" },
							{ "last_modified", zindex = 10, align = "right" },
							{ "created", zindex = 10, align = "right" },
						},
					},
				},
			},
			window = {
				insert_as = "sibling", -- Insert nodes  as siblings of the directory under cursor.
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						".git",
					},
					never_show = {
						".DS_Store",
					},
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
				},
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
			},
		},
	},
}
