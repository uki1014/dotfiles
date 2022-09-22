local maps = require('maps')

maps.nmap('<Leader>m', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', maps.ns)
maps.nmap('<Leader>w', '<cmd>lua require("spectre").open_visual()<CR>', maps.ns)

require('spectre').setup()

