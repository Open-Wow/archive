    int StoreCreatureInCache(lua_State* L, Player* player)
    {
        uint32 entry = Eluna::CHECKVAL<uint32>(L, 1);

        if ( !entry )
            return 1;

        CreatureTemplate const* ci = eObjectMgr->GetCreatureTemplate(entry);
        if (ci)
        {
            std::string Name, Title;
            Name = ci->Name;
            Title = ci->SubName;

            LocaleConstant loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
            if (loc_idx >= 0)
            {
                if (CreatureLocale const* cl = eObjectMgr->GetCreatureLocale(entry))
                {
                    ObjectMgr::GetLocaleString(cl->Name, loc_idx, Name);
                    ObjectMgr::GetLocaleString(cl->Title, loc_idx, Title);
                }
            }
            // guess size
            WorldPacket data(SMSG_CREATURE_QUERY_RESPONSE, 100);
            data << uint32(entry);                              // creature entry
            data << Name;
            data << uint8(0) << uint8(0) << uint8(0);           // name2, name3, name4, always empty
            data << Title;
            data << ci->IconName;                               // "Directions" for guard, string for Icons 2.3.0
            data << uint32(ci->type_flags);                     // flags
            data << uint32(ci->type);                           // CreatureType.dbc
            data << uint32(ci->family);                         // CreatureFamily.dbc
            data << uint32(ci->rank);                           // Creature Rank (elite, boss, etc)
            data << uint32(ci->KillCredit[0]);                  // new in 3.1, kill credit
            data << uint32(ci->KillCredit[1]);                  // new in 3.1, kill credit
            data << uint32(ci->Modelid1);                       // Modelid1
            data << uint32(ci->Modelid2);                       // Modelid2
            data << uint32(ci->Modelid3);                       // Modelid3
            data << uint32(ci->Modelid4);                       // Modelid4
            data << float(ci->ModHealth);                       // dmg/hp modifier
            data << float(ci->ModMana);                         // dmg/mana modifier
            data << uint8(ci->RacialLeader);

            CreatureQuestItemList const* items = eObjectMgr->GetCreatureQuestItemList(entry);
            if (items)
                for (size_t i = 0; i < MAX_CREATURE_QUEST_ITEMS; ++i)
                    data << (i < items->size() ? uint32((*items)[i]) : uint32(0));
            else
                for (size_t i = 0; i < MAX_CREATURE_QUEST_ITEMS; ++i)
                    data << uint32(0);

            data << uint32(ci->movementId);                     // CreatureMovementInfo.dbc
            player->GetSession()->SendPacket(&data);

            Eluna::Push(L, true);
            return 1;
        }

        Eluna::Push(L, false);
        return 1;
    }