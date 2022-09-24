local gitsigns = require('gitsigns')
gitsigns.setup()

maps.nmap('<Leader>gl', function()
  gitsigns.blame_line({
    full = true
  })
end, maps.ns)
