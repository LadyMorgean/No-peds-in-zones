--add zones where you want them to be and change the radius for how far out you want it to stretch suggestion is to go to the middle of the place and do a radius of that. The First one is for Underground but you can change it to anything you want the other two are just random vectors
-- Table for multiple zones with their specific coordinates and radius
local removalZones = {
    { coords = vector3(-923.37, -776.85, 15.07), radius = 50.0 }, -- Zone 1
 --   { coords = vector3(425.12, -980.25, 30.71),  radius = 20.0 }, -- Zone 2
 --   { coords = vector3(-1087.15, -2375.03, 13.95), radius = 100.0 } -- Zone 3
}

Citizen.CreateThread(function()
    while true do
        -- Check once every second to save performance
        Citizen.Wait(1000) 

        -- Loop through each zone in the removalZones table
        for _, zone in ipairs(removalZones) do
            -- 0xBE31FD6CE464AC59
            ClearAreaOfPeds(zone.coords.x, zone.coords.y, zone.coords.z, zone.radius, false)
        end
    end
end)

-- Density management: Runs every frame to suppress spawns globally or locally
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPos = GetEntityCoords(PlayerPedId())
        local inZone = false

        -- Check if player is inside any of the zones to turn off density
        for _, zone in ipairs(removalZones) do
            if #(playerPos - zone.coords) < zone.radius then
                inZone = true
                break
            end
        end

        if inZone then
            -- Disable spawning while player is in a designated zone
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        end
    end
end)
