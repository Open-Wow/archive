SET 
@ENTRY:= 50001, 
-- L\'ID du PNJ (Pour lier ça à ta créature!)

@ID:= 0, 
-- Bon la t\'es pas con, t\'as compris

@LINK:= 1,
 -- Sympas ce machin en gros tu peu liéer 1 EVENT_TYPE à 2 ACTION_TYPE (Genre la nous on veux on gossip select > remove item et morph)

@ID_1:= 1, 
-- Pareil que le ID normal quoi ..

@EventType_1:= 62, 
-- Simple c\'est event_type tu as plusieurs type, la nous on utilise l\'event GOSSIP_SELECT

@EventType_2:= 61, 
-- Et ici on utilise le LINK

@EVENT_PARAM1:= 60005, 
-- Donc la on met tout simplement le gossip_menu_option

@ACTION_TYPE_1:= 57, 
-- Comme pour event_type tu as plusieurs Action_type nous on utilise le REMOVE_ITEM

@ACTION_TYPE_2:= 75, 
-- Et la le ADD_AURA

@ACTION_PARAM1_1:= 6948, 
-- Ici l\'ID de l\'ITEMS qu\'il faut pour se faire morph (En gros toi tu as une pierre de foyer, le PNJ te le retire et te morph, si tu as pas pierre de 
foyer, pas de morph)

@ACTION_PARAM2_1:= 1, 
-- Le nombre d\'items qu\'il faut pour se faire morph (1 Pierre de foyer dans notre exemple)

@ACTION_PARAM1_2:= 190000, 
-- L\'ID du Sort aka de l\'Aura car oui tu as créer un sort mais le PNJ ne va pas lancer le sort il va appliquer le sort au joueurs aka appliquer une AURA

@TARGET_TYPE:= 7, 
-- Le target Type ! Super ce truc, donc la on met le 7 aka Action_Invoker

@COMMENT_1:= 'Poulet > 6948 x1 > Link 1', 
-- Les commentaires, je te conseil là de bien mettre ce qui se passe au plus simple, évite les longue phrases c\'est chiant à lire.

@COMMENT_2:= 'Poulet > Link 1 > Morph 50001'; 
-- Mais oublie pas faut que ça soit compréhensible de tous ou au moins des gars de ton équipe.

DELETE FROM `smart_scripts` WHERE (entryorguid = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (@ENTRY, 0, @ID, @LINK, @EventType_1, 0, 100, 0, @EVENT_PARAM1, 0, 0, 0, @ACTION_TYPE_1, @ACTION_PARAM1_1, @ACTION_PARAM2_1, 0, 0, 0, 0, @TARGET_TYPE, 0, 0, 0, 0, 0, 0, 0, @COMMENT_1),
(@ENTRY, 0, @ID_1, 0, @EventType_2, 0, 100, 0, 0, 0, 0, 0, @ACTION_TYPE_2, @ACTION_PARAM1_2, 0, 0, 0, 0, 0, @TARGET_TYPE, 0, 0, 0, 0, 0, 0, 0, @COMMENT_2);