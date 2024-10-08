ObjectStorageDisplays = { displays = {} }

function ObjectStorageDisplays.prerequisitesPresent(specializations)
  return SpecializationUtil.hasSpecialization(PlaceableObjectStorage, specializations)
end

function ObjectStorageDisplays.registerEventListeners(placeableType)
  SpecializationUtil.registerEventListener(placeableType, "onLoad", ObjectStorageDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onFinalizePlacement", ObjectStorageDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onPostFinalizePlacement", ObjectStorageDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onDelete", ObjectStorageDisplays)
end

function ObjectStorageDisplays.registerFunctions(placeableType)
	if placeableType.functions["updateDisplayLines"] == nil then
		SpecializationUtil.registerFunction(placeableType, "updateDisplayLines", ObjectStorageDisplays.updateDisplayLines)
	end
	if placeableType.functions["renderDisplayTexts"] == nil then
		SpecializationUtil.registerFunction(placeableType, "renderDisplayTexts", ObjectStorageDisplays.renderDisplayTexts)
	end
	if placeableType.functions["checkRenderDistance"] == nil then
		SpecializationUtil.registerFunction(placeableType, "checkRenderDistance", ObjectStorageDisplays.checkRenderDistance)
	end
end

function ObjectStorageDisplays.registerXMLPaths(schema, basePath)
	schema:setXMLSpecializationType("ObjectStorageDisplays")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#rootNode", "Display root node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#blindNode", "Show something alternative when no display is shown.")
	schema:register(XMLValueType.INT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#farmId", "Display owner farm ID", 1)	
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#font", "Display font name")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#mask", "Display text mask")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#fillLevelAlignment", "Display fillLevel alignment")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#titleAlignment", "Display title alignment")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#capacityAlignment", "Display capacity alignment")
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#size", "Display text size", 0.05)	
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#scaleX", "Display text scaleX", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#scaleY", "Display text scaleY", 1.0)	
	schema:register(XMLValueType.COLOR, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#color", "Display text color", "0.9 0.9 0.9 1")
	schema:register(XMLValueType.COLOR, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#hiddenColor", "Display text hidden color")
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?)#emissiveScale", "Display font name", 1.0)
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillType", "Display fill type mapping")	
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#iconNode", "Display icon node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#titleNode", "Display title node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNode", "Display fill level node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#capacityNode", "Display capacity node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#headLineNode", "Display headline node")	
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineSize", "Display text size for line", 0.05)
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineScaleX", "Display text scaleX for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineScaleY", "Display text scaleY for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineEmissiveScale", "Display text size for line", 1.0)
	schema:register(XMLValueType.COLOR, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineColor", "Display text color for line", "0.9 0.9 0.9 1")
	schema:register(XMLValueType.COLOR, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineHiddenColor", "Display text hidden color for line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineFillLevelAlignment", "Display fillLevel alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineTitleAlignment", "Display title alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineCapacityAlignment", "Display capacity alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineFont", "Display font name for line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineMask", "Display text mask line")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#headLineText", "Display text in headline")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#headLineType", "Display type for headline")
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineTitleTextSize", "Display title text size", 0.05)
	schema:register(XMLValueType.INT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineTitleMaxLen", "Display title text max length", 15)
	schema:register(XMLValueType.FLOAT, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#lineFillLevelTextSize", "Display fill level text size", 0.05)
	
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillWarningNode", "Display node for filllevel of storage for filltype")
	schema:register(XMLValueType.STRING, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillWarningType", "cases to show the fillWarningNode: empty, full or both")	
	
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis0", "Filllevel visual node when lower than 1%")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis25", "Filllevel visual node when lower than 25%")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis50", "Filllevel visual node when between 25% and 50%")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis75", "Filllevel visual node when between 50% and 75%")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis99", "Filllevel visual node when between 75% and 99%")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".objectStorage.ObjectStorageDisplays.display(?).displayLine(?)#fillLevelNodeVis100", "Filllevel visual node when greater or equal than 99%")
	
	schema:setXMLSpecializationType()
end

function ObjectStorageDisplays:onLoad(savegame)
	self.spec_objectStorageDisplays = {}
	local xmlFile = self.xmlFile
	local components = self.components
	local i3dMappings = self.i3dMappings
	local spec = self.spec_objectStorageDisplays
	
	local objectStorageDisplaysKey = "placeable.objectStorage.ObjectStorageDisplays"	
	
	spec.objectStorageDisplayLines = {}
	spec.objectStorageHasDisplays = false
	if xmlFile:hasProperty(objectStorageDisplaysKey) then		 
		xmlFile:iterate(objectStorageDisplaysKey .. ".display", function (_, displayKey)
			local displayNode = xmlFile:getValue(displayKey .. "#rootNode", nil, components, i3dMappings)
			local displayBlindNode = xmlFile:getValue(displayKey .. "#blindNode", nil, components, i3dMappings)
			local displayOwnerFarm = xmlFile:getValue(displayKey .. "#farmId", self:getOwnerFarmId())
			local validFarm = g_farmManager:getFarmById(displayOwnerFarm)			
			
			if displayNode ~= nil then
				local displayRootNodeActive = false
				local displayBlindNodeActive = true
				
				if validFarm ~= nil then										
					displayRootNodeActive = true				
					setVisibility(displayNode, true)
					displayBlindNodeActive = false					
				end
				
				if displayBlindNode ~= nil then
					setVisibility(displayBlindNode, displayBlindNodeActive)					
				end
				
				spec.objectStorageHasDisplays = true
				spec.updateTimer = 0
				spec.initValues = true
				xmlFile:iterate(displayKey .. ".displayLine", function (_, displayLineKey)
					local displayHeadLineText = nil
					local displayHeadlineType = nil
					local lineIconNode = xmlFile:getValue(displayLineKey .. "#iconNode", nil, components, i3dMappings)
					local lineTitleNode = xmlFile:getValue(displayLineKey .. "#titleNode", nil, components, i3dMappings)
					local lineCapacityNode = xmlFile:getValue(displayLineKey .. "#capacityNode", nil, components, i3dMappings)
					local lineFillLevelNode = xmlFile:getValue(displayLineKey .. "#fillLevelNode", nil, components, i3dMappings)
					
					local hasFillLevelNodeVis = false
					local lineFillLevelNodeVis0 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis0", nil, components, i3dMappings)
					local lineFillLevelNodeVis25 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis25", nil, components, i3dMappings)
					local lineFillLevelNodeVis50 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis50", nil, components, i3dMappings)
					local lineFillLevelNodeVis75 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis75", nil, components, i3dMappings)
					local lineFillLevelNodeVis99 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis99", nil, components, i3dMappings)
					local lineFillLevelNodeVis100 = xmlFile:getValue(displayLineKey .. "#fillLevelNodeVis100", nil, components, i3dMappings)
					
					if lineFillLevelNodeVis0 ~= nil or lineFillLevelNodeVis25 ~= nil or lineFillLevelNodeVis50 ~= nil or lineFillLevelNodeVis75 ~= nil or lineFillLevelNodeVis99 ~= nil or lineFillLevelNodeVis100 ~= nil then hasFillLevelNodeVis = true end
					
					local lineHeadLineNode = xmlFile:getValue(displayLineKey .. "#headLineNode", nil, components, i3dMappings)
					local lineSiloFillWarnNode = xmlFile:getValue(displayLineKey .. "#fillWarningNode", nil, components, i3dMappings)					
					local lineSiloFillWarnType = nil	
					
					local lineTextSize = xmlFile:getValue(displayLineKey .. "#lineSize") or xmlFile:getValue(displayKey .. "#size", 0.03)
					local lineTitleTextSize = xmlFile:getValue(displayLineKey .. "#lineTitleTextSize") or lineTextSize
					local lineTitleMaxLen = xmlFile:getValue(displayLineKey .. "#lineTitleMaxLen", 15)
					local lineFillLevelTextSize = xmlFile:getValue(displayLineKey .. "#lineFillLevelTextSize") or lineTextSize
                    local lineTextScaleX = xmlFile:getValue(displayLineKey .. "#lineScaleX") or xmlFile:getValue(displayKey .. "#scaleX", 1)
                    local lineTextScaleY = xmlFile:getValue(displayLineKey .. "#lineScaleY") or xmlFile:getValue(displayKey .. "#scaleY", 1)
                    local lineTextMask = xmlFile:getValue(displayLineKey .. "#lineMask") or xmlFile:getValue(displayKey .. "#mask", "0000000")
                    local lineTextEmissiveScale = xmlFile:getValue(displayLineKey .. "#lineEmissiveScale") or xmlFile:getValue(displayKey .. "#emissiveScale", 0.2)
                    local lineTextColor = xmlFile:getValue(displayLineKey .. "#lineColor", nil, true) or xmlFile:getValue(displayKey .. "#color", {0.9, 0.9, 0.9, 1}, true)					
                    local lineTextHiddenColor = xmlFile:getValue(displayLineKey .. "#lineHiddenColor", nil, true) or xmlFile:getValue(displayKey .. "#hiddenColor", nil, true)					
					local lineFontName = xmlFile:getValue(displayLineKey .. "#lineFont") or xmlFile:getValue(displayKey .. "#font", "digit")
					
					local lineFontMaterial = g_materialManager:getFontMaterial(lineFontName:upper(), self.customEnvironment)
					
					if lineHeadLineNode ~= nil then
						lineFontMaterial = g_materialManager:getFontMaterial("GENERIC", self.customEnvironment)
						local lineHeadlineText = xmlFile:getValue(displayLineKey .. "#headLineText")
						local lineHeadlineType = xmlFile:getValue(displayLineKey .. "#headLineType")
						if lineHeadlineType ~= nil and (lineHeadlineType == "farmName" or lineHeadlineType == "placeableName") then
							displayHeadlineType = lineHeadlineType
						end
						if lineHeadlineText ~= nil and displayHeadlineType == nil then
							--displayHeadLineText = lineHeadlineText
							local custEnv = self.spec_objectStorage.customEnvironment or nil --checking							
							displayHeadLineText = g_i18n:convertText(lineHeadlineText, custEnv)							
						end
					end
					
					lineFontMaterial.setFontCharacter = function(_, node, targetCharacter, color, hiddenColor)
						if node ~= nil then
							if hiddenColor ~= nil then
								if targetCharacter == " " then
									targetCharacter = "0"

									lineFontMaterial:setFontCharacterColor(node, hiddenColor[1], hiddenColor[2], hiddenColor[3], hiddenColor[4] or 1)
								else
									lineFontMaterial:setFontCharacterColor(node, color[1], color[2], color[3], color[4] or 1)
								end
							end

							local foundCharacter = nil

							for i = 1, #lineFontMaterial.characters do
								local character = lineFontMaterial.characters[i]

								if character.value == targetCharacter then
									foundCharacter = character

									break
								end
							end

							if foundCharacter == nil then
								for i = 1, #lineFontMaterial.characters do
									local character = lineFontMaterial.characters[i]

									if character.value:lower() == targetCharacter:lower() then
										foundCharacter = character

										break
									end
								end
							end

							if foundCharacter ~= nil then
								setVisibility(node, true)
								setClipDistance(node, 500)
								setShaderParameter(node, "index", foundCharacter.uvIndex, 0, 0, 0, false)
								setShaderParameter(node, "spacing", foundCharacter.spacingX or lineFontMaterial.spacingX, foundCharacter.spacingY or lineFontMaterial.spacingY, 0, 0, false)
							else
								setVisibility(node, false)
							end

							return foundCharacter
						end
					end	
					
					lineFontMaterial.createCharacterLine = function(_, linkNode, numChars, textSize, textColor, hiddenColor, textEmissiveScale, scaleX, scaleY, textAlignment, hiddenAlpha, fontThickness)
						if lineFontMaterial.characterShape ~= nil then
							local characterLine = {
								characters = {},
								textSize = textSize or 1,
								scaleX = scaleX or 1,
								scaleY = scaleY or 1,
								textAlignment = textAlignment or RenderText.ALIGN_RIGHT,
								fontThickness = ((fontThickness or 1) - 1) / 8 + 1,
								textColor = textColor,
								hiddenColor = hiddenColor,
								textEmissiveScale = textEmissiveScale or 0,
								hiddenAlpha = hiddenAlpha or 0,
								rootNode = createTransformGroup("characterLine")
							}

							link(linkNode, characterLine.rootNode)

							for i = 1, numChars do
								local char = clone(lineFontMaterial.characterShape, false, false, false)

								link(characterLine.rootNode, char)
								lineFontMaterial:assignFontMaterialToNode(char)
								setShaderParameter(char, "alphaErosion", 1 - characterLine.fontThickness, 0, 0, 0, false)

								local r, g, b = nil

								if characterLine.textColor ~= nil then
									a = characterLine.textColor[4]
									b = characterLine.textColor[3]
									g = characterLine.textColor[2]
									r = characterLine.textColor[1]
								end

								lineFontMaterial:setFontCharacterColor(char, r, g, b, a, characterLine.textEmissiveScale)
								table.insert(characterLine.characters, char)
							end

							lineFontMaterial:updateCharacterLine(characterLine, "")

							return characterLine
						else
							Logging.error("Could not create characters from font '%s'. No source character mesh found!", lineFontMaterial.name)
						end
					end					
					
					local lineFillTypeName = xmlFile:getString(displayLineKey .. "#fillType", nil)					
					local lineFillType = nil
					local lineFillTypeTitle = nil
					if lineFillTypeName ~= nil then
						lineFillType = g_fillTypeManager:getFillTypeByName(lineFillTypeName)
						if lineFillType == nil then Logging.error("Could not find fillType for given name '%s'!", lineFillTypeName) end
						if lineFillType ~= nil then
							lineFillTypeTitle = lineFillType.title
							if lineTitleMaxLen~= nil and lineTitleMaxLen > 1 and utf8Strlen(lineFillTypeTitle) > lineTitleMaxLen then
								lineFillTypeTitle = utf8Substr(lineFillTypeTitle, 0, lineTitleMaxLen - 3) .. "..."
							end
						end
					end
					
					if lineSiloFillWarnNode ~= nil then
						local warnType = xmlFile:getValue(displayLineKey .. "#fillWarningType", nil)
						if warnType ~= nil and (warnType == "empty" or warnType == "full" or warnType == "both") then
							if warnType == "empty" then
								lineSiloFillWarnType = 0
							elseif warnType	== "full" then 
								lineSiloFillWarnType = 1
							elseif warnType == "both" then
								lineSiloFillWarnType = 3
							end
						end
					end
					
					
					local displayLine = {
						fillLevelNode = lineFillLevelNode,
						fillLevelNodeVis0 = lineFillLevelNodeVis0,
						fillLevelNodeVis25 = lineFillLevelNodeVis25,
						fillLevelNodeVis50 = lineFillLevelNodeVis50,
						fillLevelNodeVis75 = lineFillLevelNodeVis75,
						fillLevelNodeVis99 = lineFillLevelNodeVis99,
						fillLevelNodeVis100 = lineFillLevelNodeVis100,
						hasFillLevelNodeVis = hasFillLevelNodeVis,
                        capacityNode = lineCapacityNode,                        
                        titleNode = lineTitleNode,
						headLineNode = lineHeadLineNode,
						fontMaterial = lineFontMaterial,
						iconNode = lineIconNode,
						emissiveScale = lineTextEmissiveScale,
						hiddenColor = lineTextHiddenColor,
						color = lineTextColor,
						fillLevelAlignment = RenderText["ALIGN_" .. xmlFile:getValue(displayLineKey .. "#lineFillLevelAlignment", ""):upper()] or RenderText["ALIGN_" .. xmlFile:getValue(displayKey .. "#fillLevelAlignment", ""):upper()] or RenderText.ALIGN_RIGHT,
						capacityAlignment = RenderText["ALIGN_" .. xmlFile:getValue(displayLineKey .. "#lineCapacityAlignment", ""):upper()] or RenderText["ALIGN_" .. xmlFile:getValue(displayKey .. "#capacityAlignment", ""):upper()] or RenderText.ALIGN_RIGHT,
						titleAlignment = RenderText["ALIGN_" .. xmlFile:getValue(displayLineKey .. "#lineTitleAlignment", ""):upper()] or RenderText["ALIGN_" .. xmlFile:getValue(displayKey .. "#titleAlignment", ""):upper()] or RenderText.ALIGN_LEFT,
						textSize = lineTextSize,
						titleTextSize = lineTitleTextSize,
						titleMaxLength = lineTitleMaxLen,
						fillLevelTextSize = lineFillLevelTextSize,
						fillType = lineFillType,
						fillTypeTitle = lineFillTypeTitle,
						farmId = displayOwnerFarm,
						scaleX = lineTextScaleX,
						scaleY = lineTextScaleY,
						headLineText = displayHeadLineText,
						headLineType = displayHeadlineType,
						mask = lineTextMask,
						rootNode = displayNode,
						rootNodeActive = displayRootNodeActive,
						blindNode = displayBlindNode,
						blindNodeActive = displayBlindNodeActive,
						siloFillWarnNode = lineSiloFillWarnNode,
						siloFillWarnType = lineSiloFillWarnType
                    }
					
					displayLine.maskFormatStr, displayLine.maskFormatPrecision = string.maskToFormat(lineTextMask)
					displayLine.fillLevelCharacterLine = nil
					displayLine.titleCharacterLine = nil
					displayLine.capacityCharacterLine = nil
					displayLine.headLineCharacterLine = nil
					
					if displayLine.iconNode ~= nil and displayLine.fillType ~= nil then
						setVisibility(displayLine.iconNode, false)
						--TODO--
						--local iconMaterial = g_materialManager:getMaterial(displayLine.fillType.index, "icon", 1)
						--print("Debug: displayLine.fillType")
						--DebugUtil.printTableRecursively(displayLine.fillType,"_",0,3)
						--print("Debug: g_materialManager")
						--DebugUtil.printTableRecursively(g_materialManager,"_",0,3)
						--if iconMaterial ~= nil then
						--	setMaterial(displayLine.iconNode, iconMaterial, 0)
						--	local iconColorVector = StringUtil.getVectorNFromString({0.8, 0.8, 0.8, 1}, 4)
						--	if iconColorVector ~= nil then
						--		setShaderParameter(slot.icon.node, "iconColor", iconColorVector[1], iconColorVector[2], iconColorVector[3], iconColorVector[4] or 1, false)
						--		setVisibility(displayLine.iconNode, true)
						--	end
						--	
						--end
					end
					
					if displayLine.fillLevelNode ~= nil and displayLine.fillType ~= nil then						
						displayLine.fillLevelCharacterLine = lineFontMaterial:createCharacterLine(displayLine.fillLevelNode, lineTextMask:len(), displayLine.fillLevelTextSize, displayLine.color, displayLine.hiddenColor, displayLine.emissiveScale, displayLine.scaleX, displayLine.scaleY, displayLine.textAlignment)						
					end
					if displayLine.capacityNode ~= nil then
						displayLine.capacityCharacterLine = lineFontMaterial:createCharacterLine(displayLine.capacityNode, lineTextMask:len(), displayLine.textSize, displayLine.color, displayLine.hiddenColor, displayLine.emissiveScale, displayLine.scaleX, displayLine.scaleY, displayLine.capacityAlignment)						
					end
					table.insert(spec.objectStorageDisplayLines, displayLine)					
				end)
			end
		end)		
	end
end

function ObjectStorageDisplays:onFinalizePlacement(savegame)
	local spec = self.spec_objectStorageDisplays
	if spec.objectStorageHasDisplays then
	print("Debug: self.spec_objectStorageDisplays")
	--local speco = self.spec_objectStorage
	--local numObjects = self.spec_objectStorage.numStoredObjects or 0
	--	printf("numObjects: '%s'", numObjects)
	--local numObjectInfos = #self.spec_objectStorage.objectInfos
	--	printf("numObjectInfos: '%s'", numObjectInfos)
	--if numObjects >= 1 then
		
		DebugUtil.printTableRecursively(self.spec_objectStorage,"_",0,3)
	--end
	
		--function spec.fillLevelChangedCallback(fillType, delta)
		--	self:updateDisplayLines(false, fillType)
		--end
		--for _, sourceStorage in pairs(self.spec_silo.loadingStation:getSourceStorages()) do				
		--	sourceStorage:addFillLevelChangedListeners(spec.fillLevelChangedCallback)
		--end			
	end
end

function ObjectStorageDisplays:onPostFinalizePlacement(savegame)	
	local spec = self.spec_objectStorageDisplays
	if spec.objectStorageHasDisplays then		
		table.insert(ObjectStorageDisplays.displays, self)		
		self:updateDisplayLines(true, nil)
	end		
end

function ObjectStorageDisplays:onDelete()
    table.removeElement(ObjectStorageDisplays.displays, self)
end

function ObjectStorageDisplays:update(dt)		
	for _, objectStorageDisplay in pairs(ObjectStorageDisplays.displays) do	        
		objectStorageDisplay:renderDisplayTexts()			
    end
end

function ObjectStorageDisplays:checkRenderDistance(node)
	local viewPositionNode = nil
	local viewX, viewY, viewZ = 0, 0, 0				
	local nodeX, nodeY, nodeZ = 0, 0, 0
	local distance = 1000000
	if g_currentMission.controlPlayer ~= nil then
		viewPositionNode = g_currentMission.player.rootNode
	end
	if g_currentMission.controlledVehicle ~= nil then
		viewPositionNode = g_currentMission.controlledVehicle.rootNode
	end				
	
	if viewPositionNode ~= nil and node ~= nil then 
		viewX, viewY, viewZ = getWorldTranslation(viewPositionNode)
		nodeX, nodeY, nodeZ = getWorldTranslation(node)	
		distance = MathUtil.vector2Length(viewX - nodeX, viewZ - nodeZ)
	end
	return distance
	
end

function ObjectStorageDisplays:renderDisplayTexts()	
	if g_dedicatedServer == nil then
		for index, displayLine in pairs(self.spec_objectStorageDisplays.objectStorageDisplayLines) do
			local checkRenderDistance = self:checkRenderDistance(displayLine.rootNode)
			if checkRenderDistance < 100 then
				local initValues = false
				local validFarm = g_farmManager:getFarmById(displayLine.farmId)
				if displayLine.rootNodeActive == false and validFarm ~= nil then								
					self.spec_objectStorageDisplays.objectStorageDisplayLines[index].rootNodeActive = true
					self.spec_objectStorageDisplays.objectStorageDisplayLines[index].blindNodeActive = false
					displayLine.rootNodeActive = true
					displayLine.blindNodeActive = false
					initValues = true	
				end
				if displayLine.rootNodeActive == true and validFarm == nil then				 								
					self.spec_ObjectStorageDisplays.objectStorageDisplayLines[index].rootNodeActive = false
					self.spec_ObjectStorageDisplays.objectStorageDisplayLines[index].blindNodeActive = true
					displayLine.rootNodeActive = false
					displayLine.blindNodeActive = true
				end
				
				setVisibility(displayLine.rootNode, displayLine.rootNodeActive)
				
				if displayLine.blindNode ~= nil then
					setVisibility(displayLine.blindNode, displayLine.blindNodeActive)				
				end
				
				if displayLine.rootNodeActive == true then				
					local transX, transY, transZ = 0, 0, 0
					local rotX, rotY, rotZ = 0, 0, 0
					local rendTxt = ""
					local rendTxtSize = displayLine.textSize
					if displayLine.headLineNode ~= nil then					
						transX, transY, transZ = getWorldTranslation(displayLine.headLineNode)
						rotX, rotY, rotZ = getWorldRotation(displayLine.headLineNode)												
						rendTxt = displayLine.headLineText						
						if displayLine.headLineType ~= nil then
							if displayLine.headLineType == "farmName" and validFarm ~= nil then
								rendTxt = validFarm.name
							elseif displayLine.headLineType == "placeableName" then
								rendTxt = self.spec_objectStorage:getName()
							end
						end
					end
					if displayLine.titleNode ~= nil and displayLine.fillType ~= nil then
						transX, transY, transZ = getWorldTranslation(displayLine.titleNode)
						rotX, rotY, rotZ = getWorldRotation(displayLine.titleNode)					
						--rendTxt = displayLine.fillType.title
						rendTxtSize = displayLine.titleTextSize
						--if displayLine.titleMaxLength~= nil and displayLine.titleMaxLength > 1 and utf8Strlen(rendTxt) > displayLine.titleMaxLength then
						--	rendTxt = utf8Substr(rendTxt, 0, displayLine.titleMaxLength - 3) .. "..."
						--end
						rendTxt = displayLine.fillTypeTitle
					end
					if rendTxt ~= nil then						
						setTextVerticalAlignment(RenderText.VERTICAL_ALIGN_BASELINE)
						setTextColor(displayLine.color[1], displayLine.color[2], displayLine.color[3], displayLine.color[4])
						setTextAlignment(displayLine.titleAlignment)			
						renderText3D(transX, transY, transZ, rotX, rotY, rotZ, rendTxtSize, rendTxt)
					end					
					if initValues == true then self:updateDisplayLines(true, nil) end
				end
				if self.spec_objectStorageDisplays.initValues ~= nil and self.spec_objectStorageDisplays.initValues == true then
					self:updateDisplayLines(true, nil)
					self.spec_objectStorageDisplays.initValues = false 
				end	
			end
		end				
	end
end

function ObjectStorageDisplays:updateDisplayLines(initial, fillTypeIndex)
	if g_dedicatedServer == nil then
		local numObjects = self.spec_objectStorage.numStoredObjects
		local objectsByFillType = {}
		for index, objectStored in pairs(self.spec_objectStorage.storedObjects) do			
			--pallets
			if self.spec_objectStorage.supportsPallets == true and objectStored.palletAttributes ~= nil then
				local objectFillType = objectStored.palletAttributes.fillType				
				if objectsByFillType[objectFillType] == nil then 
					objectsByFillType[objectFillType] = 0 
				end
				objectsByFillType[objectFillType] = objectsByFillType[objectFillType] + 1
			end
			--bales
			if self.spec_objectStorage.supportsBales == true and objectStored.baleAttributes ~= nil then
				local objectFillType = objectStored.baleAttributes.fillType				
				if objectsByFillType[objectFillType] == nil then 
					objectsByFillType[objectFillType] = 0 
				end
				objectsByFillType[objectFillType] = objectsByFillType[objectFillType] + 1
			end
		end
		for index, displayLine in pairs(self.spec_objectStorageDisplays.objectStorageDisplayLines) do
			local check = false
			if initial ~= nil and initial == false and fillTypeIndex ~= nil and displayLine.fillType ~= nil and displayLine.fillType.index ~= nil and fillTypeIndex == displayLine.fillType.index then check = true end
			if initial ~= nil and initial == true then check = true end
			if displayLine.rootNodeActive == true and check == true then
				local fillLevel = 0
				local intFill = 0 
				local floatPartFill = 0
				local fillLevelValue = 0 
				local freeCapacity = 0 
				local capacity = self.spec_objectStorage.capacity or 0
				
				if displayLine.fillType ~= nil and displayLine.fillType.index ~= nil then
					--fillLevel = self.spec_silo.loadingStation:getFillLevel(displayLine.fillType.index, displayLine.farmId) or 0							
					fillLevel = objectsByFillType[displayLine.fillType.index] or 0
					intFill, floatPartFill = math.modf(fillLevel)					
				end
				
				if displayLine.fillLevelCharacterLine ~= nil then									
					fillLevelValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intFill))
					displayLine.fontMaterial:updateCharacterLine(displayLine.fillLevelCharacterLine, fillLevelValue)						
				end				
				
				if (displayLine.siloFillWarnNode ~= nil and displayLine.siloFillWarnType ~= nil) or displayLine.hasFillLevelNodeVis == true then						
					freeCapacity = capacity - intFill						
					if displayLine.hasFillLevelNodeVis ~= nil and displayLine.hasFillLevelNodeVis == true then
						local fillLevelVisValue = 0
						if intFill > 0 then
							fillLevelVisValue = (100 * intFill) / (fillLevel + freeCapacity)							
						end					
						
						if displayLine.fillLevelNodeVis0 ~= nil then setVisibility(displayLine.fillLevelNodeVis0, false) end
						if displayLine.fillLevelNodeVis25 ~= nil then setVisibility(displayLine.fillLevelNodeVis25, false) end
						if displayLine.fillLevelNodeVis50 ~= nil then setVisibility(displayLine.fillLevelNodeVis50, false) end
						if displayLine.fillLevelNodeVis75 ~= nil then setVisibility(displayLine.fillLevelNodeVis75, false) end							
						if displayLine.fillLevelNodeVis99 ~= nil then setVisibility(displayLine.fillLevelNodeVis99, false) end							
						if displayLine.fillLevelNodeVis100 ~= nil then setVisibility(displayLine.fillLevelNodeVis100, false) end
						
						if displayLine.fillLevelNodeVis0 ~= nil and fillLevelVisValue <= 1 then setVisibility(displayLine.fillLevelNodeVis0, true)
						elseif displayLine.fillLevelNodeVis100 ~= nil and fillLevelVisValue >= 99 then setVisibility(displayLine.fillLevelNodeVis100, true)
						elseif displayLine.fillLevelNodeVis25 ~= nil and fillLevelVisValue > 1 and fillLevelVisValue < 25  then setVisibility(displayLine.fillLevelNodeVis25, true)
						elseif displayLine.fillLevelNodeVis50 ~= nil and fillLevelVisValue >= 25 and fillLevelVisValue < 50  then setVisibility(displayLine.fillLevelNodeVis50, true)
						elseif displayLine.fillLevelNodeVis75 ~= nil and fillLevelVisValue >= 50 and fillLevelVisValue < 75  then setVisibility(displayLine.fillLevelNodeVis75, true)
						elseif displayLine.fillLevelNodeVis99 ~= nil and fillLevelVisValue >= 75 and fillLevelVisValue < 99  then setVisibility(displayLine.fillLevelNodeVis99, true)
						end
						
						--if displayLine.fillLevelNodeVis25 ~= nil and fillLevelVisValue < 25 then setVisibility(displayLine.fillLevelNodeVis25, true) 
						--elseif displayLine.fillLevelNodeVis50 ~= nil and fillLevelVisValue >= 25 and fillLevelVisValue < 50 then setVisibility(displayLine.fillLevelNodeVis50, true)
						--elseif displayLine.fillLevelNodeVis75 ~= nil and fillLevelVisValue >= 50 and fillLevelVisValue < 75 then setVisibility(displayLine.fillLevelNodeVis75, true)
						--elseif displayLine.fillLevelNodeVis100 ~= nil and fillLevelVisValue >= 75 and fillLevelVisValue <= 100 then setVisibility(displayLine.fillLevelNodeVis100, true)
						--end							
					end
					
					if displayLine.siloFillWarnNode ~= nil and displayLine.siloFillWarnType ~= nil then						
						local statWarn = false
						if intFill < 10 and (displayLine.siloFillWarnType == 0 or displayLine.siloFillWarnType == 3) then
							statWarn = true	
							--if displayLine.fillLevelNodeVis25 ~= nil then setVisibility(displayLine.fillLevelNodeVis25, false) end	
						end
						if freeCapacity < 10 and (displayLine.siloFillWarnType == 1 or displayLine.siloFillWarnType == 3) then
							statWarn = true								
							--if displayLine.fillLevelNodeVis100 ~= nil then setVisibility(displayLine.fillLevelNodeVis100, false) end
						end							
						setVisibility(displayLine.siloFillWarnNode, statWarn)
					end						
				end
				
				if displayLine.capacityCharacterLine ~= nil then					
					local intCap, floatPartCap = math.modf(capacity)				
					local capacityValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intCap))
					displayLine.fontMaterial:updateCharacterLine(displayLine.capacityCharacterLine, capacityValue)
				end
			end		
		end
	end
end

function ObjectStorageDisplays:addAbstactObjectToObjectStorage(superFunc, object, loadedFromSavegame)
	local spec = self.spec_objectStorageDisplays
	if spec.objectStorageHasDisplays then
		self:updateDisplayLines(true, nil)
	end
end
function ObjectStorageDisplays:removeAbstractObjectsFromStorage(superFunc, objectInfoIndex, amount, connection)
	local spec = self.spec_objectStorageDisplays
	if spec.objectStorageHasDisplays then
		self:updateDisplayLines(true, nil)
	end
end
function ObjectStorageDisplays:removeAbstractObjectFromStorage(superFunc, abstractObject, x, y, z, rx, ry, rz)
	local spec = self.spec_objectStorageDisplays
	if spec.objectStorageHasDisplays then
		self:updateDisplayLines(true, nil)
	end
end

addModEventListener(ObjectStorageDisplays)

PlaceableObjectStorage.addAbstactObjectToObjectStorage = Utils.appendedFunction(PlaceableObjectStorage.addAbstactObjectToObjectStorage, ObjectStorageDisplays.addAbstactObjectToObjectStorage)
PlaceableObjectStorage.removeAbstractObjectsFromStorage = Utils.appendedFunction(PlaceableObjectStorage.removeAbstractObjectsFromStorage, ObjectStorageDisplays.removeAbstractObjectsFromStorage)
PlaceableObjectStorage.removeAbstractObjectFromStorage = Utils.appendedFunction(PlaceableObjectStorage.removeAbstractObjectFromStorage, ObjectStorageDisplays.removeAbstractObjectFromStorage)
