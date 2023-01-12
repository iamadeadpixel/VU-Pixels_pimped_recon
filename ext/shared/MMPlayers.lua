class "MMPlayers"

function MMPlayers:__init()
	Events:Subscribe('Level:Loaded', self, self.onLevelLoaded)
end

function MMPlayers:Write(mmResources)
end

function MMPlayers:onLevelLoaded(levelName, gameMode)

	local kitSetups = {
		US = {
			Assault = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
			Engineer = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
			Recon = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {
					'Weapons/Gadgets/Medicbag/U_Medkit',
					'Weapons/Gadgets/Ammobag/U_Ammobag'
				},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {
					'Weapons/SMAW/U_SMAW',
					'Weapons/Gadgets/C4/U_C4',
					'Weapons/Gadgets/Claymore/U_Claymore'
				},
				GRENADE = {},
				KNIFE = {}
			},
			Support = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
		},
		RU = {
			Assault = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
			Engineer = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
			Recon = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {
					'Weapons/Gadgets/Medicbag/U_Medkit',
					'Weapons/Gadgets/Ammobag/U_Ammobag'
				},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {
					'Weapons/RPG7/U_RPG7',
					'Weapons/Gadgets/C4/U_C4',
					'Weapons/Gadgets/Claymore/U_Claymore'
				},
				GRENADE = {},
				KNIFE = {}
			},
			Support = {
				ID_M_SOLDIER_PRIMARY = {},
				ID_M_SOLDIER_SECONDARY = {},
				ID_M_SOLDIER_GADGET1 = {},
				ID_WEAPON_CATEGORYGADGET1 = {},
				ID_M_SOLDIER_GADGET2 = {},
				GRENADE = {},
				KNIFE = {}
			},
		}
	}

	for teamName, team in pairs(kitSetups) do
		for kitName, kit in pairs(team) do
			if (kitName ~= '*') then
				local kitData = self:findKit(teamName, kitName, true)
				for i=1, #kitData do

					local unlockCategories = ebxEditUtils:GetWritableContainer(kitData[i][1], 'WeaponTable')
					local specialsDone = false
					local newUnlockCategories = {}

					for categoryId, weapons in pairs(kit) do

						local categoryIndex = self:CategoryIdToIndex(categoryId)
						local unlockCategory = unlockCategories.unlockParts[categoryIndex]
						unlockCategory:MakeWritable()

						for weapon=1, #weapons do
							unlockCategory.selectableUnlocks:add(ebxEditUtils:GetWritableInstance(weapons[weapon]))
							print('Adding ['..tostring(categoryId)..']: '..weapons[weapon])
						end
					end

					print('Changed Kit: '..teamName..' - '..kitName)
				end
			end
		end
	end
end

--

function MMPlayers:CategoryIdToIndex(categoryId)

	if (categoryId == 'ID_M_SOLDIER_PRIMARY') then
		return 1
	elseif (categoryId == 'ID_M_SOLDIER_SECONDARY') then
		return 2
	elseif (categoryId == 'ID_M_SOLDIER_GADGET1') then
		return 3
	elseif (categoryId == 'ID_WEAPON_CATEGORYGADGET1' or categoryId == 'GADGET1') then
		return 5
	elseif (categoryId == 'ID_M_SOLDIER_GADGET2') then
		return 6
	elseif (categoryId == 'GRENADE') then
		return 7
	elseif (categoryId == 'KNIFE') then
		return 8
	end
	return 4
end

-- Tries to find first available kit
-- @param teamName string Values: 'US', 'RU'
-- @param kitName string Values: 'Assault', 'Engineer', 'Support', 'Recon'
-- @param returnAll boolean returns all matches
function MMPlayers:findKit(teamName, kitName, returnAll)

    local gameModeKits = {
        '', -- Standard
        '_GM', --Gun Master on XP2 Maps
        '_GM_XP4', -- Gun Master on XP4 Maps
        '_XP4', -- Copy of Standard for XP4 Maps
        '_XP4_SCV' -- Scavenger on XP4 Maps
    }

    local matches = {}

    for kitType=1, #gameModeKits do
        local properKitName = string.lower(kitName)
        properKitName = properKitName:gsub("%a", string.upper, 1)

        local fullKitName = string.upper(teamName)..properKitName..gameModeKits[kitType]
        local kit = ResourceManager:SearchForDataContainer('Gameplay/Kits/'..fullKitName)
        if kit ~= nil  then
        	print('Found Kit: '..fullKitName)
            table.insert(matches, {kit, gameModeKits[kitType]})
            if (not returnAll) then
        		return {kit, gameModeKits[kitType]}
        	end
        end
    end

    return matches
end

return MMPlayers()
