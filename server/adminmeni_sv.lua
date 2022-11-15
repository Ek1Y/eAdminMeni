ESX.RegisterServerCallback('eAdminMeni:proverigrupu', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    if Config.GrupaZaAdminMeni[xPlayer.getGroup()] and xPlayer.proveriDuznost() then
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)
