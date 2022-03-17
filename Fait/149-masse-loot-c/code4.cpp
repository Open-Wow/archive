			if(!player->GetGroup())
			{
				float range = 30.0f;
				uint32 gold = 0;
				Creature* creature = GetPlayer()->GetMap()->GetCreature(guid);
				Creature* c = nullptr;
				std::vector<Creature*> creaturedie;
				player->GetCreatureListWithEntryInGrid(creaturedie, creature->GetEntry(), range);
				for (std::vector<Creature*>::iterator itr = creaturedie.begin(); itr != creaturedie.end(); ++itr)
				{
					c = *itr;
					loot = &c->loot;
					gold += loot->gold;	
					loot->gold = 0;					
				}	
				loot->gold = gold;
			}
			
            player->ModifyMoney(loot->gold);
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_LOOT_MONEY, loot->gold);

            WorldPacket data(SMSG_LOOT_MONEY_NOTIFY, 4 + 1);
            data << uint32(loot->gold);
            data << uint8(1);   // "You loot..."
            SendPacket(&data);