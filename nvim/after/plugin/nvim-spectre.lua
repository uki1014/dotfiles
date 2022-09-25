local spectre = require("spectre")
spectre.setup()

Maps.nmap("<Leader>m", function()
	spectre.open_visual({
		select_word = true,
	})
end, Maps.ns)
Maps.nmap("<Leader>w", function()
	spectre.open_visual()
end, Maps.ns)
