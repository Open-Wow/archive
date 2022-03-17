#include "WorldSession.h"

class levelup : public PlayerScript
{
public:
    levelup() : PlayerScript("levelup") { }

    void OnLevelChanged(Player* player, uint8 oldLevel)
    {
    	    WorldSession* session = player->GetSession();

        //Si oldLevel modulo 10 = 0, alors oldLevel est un multiple de 10
        if (oldLevel%10==0)
        {
            player->CastSpell(player, 11305, true);
            player->GetSession()->SendAreaTriggerMessage("Félicitations vous êtes maintenant niveau "+oldLevel+"!");
        }
    }
};

void AddSC_levelup()
{
    new levelup();
}
