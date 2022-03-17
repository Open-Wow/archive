SET
@SourceTypeOrReferenceId := 15,
@SourceGroup := 435,
@SourceEntry := 1,
@ConditionTypeOrReference := 2,
@ConditionTarget := 0,
@ConditionValue1 := 6948,
@ConditionValue2 := 1,
@ConditionValue3 := 1,
@NegativeCondition := 1,
@Comment := 'Tant que le joueur a sa pierre de foyer il ne peu voir la ligne 1 du gossip 6948';

INSERT INTO `conditions` VALUES(@SourceTypeOrReferenceId,@SourceGroup,@SourceEntry,'0','0',@ConditionTypeOrReference,@ConditionTarget,@ConditionValue1,@ConditionValue2,@ConditionValue3,@NegativeCondition,'0','0','',@Comment);