SET @ENTRY := [ENTRY ou GUID de votre mob];
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
 
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_​​chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param​4​`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4​`,​`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`​,`t​arget_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,1,0,22,0,100,0,78,1,1,0,5,16,0,0,0,0,0,1,0,0,0,0,0,0,0,"Réponse à l'emote");