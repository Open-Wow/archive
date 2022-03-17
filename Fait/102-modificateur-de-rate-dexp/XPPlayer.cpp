#include "XPPlayer.hpp"

std::map<uint64,float> XPPlayer::modXp;

void XPPlayer::OnGiveXP(Player * player, uint32 & amount, Unit * /*victim*/) {
    if(player == nullptr) {
        return;
    }

    if(std::find(XPPlayer::modXp.begin(), XPPlayer::modXp.end(), player->GetGUID()) != XPPlayer::modXp.end()) {

        amount *= XPPlayer::modXp[player->GetGUID()];

    }

    return;
}

void AddSC_XPPlayer()
{
    new XPPlayer();
}
