#ifndef AZEROTHCORE_XPPLAYER_HPP
#define AZEROTHCORE_XPPLAYER_HPP


class XPPlayer : public PlayerScript {
public:
    XPPlayer() : PlayerScript("XPModifierPlayer") {};
    void OnGiveXP(Player* /*player*/, uint32& /*amount*/, Unit* /*victim*/) override;

    static std::map<uint64,float> modXp;
};


#endif //AZEROTHCORE_XPPLAYER_HPP
