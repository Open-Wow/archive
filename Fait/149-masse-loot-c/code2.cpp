       Creature* creature = GetPlayer()->GetMap()->GetCreature(lguid);
		if(!player->GetGroup())
		{
			int i =0;
			float range = 30.0f;
			Creature* c = nullptr;
			std::vector<Creature*> creaturedie;
			player->GetCreatureListWithEntryInGrid(creaturedie, creature->GetEntry(), range);
			for (std::vector<Creature*>::iterator itr = creaturedie.begin(); itr != creaturedie.end(); ++itr)
			{
				c = *itr;
				loot = &c->loot;
				
				uint8 maxSlot = loot->GetMaxSlotInLootFor(player);
				for (i = 0; i < maxSlot; ++i) 
				{				
					LootItem* item = loot->LootItemInSlot(i, player);
					if(player->AddItem(item->itemid, item->count))
					{
						player->SendNotifyLootItemRemoved(lootSlot);
						player->SendLootRelease(player->GetLootGUID());
					}				
					else
					{
						player->SendItemRetrievalMail(item->itemid, item->count);
						player->GetSession()->SendAreaTriggerMessage("Votre objet vous a été envoyé par mail.");
					}
				}	
				
				loot->clear();
				
				if(loot->isLooted() && loot->empty())
				{
					c->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
					c->AllLootRemovedFromCorpse();							
				}
			}
		}
		else
		{
			bool lootAllowed = creature && creature->IsAlive() == (player->GetClass() == CLASS_ROGUE && creature->loot.loot_type == LOOT_PICKPOCKETING);
			if (!lootAllowed || !creature->IsWithinDistInMap(_player, INTERACTION_DISTANCE))
			{
				player->SendLootError(lguid, lootAllowed ? LOOT_ERROR_TOO_FAR : LOOT_ERROR_DIDNT_KILL);
				return;
			}

			loot = &creature->loot;
		}