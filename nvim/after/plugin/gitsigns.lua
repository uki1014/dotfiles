local gitsigns = require("gitsigns")
gitsigns.setup()

Maps.nmap("<Leader>gl", function()
	gitsigns.blame_line({
		full = true,
	})
end, Maps.ns)
