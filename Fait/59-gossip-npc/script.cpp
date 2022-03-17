#include "ScriptMgr.h"
#include "ScriptedGossip.h"

class GossipTutroial : public CreatureScript
{
     public:
          GossipTutroial() : CreatureScript("GossipTutroial") { }
     static bool OnGossipHello(Player * player, Creature * creature)
     {
          AddGossipItemFor(player,GOSSIP_ICON_CHAT, "Hello World", GOSSIP_SENDER_MAIN, 1);
          AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Good Bye", GOSSIP_SENDER_MAIN, 2);
          SendGossipMenuFor(player, player-&gt;GetGossipTextId(creature), creature-&gt;GetGUID());
          return true;
     }

     static bool OnGossipSelect(Player* player, Creature* creature , uint32 Action)
     {
          switch (Action)
          {
               case 1:
                    creature-&gt;TextEmote("Bienvenue sur Open-WOW", player);
                    CloseGossipMenuFor(player);
                    break;
               case 2:
                    CloseGossipMenuFor(player);
                    break;
          }
          return true;
     }

     struct MyAI : public ScriptedAI
     {
          MyAI(Creature* m_creature) : ScriptedAI(m_creature) { }
          bool GossipHello(Player* player) override
          {
               return OnGossipHello(player, me);
          }
          bool GossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
          {
               uint32 action = player-&gt;PlayerTalkClass-&gt;GetGossipOptionAction(gossipListId);
               return OnGossipSelect(player, me, action);
          }
     };
     CreatureAI* GetAI(Creature* creature) const override
     {
          return new MyAI(creature);
     }
};

void AddSC_GossipTutroial()
{
     new GossipTutroial();
}
