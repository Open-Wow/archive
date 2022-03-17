local mod_exp = {
    dbname = 'R1_Eluna',
    max_rate = 5
}


CharDBExecute('CREATE DATABASE IF NOT EXISTS '..mod_exp.dbname)
CharDBExecute('CREATE TABLE IF NOT EXISTS `'..mod_exp.dbname..'`.`characters_exp` ( `guid` INT(10) NOT NULL, `rate` INT(10) NOT NULL DEFAULT 1, PRIMARY KEY (`guid`) );')

-- Nous ajoutons 'mod_exp' devant onLogin pour que notre variable soit local
-- étant donnés que notre tableau 'mod_exp' est lui déjà local cela se "propage"
-- maintenant notre fonction 'onLogin' est une fonction contenu dans le tableau 'mod_exp'
function mod_exp.onLogin(event, player)
    -- Nous stockons le guid du joueur dans une variable
    local pGuid = player:GetGUIDLow()
    -- Nous stockons le résultat de notre requête de recherche des informations
    local getRate = CharDBQuery('SELECT rate FROM `'..mod_exp.dbname..'`.`characters_exp` WHERE guid = '..pGuid)

    -- Si nous n'avons pas de résultant alors
    if not getRate then
        -- Nous insérons une ligne par défaut pour que le joueur ai accés à ses informations
        CharDBExecute('INSERT INTO `'..mod_exp.dbname..'`.`characters_exp` VALUE ('..pGuid..', 1);')
        -- Puis nous allons ajouter 'attachés' une variable à notre objet player qui est le joueur
        -- nous donnons une valeur a cette variable qui seras le multiplicateur d'experience
        player:SetData('exp_modifier', 1)

        -- Sinon (si un résultat ressort)
    else
        -- Nous assignons notre résultant à notre variable
        player:SetData('exp_modifier', getRate:GetUInt32(0))
    end
end
-- Ici nous demandons à Eluna "d'écouter" l'event de connection d'un joueur (c'est le numéro 3)
-- Et lorsque que l'event est "entendu" on lui demande de "joueur" notre fonction
RegisterPlayerEvent(3, mod_exp.onLogin)

function mod_exp.getPlayersInformations(event)
    -- Nous faisons une boucle "for" sur le résultat de la fonction "GetPlayersInWorld" celle-ci nous retourne un tableau
    for _, player in pairs(GetPlayersInWorld()) do
        -- Pour chaque résultat nous envoyons l'objet player à notre fonction "onLogin" afin de remettre en place les informations du joueur
        mod_exp.onLogin(event, player)
    end
    -- Et on envoie un petit message pour dire que le système est allumés
    io.write('Eluna :: Mod_EXP System start \n')
end
RegisterServerEvent(33, mod_exp.getPlayersInformations)

function mod_exp.OnGossipHello(event, player, object)
    -- Nous mettons en place une boucle "for i" qui suivras donc les chiffre de 1 à mod_exp.max_rate (5)
    for i=1, mod_exp.max_rate, 1 do
        -- On affiche donc la sélection sur le menu du PNJ
        player:GossipMenuAddItem(0, "Multiplicateur d'experience x"..i, 1, i)
    end
    -- Cela envoie à notre joueur les informations du gossip.
    -- En l'occurence les sélection possible
    player:GossipSendMenu(1, object)
end
-- Ici le "197" c'est l'entry de votre PNJ
RegisterCreatureGossipEvent(197, 1, mod_exp.OnGossipHello)

function mod_exp.onGossipSelect(event, player, object, sender, intid, code, menuid)
    -- Ici notre traitement est très spéciale, comme nous n'avons que 5 choix qui vont de 1 à 5 nous allons simplement dire que si "intid" vaux quelques chose alors ..
    -- En tant normal il aurais fallut comparer "intid" avec une valeur par exemple "intid == 2" etc.
    -- Mais pour notre modificateur de rates pas besoin
    if intid then
        -- Nous allons attribués la nouvelle valeur de 'exp_modifier' au choix du joueur donc à la valeur de l'intid
        player:SetData('exp_modifier', intid)
        -- Là nous envoyons une notification en jeu pour dire au joueur que sont choix est appliqués
        player:SendNotification('Votre multiplicateur est bien modifiés')
        -- Et on finis par fermer le gossipMenu
        player:GossipComplete()
    end
end
-- Ici le "197" c'est l'entry de votre PNJ
RegisterCreatureGossipEvent(197, 2, mod_exp.onGossipSelect)

function mod_exp.onGiveExp(event, player, amount, victim)
    local pExp = player:GetData('exp_modifier')

    amount = amount * pExp
    return amount
end
RegisterPlayerEvent(12, mod_exp.onGiveExp)

function mod_exp.onLogout(event, player)
    local pGuid = player:GetGUIDLow()
    local pExp = player:GetData('exp_modifier')

    CharDBExecute('UPDATE `'..mod_exp.dbname..'`.`characters_exp` SET rate = '..pExp..' WHERE guid = '..pGuid)
end
RegisterPlayerEvent(2, mod_exp.onLogout)

function mod_exp.setPlayersInformations(event)
    for _, player in pairs(GetPlayersInWorld()) do
        mod_exp.onLogout(event, player)
    end
end
RegisterServerEvent(16, mod_exp.setPlayersInformations)
