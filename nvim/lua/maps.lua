return {
	nmap = function(key, action, options)
		vim.keymap.set("n", key, action, options)
	end,
	imap = function(key, action, options)
		vim.keymap.set("i", key, action, options)
	end,
	tmap = function(key, action, options)
		vim.keymap.set("t", key, action, options)
	end,
	vmap = function(key, action, options)
		vim.keymap.set("v", key, action, options)
	end,
	map = function(key, action, options)
		vim.keymap.set("", key, action, options)
	end,
	n = { noremap = true },
	ns = { noremap = true, silent = true },
	ne = { noremap = true, expr = true },
	s = { silent = true },
	none = {},
	get_buf_map = function(bufnr, mode)
		return function(key, action, options)
			vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, options)
		end
	end,
}
