local modName = g_currentModName or "unknown"

local function validateTypes(typeManager)
	if g_modIsLoaded[modName] and typeManager.typeName == "placeable" then		
		for typeName, typeEntry in pairs(typeManager:getTypes()) do				
			if typeEntry.specializationsByName["silo"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".siloDisplays")
			end
			if typeEntry.specializationsByName["productionPoint"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".productionPointDisplays")
			end
			if typeEntry.specializationsByName["manureHeap"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".manureHeapDisplays")
			end
			if typeEntry.specializationsByName["bunkerSilo"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".bunkerSiloDisplays")
			end
			if typeEntry.specializationsByName["husbandry"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".husbandryDisplays")
			end
			if typeEntry.specializationsByName["objectStorage"] ~= nil then
				typeManager:addSpecialization(typeName, modName .. ".objectStorageDisplays")
			end
		end
	end
end

local function init()	
	if g_modIsLoaded.FS22_advancedProductionInfoFunctions then	
		printf("Found FS22_advancedProductionInfoFunctions. Skipping registration in '%s'.", modName)
	else
		TypeManager.validateTypes = Utils.prependedFunction(TypeManager.validateTypes, validateTypes)
	end	
end

init()