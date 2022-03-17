SET
	@Entry := (SELECT MAX(entry)+1 FROM creature_template),
	@Model := , -- A toi de mettre le model de ta créature
	@Npcflag := 1,
	@Faction := 35,
	@UnitClass := 1,
	@Level := 80, -- A toi de mettre le niveau de ta créature
	@GossipMenuId := (SELECT MAX(menuid)+1 FROM gossip_menu_options),
	@Name := ''; -- A toi de mettre ce que tu souhaite comme nom

INSERT INTO `creature_template` (entry, modelid1, npcflag, faction, unit_class, minlevel, maxlevel, gossip_menu_id, name) VALUES
	(@Entry, @Model, @Npcflag, @Faction, @UnitClass, @Level, @Level, @GossipMenuId, @Name);