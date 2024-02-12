-- 🚗 Spawn a networked vehicle with the given model at the given coords and execute the callback with the network id and plate.
-- 📣 You should also set the vehicle fuel to 100% and give keys to the player.
ResourceAPI.SpawnVehicle = function(model, plate, coords, rotation, callback)
    return
    --[[if clib.config.isQBCore then
        clib.frameworks.QBCore.Functions.TriggerCallback('QBCore:Server:CreateVehicle', function(netId)
            while not NetworkDoesEntityExistWithNetworkId(netId) do
                Wait(0)
            end

            NetworkRequestControlOfNetworkId(netId)

            while not NetworkHasControlOfNetworkId(netId) do
                Wait(0)
            end

            local veh = NetToVeh(netId)

            SetVehicleNumberPlateText(veh, plate)
            SetEntityRotation(veh, rotation.x + 0.0, rotation.y + 0.0, rotation.z + 0.0, 2, true)

            local finalPlate = clib.wrappers.GetVehiclePlate(veh)

            ResourceAPI.SetVehicleFuel(veh, 100.0)

            if PublicSharedResourceConfig.GiveKeysToEmployeeFirst then
                ResourceAPI.GiveKeysToVehicle(finalPlate, model, netId)
            end

            -- ⚠️ Edit this if you use a custom vehicle tuning resource
            TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", finalPlate)

            callback(netId, finalPlate)
        end, joaat(model), coords, false)
    elseif clib.config.isESX then
        clib.frameworks.ESX.Game.SpawnVehicle(model, coords, coords.w, function(veh)
            SetVehicleNumberPlateText(veh, plate)
            SetEntityRotation(veh, rotation.x + 0.0, rotation.y + 0.0, rotation.z + 0.0, 2, true)

            local finalPlate = clib.wrappers.GetVehiclePlate(veh)

            ResourceAPI.SetVehicleFuel(veh, 100.0)

            if PublicSharedResourceConfig.GiveKeysToEmployeeFirst then
                ResourceAPI.GiveKeysToVehicle(finalPlate, model)
            end

            callback(NetworkGetNetworkIdFromEntity(veh), finalPlate)
        end, true)
    else
        -- 🔧 If using custom, implement your own code here
    end--]]
end