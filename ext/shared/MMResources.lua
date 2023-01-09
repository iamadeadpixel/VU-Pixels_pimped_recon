class "MMResources"

function MMResources:__init()
	self.LoadHandlers = {}
	self.MMResources = {}
end

function MMResources:RegisterInstanceLoadHandlers()
	for resourceName, resourceData in pairs(self.MMResources) do
		if (resourceData.Partition and resourceData.Instance) then
			ResourceManager:RegisterInstanceLoadHandler(Guid(resourceData.Partition), Guid(resourceData.Instance), function(instance)
				self:SetLoaded(resourceName, true)
				self:CallLoadHandlers()
			end)
		end
	end
end

 function MMResources:AddLoadHandler(context, callback)
 	table.insert(self.LoadHandlers, { Context = context, Callback = callback })
 end

return MMResources()