localModVersion = "1.0.3";
-- current version for mod.json
-- do not forgot to update mod.json and version.lua if u sync with github !
-- reason: What ever you want to put in..

Events:Subscribe('Player:Chat', function(player, recipientMask, message)
    if message == "!bf4 recon" then
      ChatManager:SendMessage("BF4 Recon mod: Version 1.0.3", player)
    end
end)
