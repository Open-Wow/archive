SET @MenuID:= 60005, 
-- L\'ID du gossip_menu_option là c\'est = 60005

@OptionID:= 0, 
-- C\'est l\'ordre du gossip, enfin des options

@OptionIcon:= 0,
-- Tu peu tout simplement mettre une petite icône sympas

@OptionText:= 'Morph moi si tu peux!', 
-- Bah c\'est le texte ex : "Montrez moi ce que vous avez à vendre". Tu comprend là, dans ta tête le PNJ commence à prendre forme

@OptionType= 1, 
-- Simple tu met la même chose que dans OptionNPCFlag (Sauf dans certains cas, moi je te conseil de mettre 1), sinon c\'est des "Flags" des options si tu préfères

@OptionNPCFlag:= 1, 
-- Simple tu met ce que tu as mis dans NPCFLAG de ton creature_template, tu met toujours ce qu\'il y a dans creature_template colonne NPCFLAG ! TOUJOURS!

@ActionMenuID:= 60005; 
-- Bon tu peu en gros liée un Gossip à un autre genre tu clique sur Menu 1 tu arrive sur Page 2

DELETE FROM `gossip_menu_option` WHERE (MenuID = @MenuID);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionType`, `OptionNPCFlag`, `ActionMenuID`)VALUES (@MenuID, @OptionID, @OptionIcon, @OptionText, @OptionType, @OptionNPCFlag, @ActionMenuID);[/sql]


[align=center][size=120][color=#FF4000]4/- GOSSIP_MENU & NPC_TEXT ?[/color][/size][/align]
[code=sql]SET 
@MenuID := 60005, 
-- Alors c\'est l\'ID du MenuID de ton Gossip_Menu_Option Aka (60005)

@TextID := 60005; 
-- C\'est l\'ID du NPC_Text

DELETE FROM `gossip_menu` WHERE (MenuID = @MenuID);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES(@MenuID,@TextID);