#include "ScriptMgr.h"

enum Spells
{
	SPELL_CLEAVE	= 15284,
	SPELL_ENRAGE	= 27680
};

class World_Boss : public CreatureScript
{
public:
	World_Boss() : CreatureScript("World_Boss") { } // script name onto the DB


struct World_BossAI : public ScriptedAI
{
	
	World_BossAI(Creature* creature) : ScriptedAI(creature) {}
	
	uint32 spell_cleave_timer;
	uint32 Spawn_Timer;
	bool enraged;
	
    void JustEngagedWith(Unit* /*who*/) override
    {
		Spawn_Timer = 25000;
		spell_cleave_timer = 10000; //10sec
		enraged = false;
       		Talk(0);
    }

	void UpdateAI(uint32 diff) override
	{
		if (!UpdateVictim())
            return;
		if(spell_cleave_timer <= diff)
		{
			DoCastVictim(SPELL_CLEAVE);
			spell_cleave_timer = 10000;
		} 
		else spell_cleave_timer -= diff;
		if(Spawn_Timer <= diff)
		{
			me->SummonCreature(17895, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,1000);
			Spawn_Timer = 25000;
		} 
		else Spawn_Timer -= diff;
		if(HealthBelowPct(20) && !enraged)
		{
			DoCast(me,SPELL_ENRAGE);
			enraged = true;
		}
		DoMeleeAttackIfReady();
	}

};

CreatureAI* GetAI(Creature* creature) const
{
	return new World_BossAI(creature);
}
};

void AddSC_World_Boss()
{
	new World_Boss();
}