---@type LazySpec
return {
	"vimwiki/vimwiki",
	cmd = {
		"VimwikiIndex",
		"VimwikiDiaryIndex",
		"VimwikiTabIndex",
		"VimwikiDiaryGenerateLinks",
		"VimwikiMakeDiaryNote",
	},
	keys = {
		{ "<leader>ww", desc = "Vim[W]iki Index" },
		{ "<leader>wi", desc = "Vim[W]iki Diary [I]ndex" },
		{ "<leader>wt", desc = "Vim[W]iki [T]ab Index" },
		{ "<leader>w<leader>i", desc = "Vim[W]iki Diary Generate Links" },
		{ "<leader>w<leader>w", desc = "Vim[W]iki Make Diary Note" },
	},
	init = function()
		vim.g.vimwiki_global_ext = 0

		vim.g.vimwiki_list = {
			{
				diary_rel_path = ".",
				path = "~/diary",
				syntax = "markdown",
				ext = ".md",
			},
		}
	end,
}
