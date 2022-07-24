local show = true


function DrawText3D(x, y, z, text)
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextOutline(0,0,0,255)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0+0.0165, 0.060, 0.033, 0, 0, 0, 60)
   -- DrawRect(0.0, 0.0+0.0165, 0.057, 0.03, 0, 0, 0, 60)
    ClearDrawOrigin()
end



CreateThread(function()
    while true do 
    if show then
        local vehicles = GetGamePool("CVehicle")
    
        for i=1, #vehicles, 1 do
         
       
            local vehCoords = GetEntityCoords(vehicles[i])
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, vehCoords[1], vehCoords[2], vehCoords[3], true)
            local plate = GetVehicleNumberPlateText(vehicles[i])
         
            if distance < Config.distance and not IsPedInVehicle(PlayerPedId(),vehicles[i],true) then

                DrawText3D(vehCoords[1], vehCoords[2], vehCoords[3]+Config.height, Config.country..plate)
            end
       
    end
    end
      Wait(7)
    end
end)


RegisterCommand(Config.togCommand, function()
    show = not show   
end)

