local itemname = 40752; --ENTRY ITEM POUR ACHETER CHANGEMENT DE NOM
local itemrace = 40752; --ENTRY ITEM POUR ACHETER CHANGEMENT DE RACE
local itemfaction = 40752; --ENTRY ITEM POUR ACHETER CHANGEMENT DE FACTION
local itemapp = 40752; --ENTRY ITEM POUR ACHETER CHANGEMENT D'APPARENCE
local prixname = 10; --NOMBRE D'ITEM POUR ACHETER CHANGEMENT DE NOM
local prixrace = 10; --NOMBRE D'ITEM POUR ACHETER CHANGEMENT DE RACE
local prixfaction = 10; --NOMBRE D'ITEM POUR ACHETER CHANGEMENT DE FACTION
local prixapp = 10; --NOMBRE D'ITEM POUR ACHETER CHANGEMENT DE L'APPARENCE
local faction = {
	[0] = "|cff0abde3Alliance",
	[1] = "|cffee5253Horde"
};

local function CustomCommand(event, player, command)
    if (command == "custom") then
	player:SendBroadcastMessage("              |cffff9f43|  |cfffeca57Custom ton personnage  |cffff9f43|");
	player:SendBroadcastMessage("|cfffeca57Votre Faction : " .. faction[player:GetTeam()] .. " |cfffeca57.");
	player:SendBroadcastMessage("|cffff9f43Comment faire ? |cfffeca57Exemple :\n|cfffeca57     .changename  (|cffff9f43Si je souhaite changer de nom|cfffeca57)");
    player:SendBroadcastMessage("|cfffeca57.changename|cfffeca57 - |cffff9f43Modification du nom |cfffeca57-|cfffeca57 Prix : 10x |cffff9f43[Jeton VIP]");
    player:SendBroadcastMessage("|cfffeca57.changerace|cfffeca57 - |cffff9f43Modification de la race |cfffeca57-|cfffeca57 Prix : 10x |cffff9f43[Jeton VIP]");
    player:SendBroadcastMessage("|cfffeca57.changefaction|cfffeca57 - |cffff9f43Modification de la faction |cfffeca57-|cfffeca57 Prix : 10x |cffff9f43[Jeton VIP]");
    player:SendBroadcastMessage("|cfffeca57.changeapp|cfffeca57 - |cffff9f43Modification de l'apparence |cfffeca57-|cfffeca57 Prix : 10x |cffff9f43[Jeton VIP]");
	end
end
local function ChangeNameCommand(event, player, command)
	if (command == "changename") then
		if player:HasItem(itemname, prixname) then
		player:RemoveItem(itemname, prixname)
		player:SetAtLoginFlag(1);
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous devez vous déconnecter pour finaliser le changement.. |cffff9f43|");
	else
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous n'avez pas assez de |cffff9f43[Jeton VIP] |");
		end
	end
end
local function ChangeRaceCommand(event, player, command)
	if (command == "changerace") then
		if player:HasItem(itemrace, prixrace) then
		player:RemoveItem(itemrace, prixrace)
		player:SetAtLoginFlag(128);
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous devez vous déconnecter pour finaliser le changement.. |cffff9f43|");
	else
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous n'avez pas assez de |cffff9f43[Jeton VIP] |");
		end
	end
end
local function ChangeFactionCommand(event, player, command)
	if (command == "changefaction") then
		if player:HasItem(itemfaction, prixfaction) then
		player:RemoveItem(itemfaction, prixfaction)
		player:SetAtLoginFlag(64);
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous devez vous déconnecter pour finaliser le changement.. |cffff9f43|");
	else
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous n'avez pas assez de |cffff9f43[Jeton VIP] |");
		end
	end
end
local function ChangeAppCommand(event, player, command)
	if (command == "changeapp") then
		if player:HasItem(itemapp, prixapp) then
		player:RemoveItem(itemapp, prixapp)
		player:SetAtLoginFlag(8);
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous devez vous déconnecter pour finaliser le changement.. |cffff9f43|");
	else
		player:SendBroadcastMessage("|cffff9f43| |cfffeca57Vous n'avez pas assez de |cffff9f43[Jeton VIP] |");
		end
	end
end

RegisterPlayerEvent(42, CustomCommand)
RegisterPlayerEvent(42, ChangeNameCommand)
RegisterPlayerEvent(42, ChangeRaceCommand)
RegisterPlayerEvent(42, ChangeFactionCommand)
RegisterPlayerEvent(42, ChangeAppCommand)