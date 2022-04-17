

local module = {}


local ProfileTemplate = {
	CurrentQuest = script.Parent.Parent.Services.QuestService.Quests.StartingQuest.Value,
	CurrentStage = 1,
}

local ProfileService = require(game.ServerScriptService.Services.ProfileService)

local Players = game:GetService("Players")


local ProfileStore = ProfileService.GetProfileStore(
	"PlayerData",
	ProfileTemplate
)

local Profiles = {}

function module.GatherPlayerData(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId) -- Add user to Datastore 2 (if not already in the datastore)+
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
		profile:ListenToRelease(function()
			Profiles[player] = nil
			-- The profile could've been loaded on another Roblox server
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			Profiles[player] = profile
			-- Profile loaded!
		else
			-- Player has left the game before profile has loaded
			profile:Release()
		end
	else
		-- Profile couldn't be loaded, possibly due to other game servers trying to load the profile at the same time.
		player:Kick() 
		-- Kicks player
	end
	return profile.Data;
end


function module.SavePlayerData(player)
	local profile = Profiles[player]
	if profile ~= nil then
		profile:Reconcile()
		profile:Release()
	end
end

function module.GetData(player)
	print(Profiles[player])
	return Profiles[player].Data;
end


function module.SetData(player, data, value)
	Profiles[player].Data[data] = value
end


return module;
