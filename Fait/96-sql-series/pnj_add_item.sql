SET @ENTRY := [ID DE TON PNJ];
SET @Gossip := [ID GOSSIP_MENU];
SET @Item := [ID ITEM];
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_​chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4​`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,​`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`t​arget_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,4,0,62,0,100,0,@Gossip,0,0,0,56,@Item,0,0,0,0,0,7,0,0,0,0,0,0,0​,"PNJ add @Item");