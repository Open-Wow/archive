-- Ajout trigger pour item_template vers item_dbc
  -- Après insert
DELIMITER $$
CREATE 
	TRIGGER `[insert]item_template_to_dbc` BEFORE INSERT
	ON `R1_World`.`item_template` 
	FOR EACH ROW BEGIN
		INSERT INTO item_dbc VALUES (new.entry, new.class, new.subclass, new.SoundOverrideSubclass, new.material, new.displayid, new.inventorytype, new.sheath);
	END$$
DELIMITER ;

  -- Après update
DELIMITER $$
CREATE 
	TRIGGER `[update]item_template_to_dbc` BEFORE UPDATE
	ON `R1_World`.`item_template`
	FOR EACH ROW BEGIN
		REPLACE INTO item_dbc VALUES (new.entry, new.class, new.subclass, new.SoundOverrideSubclass, new.material, new.displayid, new.inventorytype, new.sheath);
	END$$
DELIMITER ;

  -- Après delete
DELIMITER $$ 
CREATE 
	TRIGGER `[delete]item_template_to_dbc` BEFORE DELETE
	ON `R1_World`.`item_template` 
	FOR EACH ROW BEGIN
		DELETE FROM item_dbc WHERE entry = old.entry;
	END$$
DELIMITER ;
