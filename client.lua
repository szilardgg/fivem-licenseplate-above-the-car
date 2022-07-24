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
    DrawRect(0.0, 0.0+0.0165, 0.057, 0.03, 0, 0, 0, 60)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do 
        local waitTime = 500
        local vehicles = GetGamePool("CVehicle")
        local playerPed = PlayerPedId()
        for i=1, #vehicles, 1 do
            local vehCoords = GetEntityCoords(vehicles[i])
            local distance = #(GetEntityCoords(playerPed) - vehCoords)

            if distance < Config.distance and show then
                waitTime = 1
                local plate = GetVehicleNumberPlateText(vehicles[i])
                DrawText3D(vehCoords[1], vehCoords[2], vehCoords[3]+Config.height, Config.country..plate)
            end
        end

        Citizen.Wait(waitTime)
    end
end)

RegisterCommand(Config.togCommand, function()
    show = not show   
end)
