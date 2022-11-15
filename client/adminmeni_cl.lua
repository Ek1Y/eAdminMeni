lib.registerContext({
  id = 'adminmeni_menu',
  title = 'Admin Meni',
  onExit = function()
      --print('Hello there')
  end,
  options = {
      {
          title = 'Noclip',
          description = 'Upali/Ugasi noclip',
          arrow = true,
          event = 'eAdminMeni:noclip',
      },
      {
        title = 'Nevidljivost',
        description = 'Upali/Ugasi nevidljivost',
        arrow = true,
        event = 'eAdminMeni:nevidljivost',
      },
      {
        title = 'Spectate',
        description = 'Upali/Ugasi spectate',
        arrow = true,
        event = 'eAdminMeni:spectate',
      },
      {
        title = 'Popravi',
        description = 'Popravi vozilo',
        arrow = true,
        event = 'eAdminMeni:popravi',
      },
      {
        title = 'Ocisti',
        description = 'Ocisti vozilo',
        arrow = true,
        event = 'eAdminMeni:ocisti',
      },
      {
        title = 'DV',
        description = 'Obrisi vozilo',
        arrow = true,
        event = 'eAdminMeni:obrisivozilo',
      },
      {
        title = 'Vozilo za igrace',
        description = 'Stvori vozilo za igrace',
        arrow = true,
        event = 'eAdminMeni:stvorivozilo',
        args = {vozilo = 'blista'}
      },
      {
        title = 'Vozilo za staff',
        description = 'Stvori vozilo za staff',
        arrow = true,
        event = 'eAdminMeni:stvorivozilo',
        args = {vozilo = 'bmci'}
      },
  },
})

RegisterCommand('+adminmenu', function()
  ESX.TriggerServerCallback('eAdminMeni:proverigrupu', function(grupa)
    if grupa then
      lib.showContext('adminmeni_menu')
    end
  end)
end)


RegisterKeyMapping('+adminmenu', "Admin Menu", 'keyboard', 'F5')


RegisterNetEvent('eAdminMeni:nevidljivost')
AddEventHandler('eAdminMeni:nevidljivost', function()
    if not nevidljivost then
      SetEntityVisible(ESX.PlayerData.ped, false)
      nevidljivost = true
      ESX.ShowNotification('Upalio si nevidljivost')
    else
      SetEntityVisible(ESX.PlayerData.ped, true)
      nevidljivost = false
      ESX.ShowNotification('Ugasio si nevidljivost')
    end
end)

RegisterNetEvent('eAdminMeni:popravi')
AddEventHandler('eAdminMeni:popravi', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetVehicleEngineHealth(vehicle, 1000)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleFixed(vehicle)
    DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
    ESX.ShowNotification('Vozilo je popravljeno')
  else
    ESX.ShowNotification('Niste u autu')
  end
end)

RegisterNetEvent('eAdminMeni:spectate')
AddEventHandler('eAdminMeni:spectate', function()
  TriggerEvent('openSpectateMenu')
end)


RegisterNetEvent('eAdminMeni:ocisti')
AddEventHandler('eAdminMeni:ocisti', function()
  local playerPed = PlayerPedId()
  if IsPedInAnyVehicle(playerPed, false) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetVehicleDirtLevel(vehicle, 0)
    ESX.ShowNotification('Vozilo je ocisceno')
  else
    ESX.ShowNotification('Niste u autu')
  end
end)

RegisterNetEvent('eAdminMeni:stvorivozilo')
AddEventHandler('eAdminMeni:stvorivozilo', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  if DoesEntityExist(vehicle) then
    DeleteEntity(vehicle)
    ESX.Game.SpawnVehicle(data.vozilo, GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped), function(vozilo)
      TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vozilo, -1)
      ESX.ShowNotification('Stvorio si vozilo')
    end)
  else
    ESX.Game.SpawnVehicle(data.vozilo, GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped), function(vozilo)
      TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vozilo, -1)
      ESX.ShowNotification('Stvorio si vozilo')
    end)
  end
end)

RegisterNetEvent('eAdminMeni:obrisivozilo')
AddEventHandler('eAdminMeni:obrisivozilo', function()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  if IsPedSittingInAnyVehicle(ESX.PlayerData.ped) then
    DeleteEntity(vehicle)
    ESX.ShowNotification('Obrisao si vozilo')
  else
    ESX.ShowNotification('Nisi u vozilu')
  end
end)
