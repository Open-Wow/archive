SET
@ENTRY:= 50001, 
-- Bah .. l\'entry (Genre son ID quoi pour le faire spawn),

@ModelID:= 304, 
-- Son Model aka son Skin,

@Type:= 7, 
-- Son Type (Genre Humanoïde, Géant, Bête etc.),

@NPCFlag:= 1, 
-- Imagine ça comme des options, mais genre des options bien sympas,

@Unit_Class:= 1, 
-- La classe de ton PNJ il en existe pas beaucoup (1= Guerrier (Barre de vie seulement et beaucoup de Vie) 2= Paladin (Beaucoup de Vie et peu de Mana), 4= Voleur (Barre de Vie seulement et peu de Vie), 8= Mage (Peu de Vie et beaucoup de Mana))

@Unit_Flags:= 2048, 
-- Encore plus d\'option la normalement c\'est le moment ou tu peu "activer" la regen de vie etc.

@Faction:= 35, 
-- Sa faction nous on va utiliser la faction 35 parce qu\'on a la flemme de cherche une autre faction ;)

@Name:= 'Poulet de Fou!', 
-- Déconne pas .. c\'est son nom

@SubName:= 'Il te Morph!', 
-- Bah son sous nom ..

@MinLevel:= 80, 
-- Son niveau minimum, minimal, son niveau mini!

@MaxLevel:= 80, 
-- T\'as compris le truc ..

@AIName:= 'SmartAI', 
-- Alors l\'AIName c\'est compliqués, tu peux en avoir plusieurs mais nous on s\'en fou on juste utiliser le SmartAI

@Gossip_menu_id:= 60005; 
-- L\'ID du Gossip_Menu_Option, on s\'en sert juste après ^^

DELETE FROM `creature_template` WHERE (entry = @ENTRY);
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `modelid1`, `npcflag`, `unit_class`, `unit_flags2`, `AIName`, `faction`, `type`, `minlevel`, `maxlevel`, `gossip_menu_id`)
VALUES (@ENTRY, @Name, @SubName, @ModelID, @NPCFlag, @Unit_Class, @Unit_Flags, @AIName, @Faction, @Type, @MinLevel, @MaxLevel, @Gossip_menu_id);
