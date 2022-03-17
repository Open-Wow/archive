
--[[
    DONNEES SQL : ( si vous voulez le même boss que moi)

    creature_template & creature_equip_template :

        INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (75000, 0, 0, 0, 0, 0, 2074, 0, 0, 0, 'Stone', 'La confrérie des Défias', 'Attack', 0, 15, 15, 0, 17, 0, 1, 1.14286, 25, 1, 1, 0, 1, 1500, 1750, 1, 1, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 2, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 0);
        INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES (75000, 1, 2488, 1201, 0, 0);

]]

-- ID de notre boss, ici 75000
local STONE_ID = 75000

--[[
    Table qui contient la liste de toutes les phases du boss avec des valeurs utiles,
    comme savoir à quel pourcentage de vie il faut déclancher la phase et
    savoir si la phase est déjà passé.
]]

local STONE_PHASE = {

    --[[ PREND EN COMPTE LE POURCENTAGE DE VIE DU BOSS ]]

    UTILISER_LA_POTION = {
        POURCENTAGE_DE_DECLANCHEMENT = 40,
        DEJA_DECLANCHER = false
    },
    UTILISER_LE_MUR_PROTECTEUR = {
        POURCENTAGE_DE_DECLANCHEMENT = 20,
        DEJA_DECLANCHER = false
    },

    --[[ PREND EN COMPTE LE POURCENTAGE DE VIE DE LA CIBLE ACTUELLE ]]

    UTILISER_LE_BRISE_GENOU = {
        POURCENTAGE_DE_DECLANCHEMENT = 30,
        DEJA_DECLANCHER = false
    }
}

--[[
    Table qui contient la liste de tout les sorts que vas utiliser le boss,
    sorts d'attaque ou de défense.
]]

local STONE_SPELL = {
    CHARGE = 100,
    ETOURDISSEMENT = 5726,
    POURFENDRE = 6546,
    COUP_DE_TONNERRE = 6343,
    BRISE_GENOU = 1715,
    MUR_PROTECTEUR = 871
}

--[[
    Table qui contient les sorts de tout les items que le boss va utiliser,
    on ne peut pas directement utiliser un item, du coup on récupère son sort
    directement dans la base de donnée.
        -->     item_template colonne : spell_id ( ici il y en avais qu'1 pour la potion de soin )
]]

local STONE_SPELL_ITEM = {
    POTION_DE_SOIN_INFERIEURE = 440
} 

--[[
    Function qui nous permet de facilement reset les phases du boss, 
    ainsi que tout les events qui pourraient être en cours
]]

local function ReinitialisationDesPhases(event, stone, ...)
    STONE_PHASE.UTILISER_LA_POTION.DEJA_DECLANCHER = false
    STONE_PHASE.UTILISER_LE_MUR_PROTECTEUR.DEJA_DECLANCHER = false
    STONE_PHASE.UTILISER_LE_BRISE_GENOU.DEJA_DECLANCHER = false

    stone:RemoveEvents()
end

--[[
    Fonction qui est appelée lorsque un combat débute, on commence directement par réinitialiser les phases ( au cas ou ),
    puis ici on regarde si notre cible est dans notre interval voulu pour pouvoir lancer la charge, si oui, alors on charge

    Ensuite on initialise les évènements d'attaques, attaque qui seront répété à interval régulier
]]

local function OnStoneEnterCombat(event, stone, target)
    ReinitialisationDesPhases(event, stone)

    if ( stone:GetDistance(target) > 8 and stone:GetDistance(target) < 25 ) then
        if ( stone:IsWithinLoS(target) ) then
            stone:CastSpell(target, STONE_SPELL.CHARGE, true)
        end
    end

    --[[
        Si on aurait voulu appeler qu'une seule et unique fois une fonction,
        alors on aura du mettre la dernière variable à 1.
        Si on auraita voulu appeler que 4 fois la fonction, on aurait du mettre la variable à 4,
        ainsi de suite..

        Ref. http://elunaluaengine.github.io/WorldObject/RegisterEvent.html
    ]]

    stone:RegisterEvent(CastPourfendre, 10000, 0) -- ici on appelle la fonction 'CastPourfendre' toute les 10 secondes, indéfiniment
    stone:RegisterEvent(CastCoupDeTonnerre, {6000,12000}, 0) -- ici on appelle la fonction 'CastCoupDeTonnerre' entre un intervale de 6 à 12 secondes, indéfiniment
end

--[[
    Fonction qui est appelé via un 'RegisterEvent' (ligne:107), elle nous permet donc de lancer le sort 'Pourfendre'
    défini dans les tables en tout début de fichier, autant de fois que le 'RegisterEvent' l'appelle.
]]
function CastPourfendre(eventid, delay, repeats, stone)
    stone:CastSpell(stone:GetVictim(), STONE_SPELL.POURFENDRE, true)
end

--[[
    Fonction qui est appelé via un 'RegisterEvent' (ligne:108), elle nous permet donc de lancer le sort 'Coup de tonnerre'
    défini dans les tables en tout début de fichier, autant de fois que le 'RegisterEvent' l'appelle.
]]
function CastCoupDeTonnerre(eventid, delay, repeats, stone)
    stone:CastSpell(stone:GetVictim(), STONE_SPELL.COUP_DE_TONNERRE, true)
end

--[[
    Fonction qui est appellé lorsque le boss subit un dégât, on profite de cette fonction
    pour regarder à chaque fois si il est décendu sous un seuil de vie pour pouvoir lancer une phase
]]
local function OnStoneDamageTaken(event, stone, attacker, damage)
    
    --[[
        Phase : UTILISER_LA_POTION
    ]]
    if ( stone:GetHealthPct() < STONE_PHASE.UTILISER_LA_POTION.POURCENTAGE_DE_DECLANCHEMENT and not STONE_PHASE.UTILISER_LA_POTION.DEJA_DECLANCHER ) then

        stone:CastSpell(attacker, STONE_SPELL.ETOURDISSEMENT, true)
        stone:CastSpell(stone, STONE_SPELL_ITEM.POTION_DE_SOIN_INFERIEURE)

        stone:SendUnitSay("Heureuseement que j'ai pensé à prendre une potion !", 0)

        STONE_PHASE.UTILISER_LA_POTION.DEJA_DECLANCHER = true

    end

    --[[
        Phase : UTILISER_LE_MUR_PROTECTEUR
    ]]
    if ( stone:GetHealthPct() < STONE_PHASE.UTILISER_LE_MUR_PROTECTEUR.POURCENTAGE_DE_DECLANCHEMENT and not STONE_PHASE.UTILISER_LE_MUR_PROTECTEUR.DEJA_DECLANCHER ) then
        
        stone:CastSpell(stone, STONE_SPELL.MUR_PROTECTEUR, true)

        STONE_PHASE.UTILISER_LE_MUR_PROTECTEUR.DEJA_DECLANCHER = true

    end
end

--[[
    Fonction qui est appellée lorsque la cible du boss meurt ( le joueur ), permet d'apporter des changements
    au gameplay, et de faire chercher une nouvelle cible au boss ( chose qui fait naturellement, mais autant s'en assurer )
]]
local function OnStoneTargetDied(event, stone, victim)
    -- Réinitialise la phase du brise genou pour pouvoir l'utiliser sur une autre cible si besoin
    STONE_PHASE.UTILISER_LE_BRISE_GENOU.DEJA_DECLANCHER = false
    -- Force le boss à se trouver une nouvelle cible si possible
    stone:SelectVictim()
end

--[[
    Fonction qui est appellée lorsqu'un sort du boss touche une cible, on s'en sert ici pour vérifier si notre cible 
    passe en dessous d'un certain seuil de vie, et donc lancer la phase : UTILISER_LE_BRISE_GENOU
]]
local function OnStoneSpellHitTarget(event, stone, target, spellid)

    --[[
        Phase : UTILISER_LE_BRISE_GENOU
    ]]
    if ( target:GetHealthPct() < STONE_PHASE.UTILISER_LE_BRISE_GENOU.POURCENTAGE_DE_DECLANCHEMENT and not STONE_PHASE.UTILISER_LE_BRISE_GENOU.DEJA_DECLANCHER ) then

        stone:CastSpell(target, STONE_SPELL.BRISE_GENOU, true)

        STONE_PHASE.UTILISER_LE_BRISE_GENOU.DEJA_DECLANCHER = true

    end
end


--[[
    Définition des différents évènements à écouters, lorsque la fonction appeler n'est pas assez clair
    je précise toujours en commentaire à côté de quel évènement il s'agit
]]
RegisterCreatureEvent(STONE_ID, 1, OnStoneEnterCombat)
RegisterCreatureEvent(STONE_ID, 3, OnStoneTargetDied)
RegisterCreatureEvent(STONE_ID, 4, ReinitialisationDesPhases) -- On Died
RegisterCreatureEvent(STONE_ID, 5, ReinitialisationDesPhases) -- On Spawn
RegisterCreatureEvent(STONE_ID, 9, OnStoneDamageTaken)
RegisterCreatureEvent(STONE_ID, 15, OnStoneSpellHitTarget)
RegisterCreatureEvent(STONE_ID, 24, ReinitialisationDesPhases) -- On Reach Home