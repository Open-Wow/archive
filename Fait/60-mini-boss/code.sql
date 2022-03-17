SET
@CreatureID = 45000,
@Text = "Que trépasse si je faiblis !",
@comment = "Boos Tutoriel";

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@CreatureID, '0', '0', @Text, '12', '0', '100', '0', '0', '0', '0', '0', @comment);