ResourceAPI = {}

-- 🚗 Create a new vehicle on the database for the given character identifier.
ResourceAPI.CreateNewVehicle = function(source, characterIdentifier, vehicleModel, plate, props, vehType)
    MySQL.query('SELECT spawns FROM Cdev_vehicleshop_shops', function(result)
        if result[1] then
            local decoded = json.decode(result[1].spawns)
            local coords = decoded.coords
            local data = {
                source = source, --Who is the source. Send the Player ID. Also make sure it is number!
                hash = GetHashKey(vehicleModel), --The hash number of the vehicle
                coords = vector4(coords.x, coords.y, coords.z, coords.rotation), --This is a vector 4 location. Inlcludes x,y,z,heading.
                identifier = characterIdentifier, --Requires the owner of the vehicle. (Player.PlayerData.citizenid - QBCORE)
                license = clib.api.Character.GetPlayerLicenseFromSource(source), --This is license id, you can leave it blank
                vehicleName = vehicleModel, --The name of the vehicle in a string format - ("adder")
                balance = 0, --Only for QBCORE
                vehPaymentsLeft = 0, --Only for QBCORE
                paymentAmount = 0, --Only for QBCORE
                financeTime = 0, --Only for QBCORE
            }
            TriggerEvent("realisticVehicleSystem:server:addVehicle", 1, data)
        else
            print("No data found in the database.")
        end
    end