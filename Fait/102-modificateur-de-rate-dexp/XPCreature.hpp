#ifndef AZEROTHCORE_XPCREATURE_HPP
#define AZEROTHCORE_XPCREATURE_HPP


class XPCreature : public CreatureScript {
public:
    XPCreature() : CreatureScript("XPModifierCreature") {};
    bool OnGossipHello(Player * /*player*/, Creature * /*creature*/) override;
    bool OnGossipSelect(Player * /*player*/, Creature * /*creature*/, uint32 /*sender*/, uint32 /*action*/) override;
};


#endif //AZEROTHCORE_XPCREATURE_HPP