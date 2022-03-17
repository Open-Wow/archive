#include "XPCreature.hpp"
#include "XPPlayer.hpp"

std::map<uint64, float> XPPlayer::modXp;

void AddSC_XPCreature() {
    new XPCreature();
}

bool XPCreature::OnGossipHello(Player *player, Creature *creature) {

    if (player == nullptr || creature == nullptr) {
        return true;
    }


    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Rate x1", GOSSIP_SENDER_MAIN, 1);
    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Rate x2 ", GOSSIP_SENDER_MAIN, 2);
    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Rate x3 ", GOSSIP_SENDER_MAIN, 2);

    SendGossipMenuFor(player, 68, creature);

}

bool XPCreature::OnGossipSelect(Player *player, Creature *creature, uint32 /*sender*/, uint32 action) {
    if (player == nullptr || creature == nullptr) {
        return true;
    }

    ClearGossipMenuFor(player);

    float mod=1.00;

    switch (action) {
        case 1: {
            mod=1.00;
            break;
        }
        case 2: {
            mod=2.00;
            break;
        }
        case 3: {
            mod=3.00;
            break;
        }
    }


    if(std::find(XPPlayer::modXp.begin(), XPPlayer::modXp.end(), player->GetGUID()) != XPPlayer::modXp.end())
    {
        XPPlayer::modXp[player->GetGUID()] = mod;
    } else {
        XPPlayer::modXp.insert(std::make_pair(player->GetGUID(), mod));
    }

    CloseGossipMenuFor(player);

    return true;
}
