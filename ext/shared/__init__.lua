-- Check if there is a new version
--require('__shared/UpdateCheck')  

-- global funcs and utils
Utils = require('__shared/Utils')
ebxEditUtils = require('__shared/EbxEditUtils')

-- load resource list
mmResources = require('__shared/MMResources')

-- modules
mmPlayers1 = require('__shared/MMPlayers1')
mmPlayers2 = require('__shared/MMPlayers2')

mmResources:AddLoadHandler(mmPlayers1, mmPlayers1.Write)
mmResources:AddLoadHandler(mmPlayers2, mmPlayers2.Write)
mmResources:RegisterInstanceLoadHandlers()

