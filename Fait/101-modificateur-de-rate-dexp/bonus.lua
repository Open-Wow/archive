function mod_exp.OnGossipHello(event, player, object)
    -- Nous ajouton un texte customisés, celui ci ne fonctionne qu'avec l'extension GossipTextExtension
    local pName = player:GetName()
    local pExp = player:GetData('exp_modifier')

    player:GossipSetText("Salutation "..pName..",\nJe suis capable de modifier votre multiplicateur d'experience.\n\nVotre mutliplicateur actuel est à "..pExp.."\n\n")

    -- Nous mettons en place une boucle "for i" qui suivras donc les chiffre de 1 à mod_exp.max_rate (5)
    for i=1, mod_exp.max_rate, 1 do
        -- On affiche donc la sélection sur le menu du PNJ
        player:GossipMenuAddItem(0, "Multiplicateur d'experience x"..i, 1, i)
    end
    -- Cela envoie à notre joueur les informations du gossip.
    -- En l'occurence les sélection possible
    player:GossipSendMenu(0x7FFFFFFF, object)
end
-- Ici le "197" c'est l'entry de votre PNJ
RegisterCreatureGossipEvent(197, 1, mod_exp.OnGossipHello)
