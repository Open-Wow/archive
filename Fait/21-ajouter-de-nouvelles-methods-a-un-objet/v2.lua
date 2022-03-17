-- VERSION 2
-- Ajout d'une methode à l'objet Player
rawset(_G['Player'],'RemoveEquipment', function(player) for index = 0, 18 do local equipment = player:GetEquippedItemBySlot(index) if (equipment ~= nil) then player:SetData(index, equipment:GetEntry()) player:RemoveItem(equipment, 1) end end end)

-- Appel de la méthode de l'objet Player
local function trigger2(event, player, command)
    if (command == "toto") then
    	player:RemoveEquipment()
    end
    return false
end

RegisterPlayerEvent(42, trigger2)