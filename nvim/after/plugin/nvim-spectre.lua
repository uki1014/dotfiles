local spectre = require('spectre')
spectre.setup()

maps.nmap('<Leader>m', function()
  spectre.open_visual({
    select_word = true
  })
end, maps.ns)
maps.nmap('<Leader>w', function() spectre.open_visual() end, maps.ns)
