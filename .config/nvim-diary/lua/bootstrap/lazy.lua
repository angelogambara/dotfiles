local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

local function clone_lazy(path, repo)
	local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to clone lazy.nvim:\n" .. result, vim.log.levels.ERROR)
		vim.fn.getchar()
		os.exit(1)
	end
end

function M.setup()
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		clone_lazy(lazypath, lazyrepo)
	end
	vim.opt.rtp:prepend(lazypath)
end

return M
