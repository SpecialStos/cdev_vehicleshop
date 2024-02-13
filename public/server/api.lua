ResourceAPI = {}

-- 🚗 Create a new vehicle on the database for the given character identifier.
ResourceAPI.CreateNewVehicle = function(source, characterIdentifier, vehicleModel, plate, props, vehType)
    MySQL.query('SELECT spawns FROM cdev_vshop_shops', function(result)
        if result[1] then
            local decoded = json.decode(result[1].spawns)
            local coords = decoded[1].coords
            local rotation = decoded[1].rotation
            local data = {
                source = source,
                hash = GetHashKey(vehicleModel),
                coords = vector4(coords.x, coords.y, coords.z, rotation.z), -- rotation.z is used as heading
                identifier = characterIdentifier,
                license = clib.api.Character.GetPlayerLicenseFromSource(source),
                vehicleName = vehicleModel,
                balance = 0,
                vehPaymentsLeft = 0,
                paymentAmount = 0,
                financeTime = 0,
            }
            TriggerEvent("realisticVehicleSystem:server:addVehicle", 1, data)
        else
            print("No data found in the database.")
        end
    end)
end
