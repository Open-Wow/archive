-- VERSION 1
-- Fonction custom pour retirer tout l'équipement du joueur1
local function RemoveEquipment(player)
    for index = 0, 18 do
        local equipment = player:GetEquippedItemBySlot(index)
        if (equipment ~= nil) then  
            player:SetData(index, equipment:GetEntry())               
            player:RemoveItem(equipment, 1)
        end
    end
end

-- Appel de la fonction custom pour l'objet player
local function trigger(event, player, command)
    if (command == "toto") then
    	RemoveEquipment(player)
    end
    return false
end
RegisterPlayerEvent(42, trigger)
