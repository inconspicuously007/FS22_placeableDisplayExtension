HusbandryDisplays = { displays = {} }

function HusbandryDisplays.prerequisitesPresent(specializations)
  return SpecializationUtil.hasSpecialization(PlaceableHusbandry, specializations)  
end

function HusbandryDisplays.registerEventListeners(placeableType)
  SpecializationUtil.registerEventListener(placeableType, "onLoad", HusbandryDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onFinalizePlacement", HusbandryDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onPostFinalizePlacement", HusbandryDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onDelete", HusbandryDisplays)
end

function HusbandryDisplays.registerFunctions(placeableType)
	if placeableType.functions["updateDisplayLines"] == nil then
		SpecializationUtil.registerFunction(placeableType, "updateDisplayLines", HusbandryDisplays.updateDisplayLines)
	end
	if placeableType.functions["renderDisplayTexts"] == nil then
		SpecializationUtil.registerFunction(placeableType, "renderDisplayTexts", HusbandryDisplays.renderDisplayTexts)
	end
	if placeableType.functions["checkRenderDistance"] == nil then
		SpecializationUtil.registerFunction(placeableType, "checkRenderDistance", HusbandryDisplays.checkRenderDistance)
	end
end

function HusbandryDisplays.registerXMLPaths(schema, basePath)
	schema:setXMLSpecializationType("HusbandryDisplays")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?)#rootNode", "Display root node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?)#blindNode", "Show something alternative when no display is shown.")
	schema:register(XMLValueType.INT, basePath .. ".husbandry.husbandryDisplays.display(?)#farmId", "Display owner farm ID", 1)	
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?)#font", "Display font name")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?)#mask", "Display text mask")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?)#fillLevelAlignment", "Display fillLevel alignment")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?)#titleAlignment", "Display title alignment")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?)#capacityAlignment", "Display capacity alignment")
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?)#size", "Display text size", 0.05)	
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?)#scaleX", "Display text scaleX", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?)#scaleY", "Display text scaleY", 1.0)	
	schema:register(XMLValueType.COLOR, basePath .. ".husbandry.husbandryDisplays.display(?)#color", "Display text color", "0.9 0.9 0.9 1")
	schema:register(XMLValueType.COLOR, basePath .. ".husbandry.husbandryDisplays.display(?)#hiddenColor", "Display text hidden color")
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?)#emissiveScale", "Display font name", 1.0)
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#fillType", "Display fill type mapping")	
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#iconNode", "Display icon node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#titleNode", "Display title node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#fillLevelNode", "Display fill level node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#capacityNode", "Display capacity node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#headLineNode", "Display headline node")	
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineSize", "Display text size for line", 0.05)
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineScaleX", "Display text scaleX for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineScaleY", "Display text scaleY for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineEmissiveScale", "Display text size for line", 1.0)
	schema:register(XMLValueType.COLOR, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineColor", "Display text color for line")
	schema:register(XMLValueType.COLOR, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineHiddenColor", "Display text hidden color for line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineFillLevelAlignment", "Display fillLevel alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineTitleAlignment", "Display title alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineCapacityAlignment", "Display capacity alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineFont", "Display font name for line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineMask", "Display text mask line")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#headLineText", "Display text in headline")
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#headLineType", "Display type for headline")
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineTitleTextSize", "Display title text size", 0.05)
	schema:register(XMLValueType.FLOAT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineFillLevelTextSize", "Display fill level text size", 0.05)
	schema:register(XMLValueType.INT, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#lineTitleMaxLen", "Display title text max length", 15)
	schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#fillLevelType", "Display type for fillLevel or capacity")
	
	--schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#productionOnNode", "Display node for production line active")
	--schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#productionOffNode", "Display node for production line inactive")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#fillWarningNode", "Display node for empty storage for filltype")
	--schema:register(XMLValueType.STRING, basePath .. ".husbandry.husbandryDisplays.display(?).displayLine(?)#productionLine", "Display production line id")
	
	schema:setXMLSpecializationType()
end

function HusbandryDisplays:onLoad(savegame)
	self.spec_husbandryDisplays = {}
	local xmlFile = self.xmlFile
	local components = self.components
	local i3dMappings = self.i3dMappings
	local spec = self.spec_husbandryDisplays
	
	local husbandryDisplaysKey = "placeable.husbandry.husbandryDisplays"		
	spec.husbandryDisplayLines = {}
	spec.husbandryHasDisplays = false
	if xmlFile:hasProperty(husbandryDisplaysKey) then		 
		xmlFile:iterate(husbandryDisplaysKey .. ".display", function (_, displayKey)
			local displayNode = xmlFile:getValue(displayKey .. "#rootNode", nil, components, i3dMappings)
			local displayBlindNode = xmlFile:getValue(displayKey .. "#blindNode", nil, components, i3dMappings)
			local displayOwnerFarm = xmlFile:getValue(displayKey .. "#farmId", self:getOwnerFarmId())						
			
			if displayNode ~= nil then
				local displayRootNodeActive = false
				local displayBlindNodeActive = true
				local displayHeadLineText = nil
				local displayHeadlineType = nil
									
				if displayOwnerFarm ~= nil and displayOwnerFarm > 0 and displayOwnerFarm < 15 then					
					displayRootNodeActive = true
					setVisibility(displayNode, true)					
					displayBlindNodeActive = false					
				end
				if displayBlindNode ~= nil then
					setVisibility(displayBlindNode, displayBlindNodeActive)					
				end
				
				spec.husbandryHasDisplays = true
				spec.updateTimer = 0	
				xmlFile:iterate(displayKey .. ".displayLine", function (_, displayLineKey)
					local lineIconNode = xmlFile:getValue(displayLineKey .. "#iconNode", nil, components, i3dMappings)
					local lineTitleNode = xmlFile:getValue(displayLineKey .. "#titleNode", nil, components, i3dMappings)
					local lineCapacityNode = xmlFile:getValue(displayLineKey .. "#capacityNode", nil, components, i3dMappings)
					local lineFillLevelNode = xmlFile:getValue(displayLineKey .. "#fillLevelNode", nil, components, i3dMappings)
					local lineHeadLineNode = xmlFile:getValue(displayLineKey .. "#headLineNode", nil, components, i3dMappings)		
					
					--local lineProdOnNode = xmlFile:getValue(displayLineKey .. "#productionOnNode", nil, components, i3dMappings)
					--local lineProdOffNode = xmlFile:getValue(displayLineKey .. "#productionOffNode", nil, components, i3dMappings)
					local lineProdFillWarnNode = xmlFile:getValue(displayLineKey .. "#fillWarningNode", nil, components, i3dMappings)
					--local lineProdLineID = xmlFile:getValue(displayLineKey .. "#productionLine")
					
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
					local lineFontName = xmlFile:getValue(displayLineKey .. "#lineFont") or xmlFile:getValue(displayKey .. "#font", "DIGIT")					
					
					local lineFontMaterial = g_materialManager:getFontMaterial(lineFontName:upper(), self.customEnvironment)
					
					if lineHeadLineNode ~= nil then
						lineFontMaterial = g_materialManager:getFontMaterial("GENERIC", self.customEnvironment)
						local lineHeadlineText = xmlFile:getValue(displayLineKey .. "#headLineText")
						local lineHeadlineType = xmlFile:getValue(displayLineKey .. "#headLineType")
						if lineHeadlineType ~= nil and (lineHeadlineType == "farmName" or lineHeadlineType == "placeableName") then
							displayHeadlineType = lineHeadlineType
						end
						if lineHeadlineText ~= nil and displayHeadlineType == nil then
							displayHeadLineText = lineHeadlineText
						end
					end
					
					if lineFillLevelNode ~= nil or lineCapacityNode ~= nil then
						local lineFillLevelType = xmlFile:getValue(displayLineKey .. "#fillLevelType")
						if lineFillLevelType ~= nil and (lineFillLevelType == "husbandry" or lineFillLevelType == "feedingRobot" or lineFillLevelType == "husbandryFood") then
							displayFillLevelType = lineFillLevelType
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
					
					local displayLine = {
						fillLevelNode = lineFillLevelNode,
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
						prodOffNode = lineProdOffNode,
						--prodOnNode = lineProdOnNode,
						--prodLineId = lineProdLineID,
						prodfillWarnNode = lineProdFillWarnNode,
						fillLevelType = displayFillLevelType
                    }
					
					displayLine.maskFormatStr, displayLine.maskFormatPrecision = string.maskToFormat(lineTextMask)
					displayLine.fillLevelCharacterLine = nil
					displayLine.titleCharacterLine = nil
					displayLine.capacityCharacterLine = nil
					displayLine.headLineCharacterLine = nil
					
					if displayLine.iconNode ~= nil and displayLine.fillType ~= nil then
						setVisibility(displayLine.iconNode, false)
					end
					
					if displayLine.fillLevelNode ~= nil then --and displayLine.fillType ~= nil then						
						displayLine.fillLevelCharacterLine = lineFontMaterial:createCharacterLine(displayLine.fillLevelNode, lineTextMask:len(), displayLine.fillLevelTextSize, displayLine.color, displayLine.hiddenColor, displayLine.emissiveScale, displayLine.scaleX, displayLine.scaleY, displayLine.textAlignment)
					end
					if displayLine.capacityNode ~= nil then
						displayLine.capacityCharacterLine = lineFontMaterial:createCharacterLine(displayLine.capacityNode, lineTextMask:len(), displayLine.textSize, displayLine.color, displayLine.hiddenColor, displayLine.emissiveScale, displayLine.scaleX, displayLine.scaleY, displayLine.capacityAlignment)
					end
					table.insert(spec.husbandryDisplayLines, displayLine)					
				end)
			end
		end)
		
	end
end

function HusbandryDisplays:onFinalizePlacement(savegame)
	local spec = self.spec_husbandryDisplays
	if spec.husbandryHasDisplays then		
		function spec.fillLevelChangedCallback(fillType, delta)
			self:updateDisplayLines(false, fillType)
		end		
		for _, sourceStorage in pairs(self.spec_husbandry.loadingStation:getSourceStorages()) do				
			sourceStorage:addFillLevelChangedListeners(spec.fillLevelChangedCallback)
		end			
	end
end

function HusbandryDisplays:onPostFinalizePlacement(savegame)	
	local spec = self.spec_husbandryDisplays	
	if spec.husbandryHasDisplays then		
		table.insert(HusbandryDisplays.displays, self)		
	end
	self:updateDisplayLines(true, nil)
end

function HusbandryDisplays:onDelete()
    table.removeElement(HusbandryDisplays.displays, self)
end

function HusbandryDisplays:update(dt)	
	for _, husbandryDisplay in pairs(HusbandryDisplays.displays) do		
        --husbandryDisplay.spec_husbandryDisplays.updateTimer = husbandryDisplay.spec_husbandryDisplays.updateTimer - dt	
		--if husbandryDisplay.spec_husbandryDisplays.updateTimer <= 0 then
		--	husbandryDisplay.spec_husbandryDisplays.updateTimer = 500 + math.random() * 100
			husbandryDisplay:renderDisplayTexts()
		--end
    end
end

function HusbandryDisplays:checkRenderDistance(node)
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

function HusbandryDisplays:renderDisplayTexts()	
	if g_dedicatedServer == nil then		
		for index, displayLine in pairs(self.spec_husbandryDisplays.husbandryDisplayLines) do
			local checkRenderDistance = self:checkRenderDistance(displayLine.rootNode)			
			if checkRenderDistance < 100 then
				local initValues = false			
				local ownerfarmID = self:getOwnerFarmId() or 0
				local checkOwner = false			
				
				if ownerfarmID ~= nil and ownerfarmID > 0 and ownerfarmID < 15 then 
					checkOwner = true 
				end
				
				if displayLine.rootNodeActive == false and checkOwner then								
					self.spec_husbandryDisplays.husbandryDisplayLines[index].rootNodeActive = true
					self.spec_husbandryDisplays.husbandryDisplayLines[index].blindNodeActive = false
					displayLine.rootNodeActive = true
					displayLine.blindNodeActive = false
					self.spec_husbandryDisplays.husbandryDisplayLines[index].farmId = ownerfarmID
					displayLine.farmId = ownerfarmID
					initValues = true
				end
				if displayLine.rootNodeActive == true and not checkOwner then				
					self.spec_husbandryDisplays.husbandryDisplayLines[index].rootNodeActive = false
					self.spec_husbandryDisplays.husbandryDisplayLines[index].blindNodeActive = true
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
					if displayLine.headLineNode ~= nil then --and displayLine.headLineText ~= nil then					
						transX, transY, transZ = getWorldTranslation(displayLine.headLineNode)
						rotX, rotY, rotZ = getWorldRotation(displayLine.headLineNode)					
						displayLine.titleAlignment = RenderText.ALIGN_CENTER
						rendTxt = displayLine.headLineText						
						if displayLine.headLineType ~= nil then
							local validFarm = g_farmManager:getFarmById(displayLine.farmId)
							if displayLine.headLineType == "farmName" and validFarm ~= nil then
								rendTxt = validFarm.name
							elseif displayLine.headLineType == "placeableName" then								
								rendTxt = self:getName()
							end
						end
					end
					if displayLine.titleNode ~= nil then
						transX, transY, transZ = getWorldTranslation(displayLine.titleNode)
						rotX, rotY, rotZ = getWorldRotation(displayLine.titleNode)					
						rendTxt = displayLine.fillType.title
						rendTxtSize = displayLine.titleTextSize
						if displayLine.titleMaxLength~= nil and displayLine.titleMaxLength > 1 and utf8Strlen(rendTxt) > displayLine.titleMaxLength then
							rendTxt = utf8Substr(rendTxt, 0, displayLine.titleMaxLength - 3) .. "..."
						end
					end
					if rendTxt ~= nil then
						setTextVerticalAlignment(RenderText.VERTICAL_ALIGN_BASELINE)
						setTextColor(displayLine.color[1], displayLine.color[2], displayLine.color[3], displayLine.color[4])
						setTextAlignment(displayLine.titleAlignment)			
						renderText3D(transX, transY, transZ, rotX, rotY, rotZ, rendTxtSize, rendTxt)
					end
					if initValues == true then self:updateDisplayLines(true, nil) end
				end
			end
		end		
	end
end

function HusbandryDisplays:updateDisplayLines(initial, fillTypeIndex)
	--if self.isClient then	
	if g_dedicatedServer == nil then
		for _, displayLine in pairs(self.spec_husbandryDisplays.husbandryDisplayLines) do
			local check = false
			if initial ~= nil and initial == false and fillTypeIndex ~= nil and displayLine.fillType ~= nil and displayLine.fillType.index ~= nil and fillTypeIndex == displayLine.fillType.index then check = true end
			if initial ~= nil and initial == true then check = true end
			if displayLine.rootNodeActive == true and check == true then
				if displayLine.fillLevelCharacterLine ~= nil then
					local fillLevel = 0
					if displayLine.fillLevelType ~= nil then  
						if displayLine.fillLevelType == "husbandry" and displayLine.fillType ~= nil then
							fillLevel = self:getHusbandryFillLevel(displayLine.fillType.index, displayLine.farmId) or 0
						end
						if displayLine.fillLevelType == "feedingRobot" and displayLine.fillType ~= nil then							
							if self.spec_husbandryFeedingRobot.feedingRobot.fillTypeToUnloadingSpot[displayLine.fillType.index] ~= nil then
								fillLevel = self.spec_husbandryFeedingRobot.feedingRobot.fillTypeToUnloadingSpot[displayLine.fillType.index].fillLevel or 0
							else
								Logging.error("Could not find fillType '%s' for display. Check husbandryDisplays at '%s'!", displayLine.fillType.name, self.spec_husbandryFeedingRobot.feedingRobot.owner:getName())
							end
						end
						if displayLine.fillLevelType == "husbandryFood" then
							fillLevel = self:getTotalFood() or 0
						end
					end	
					
					local intFill, floatPartFill = math.modf(fillLevel)				
					local fillLevelValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intFill))				
					displayLine.fontMaterial:updateCharacterLine(displayLine.fillLevelCharacterLine, fillLevelValue)				
					if displayLine.prodfillWarnNode ~= nil then
						local statWarn = false
						if intFill < 1 then
							statWarn = true	
						end
						setVisibility(displayLine.prodfillWarnNode, statWarn)
					end
				end
				if displayLine.capacityCharacterLine ~= nil and initial ~= nil and initial == true then
					local capacity = 0
					if displayLine.fillLevelType ~= nil then  
						if displayLine.fillLevelType == "feedingRobot" then
							capacity = self.spec_husbandryFeedingRobot.feedingRobot.fillTypeToUnloadingSpot[displayLine.fillType.index].capacity or 0
						end
						if displayLine.fillLevelType == "husbandry" then
							capacity = self:getHusbandryCapacity(displayLine.fillType.index) or 0
						end
						if displayLine.fillLevelType == "husbandryFood" then
							capacity = self:getFoodCapacity() or 0
						end	
					end										
					local intCap, floatPartCap = math.modf(capacity)				
					local capacityValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intCap))
					displayLine.fontMaterial:updateCharacterLine(displayLine.capacityCharacterLine, capacityValue)
				end
			end			
		end
	end
end

addModEventListener(HusbandryDisplays)

FeedingRobotDisplays = {}

function FeedingRobotDisplays:updateUnloadingSpot(superFunc, spot)	
	if self.owner.spec_husbandryDisplays ~= nil then
		self.owner:updateDisplayLines()
	end
end

FeedingRobot.updateUnloadingSpot = Utils.appendedFunction(FeedingRobot.updateUnloadingSpot, FeedingRobotDisplays.updateUnloadingSpot)