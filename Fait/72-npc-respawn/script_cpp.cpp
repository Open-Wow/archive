#include "ScriptPCH.h"

class NPC_Respawn : public CreatureScript
{
public:

    NPC_Respawn()
        : CreatureScript("NPC_Respawn") {}

    static bool OnGossipHello(Player* player, Creature* creature)
    {

        AddGossipItemFor(player, 5, "Respawn la zone", GOSSIP_SENDER_MAIN, 333);
        AddGossipItemFor(player, 7, "Ce cristal a un temps de recharge de 5 minutes, utilisez le soigneusement.", GOSSIP_SENDER_MAIN, 334);

        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());

        return true;
    }

    static void SendDefaultMenu(Player* player, Creature* creature, uint32 action)
    {
        // Interdit en combat
        if (player->IsInCombat())
        {
            CloseGossipMenuFor(player);
            creature->Whisper("Vous etes en combat !", LANG_UNIVERSAL, player, true);
            return;
        }

        switch (action)
        {
            case 333:  //Respawn
            {
                CellCoord p(Trinity::ComputeCellCoord(player->GetPositionX(), player->GetPositionY()));
                Cell cell(p);
                cell.SetNoCreate();

                Trinity::RespawnDo u_do;
                Trinity::WorldObjectWorker<Trinity::RespawnDo> worker(player, u_do);

                TypeContainerVisitor<Trinity::WorldObjectWorker<Trinity::RespawnDo>, GridTypeMapContainer > obj_worker(worker);
                cell.Visit(p, obj_worker, *player->GetMap(), *player, player->GetGridActivationRange());

                // Le npc meurt, retirez cette ligne si vous voulez qu'un joueur puisse Respawn à l'infini
                player->Kill(creature);

                player->PlayerTalkClass->SendCloseGossip();
            }
            break;

            case 334: //msg
            {
                player->PlayerTalkClass->SendCloseGossip();
                break;
            }
        }
    }

    static bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        // Main menu
        if (sender == GOSSIP_SENDER_MAIN)
        {
            SendDefaultMenu(player, creature, action);
        }

        return true;
    }


    struct npcRespawnAI : public ScriptedAI
    {
        npcRespawnAI(Creature* creature)
            : ScriptedAI(creature) { }

        bool GossipHello(Player* player) override
        {
            return OnGossipHello(player, me);
        }

        bool GossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
        {
            uint32 sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            return OnGossipSelect(player, me, sender, action);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npcRespawnAI(creature);
    }

};

void AddSC_NPC_Respawn()
{
    new NPC_Respawn;
}