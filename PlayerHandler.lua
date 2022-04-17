local BuzzieQuest = require(script.Parent.Parent.Services.QuestService)
local DataHandler = require(script.Parent.DataHandler)
local rs = game:GetService("RunService")

game.Players.PlayerAdded:Connect(function(plr)
	
	if rs:IsStudio() then
		-- BUILK TEST --|--
					  --V--
		BuzzieQuest:InitializeQuestData(plr)
		wait(10)
		BuzzieQuest:ApplyQuest(plr, "ExampleQuest", 1)
		wait(2)
		BuzzieQuest:ApplyQuest(plr, "ExampleQuest", 2)
		wait(2)
		BuzzieQuest:ApplyQuest(plr, "ExampleQuest", 3)
		wait(4)
		BuzzieQuest:ApplyQuest(plr, "ExampleQuest", "EndQuest")
	end
	
end)

game.Players.PlayerRemoving:Connect(function(plr) 
	
	BuzzieQuest:TerminateQuestData(plr)
	
end)