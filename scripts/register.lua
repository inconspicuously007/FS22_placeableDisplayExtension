local modName = g_currentModName or "unknown"

local function validateTypes(typeManager)
	if g_modIsLoaded[modName] and typeManager.typeName == "placeable" then		
		for typeName, typeEntry in pairs(typeManager:getTypes()) do				
			--if typeName == "silo" then
			--	typeManager:addSpecialization(typeName, modName .. ".siloDisplays")
			--end	
			--if typeName == "productionPoint" then
			--	typeManager:addSpecialization(typeName, modName .. ".productionPointDisplays")				
			--end
			--if typeName == "manureHeap" then
			--	typeManager:addSpecialization(typeName, modName .. ".manureHeapDisplays")
			--end	
			--if typeName == "bunkerSilo" then
			--	typeManager:addSpecialization(typeName, modName .. ".bunkerSiloDisplays")
			--end
			--if typeName == "cowHusbandryFeedingRobot" or typeName == "cowHusbandry" or typeName == "chickenHusbandry" or typeName == "horseHusbandry" or typeName == "pigHusbandry" or typeName == "pigHusbandryFeedingRobot" or typeName == "FS22_Departement_Haut_Beyleron.pigHusbandryFeedingRobot" then				
			--	typeManager:addSpecialization(typeName, modName .. ".husbandryDisplays")
			--	printf("typeName: '%s'", typeName)
			--	DebugUtil.printTableRecursively(typeEntry,"_",0,3)
			--end
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
		end
	end
end

local function init()	
	TypeManager.validateTypes = Utils.prependedFunction(TypeManager.validateTypes, validateTypes)
end

init()