  SET 
	@Entry := (SELECT MAX(entry) FROM creature_template),
	@GossipMenuId := (SELECT MAX(menuid) FROM gossip_menu_option);

  UPDATE `creature_template` SET ainame = 'SmartAI' WHERE entry = @ENTRY;

  INSERT INTO `smart_scripts` (entryorguid, id, event_type, event_chance, event_param1, event_param2, action_type, action_param1, target_type, target_x, target_y, target_z, target_o, COMMENT)VALUES
    (@Entry, 0, 62, 100, @GossipMenuId, 0, 62, M, 7, X, Y, Z, O, 'TP ');