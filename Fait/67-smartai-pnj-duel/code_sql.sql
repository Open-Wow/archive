SET @ENTRY := 60540;
SET @GOSSIP := 65576;
UPDATE `creature_template` SET `HealthModifier` = 3.5, `ArmorModifier` = 2.5, `DamageModifier` = 2.5,`resistance1` = 25, `resistance2` = 25, `resistance3` = 25, `resistance4` = 25, `resistance5` = 25, `resistance6` = 25 WHERE (entry = @ENTRY);

UPDATE `creature_template` SET `npcflag` = 1, `unit_class` = 1, `unit_flags2` = 2048, `gossip_menu_id` = @GOSSIP, `type_flags` = 0 WHERE (entry = @ENTRY);



SET NAMES utf8;
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`) VALUES
(65576, 0, 0, "Voulez-vous vous mesurer à moi ?", 0, 1, 1, 0, 0, 0, 0, '', 0);




UPDATE `creature_template` SET `HealthModifier` = 3.5, `ArmorModifier` = 2.5, `DamageModifier` = 2.5,`resistance1` = 25, `resistance2` = 25, `resistance3` = 25, `resistance4` = 25, `resistance5` = 25, `resistance6` = 25 WHERE (entry = @ENTRY);
UPDATE `creature_template` SET `npcflag` = 1, `unit_class` = 1, `unit_flags2` = 2048, `gossip_menu_id` = @GOSSIP, `type_flags` = 0 WHERE (entry = @ENTRY);
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,10,15,62,0,100,0,@GOSSIP,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"GOSSIP_MENU : fermer gossip"),
(@ENTRY,0,15,20,61,0,100,0,0,0,0,0,80,5494400,2,0,0,0,0,1,0,0,0,0,0,0,0," - ACTIONLIST"),
(@ENTRY,0,20,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0," - blabla 0"),
(@ENTRY,0,25,30,2,0,100,0,0,20,3000,3000,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"DUEL GAGNANT : 1-20% pv : faction neutre"),
(@ENTRY,0,30,35,61,0,100,0,0,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0," - credit"),
(@ENTRY,0,35,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0," - blabla 1"),
(@ENTRY,0,40,45,5,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"DUEL PERDU : blabla 2"),
(@ENTRY,0,45,0,61,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0," - faction neutre"),
(@ENTRY,0,55,0,9,0,100,0,0,5,2500,3000,11,119526,0,0,0,0,0,2,0,0,0,0,0,0,0,"Poings roulants");





REPLACE INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@ENTRY, 0, 0, "Trés bien , montrez moi", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 1, "J'essaierais de ne vous faire pas trop mal", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 2, "Sa va etre votre fete !", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 3, "On évite l’estomac, d’accord ?", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 4, "Ouais ! D’la baston !", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 5, "Trés bien , montrez moi vos compétences", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 6, "J'essaierais de ne pas vous tuer", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 0, 7, "Ouais ! Ça va saigner !", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 0, "Merci de m’avoir donné l’occasion d’être vaincu par vous.", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 1, "Joli combat.", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 2, "Beau combat. Mais je vous aurai, un jour.", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 3, "Je ne crois pas avoir eu une seule chance. À un de ces quatre.", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 4, "Waouh… Moi qui croyais y arriver…", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 5, "Joli combat.", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 6, "Sa ne compte pas , je n'étais pas en forme aujourdhui", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 1, 7, "Mouai , je croyais que ce serait facile …", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 2, 0, "Vous prenez ça vraiment au sérieux, pas vrai ?", 12, 0, 0, 11, 500, 0, 0, 0, "Commentaire"),
(@ENTRY, 2, 1, "Et voila ... c'etait prévisible", 12, 0, 0, 1, 500, 0, 0, 0, "Commentaire");





-- Actionlist SAI
SET @ENTRY := 5494400;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,10,15,60,0,100,1,5000,5000,5000,5000,2,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tempo avant faction agressive 5s"),
(@ENTRY,9,15,0,61,0,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0," - attaque joueur");

