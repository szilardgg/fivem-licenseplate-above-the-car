local show = true

function DrawText3D(x, y, z, text)
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextOutline(0, 0, 0, 255)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0+0.0165, 0.060, 0.033, 0, 0, 0, 60)
    ClearDrawOrigin()
end

function drawPlates()
    while show do 
        local vehicles <const> = GetGamePool("CVehicle")
        local playerCoords <const> = GetEntityCoords(PlayerPedId())

        for i=1, #vehicles, 1 do
            local vehCoords <const> = GetEntityCoords(vehicles[i])
            
            if #(playerCoords - vehCoords) < Config.distance and not IsPedInVehicle(PlayerPedId(),vehicles[i],true) then
                local plate <const> = GetVehicleNumberPlateText(vehicles[i])
                DrawText3D(vehCoords[1], vehCoords[2], vehCoords[3]+Config.height, Config.country .. plate)
            end
        end
    end
end
CreateThread(drawPlates)

RegisterCommand(Config.togCommand, function()
    show = not show
    if (show) then 
        CreateThread(drawPlates)
    end
end)

