SET
	@MenuID = (Select MAX(menuid) FROM gossip_menu_option);

-- EXEMPLE DE MENU AVEC AUCUNE SOUS CATEGORIES
INSERT INTO `gossip_menu_option` (menuid, optionid, optionicon, optiontext, optiontype, optionnpcflag, actionmenuid) VALUES
	(@MenuID, 0, 0, 'Emplacement I', 1, 1, @MenuID),
	(@MenuID, 1, 0, 'Emplacement II', 1, 1, @MenuID),
	(@MenuID, 2, 0, 'Emplacement III', 1, 1, @MenuID);

-- EXEMPLE DE MENU AVEC SOUS CATEGORIES
INSERT INTO `gossip_menu_option` (menuid, optionid, optionicon, optiontext, optiontype, optionnpcflag, actionmenuid) VALUES
	(@MenuID, 0, 0, 'Emplacement I', 1, 1, @MenuID),
	(@MenuID, 1, 0, 'Emplacement II', 1, 1, @MenuID+1),
		(@MenuID+1, 0, 0, 'Emplacement I', 1, 1, @MenuID+1),
		(@MenuID+1, 1, 0, 'Emplacement II', 1, 1, @MenuID+1),
		(@MenuID+1, 2, 0, 'Emplacement III', 1, 1, @MenuID+1),
		(@MenuID+1, 50, 0, '{bouton retour}', 1, 1, @MenuID),
	(@MenuID, 2, 0, 'Emplacement III', 1, 1, @MenuID);