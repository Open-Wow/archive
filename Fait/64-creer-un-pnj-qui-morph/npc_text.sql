SET 
@ID:= 60005, 
-- C\'est son ID le même que tu as dans Text_ID de Gossip_Menu

@Text0_0:= '|Accueil > ? |\r\n\r\n Cot ? Cot cot .. ! COT!'; 
-- C\'est son Texte que tu vas voir sur la jolie page aka Gossip_Menu_Option

DELETE FROM `npc_text` WHERE (ID = @MenuID);
INSERT INTO `npc_text` (`ID`, `text0_0`)
VALUES(@ID,@Text0_0);