SET
	@ID := (SELECT MAX(id)+1 FROM creature_template);

INSERT INTO `npc_text` (id, text0_0) VALUES
	(@ID, 'Ton Texte');
	-- Si tu souhaite rajouter plusieurs texte pour plusieurs pages tu copie colle la ligne et tu met (@ID+1) oublie pas de remplacer le ";" par un "," faut surtout pas oublier que le ";" signifie "FIN DE CODE"

SET
	@MenuID := (SELECT MAX(menuid) FROM gossip_menu_option);
    

INSERT INTO `gossip_menu` (menuid, textid) VALUES
	(@ID, @MenuID);
	-- Si tu as créé plusieurs textes et donc plusieurs "pages/catégorie" alors en gros ça dit "Affiche Texte(@ID) sur la Page(@MenuID)"