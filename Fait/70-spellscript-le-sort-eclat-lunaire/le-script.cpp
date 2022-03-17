// 8921 - Moonfire (Dummy)
class spell_dru_moonfire : public SpellScriptLoader
{
public:
spell_dru_moonfire() : SpellScriptLoader("spell_dru_moonfire") { }

class spell_dru_moonfire_SpellScript : public SpellScript
{
PrepareSpellScript(spell_dru_moonfire_SpellScript);

enum
{
SPELL_DRUID_MOONFIRE_DAMAGE = 164812
};

bool Load() override
{
if (GetCaster() && GetCaster()->GetTypeId() != TYPEID_PLAYER)
return false;

return true;
}

void HandleOnHit()
{
Unit* caster = GetCaster();
Unit* target = GetHitUnit();

if (!caster || !target)
return;

caster->CastSpell(target, SPELL_DRUID_MOONFIRE_DAMAGE, true);
}

void Register() override
{
OnHit += SpellHitFn(spell_dru_moonfire_SpellScript::HandleOnHit);
}
};

SpellScript* GetSpellScript() const override
{
return new spell_dru_moonfire_SpellScript();
}
};

void AddSC_druid_spell_scripts()
{

new spell_dru_moonfire();

}