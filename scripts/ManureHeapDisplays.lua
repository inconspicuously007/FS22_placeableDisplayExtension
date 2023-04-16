ManureHeapDisplays = { displays = {} }

function ManureHeapDisplays.prerequisitesPresent(specializations)
  return SpecializationUtil.hasSpecialization(PlaceableManureHeap, specializations)  
end

function ManureHeapDisplays.registerEventListeners(placeableType)
  SpecializationUtil.registerEventListener(placeableType, "onLoad", ManureHeapDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onFinalizePlacement", ManureHeapDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onPostFinalizePlacement", ManureHeapDisplays)
  SpecializationUtil.registerEventListener(placeableType, "onDelete", ManureHeapDisplays)
end

function ManureHeapDisplays.registerFunctions(placeableType)
  SpecializationUtil.registerFunction(placeableType, "updateDisplayLines", ManureHeapDisplays.updateDisplayLines)
  SpecializationUtil.registerFunction(placeableType, "renderDisplayTexts", ManureHeapDisplays.renderDisplayTexts)
  SpecializationUtil.registerFunction(placeableType, "checkRenderDistance", ManureHeapDisplays.checkRenderDistance)
end

function ManureHeapDisplays.registerXMLPaths(schema, basePath)
	schema:setXMLSpecializationType("ManureHeapDisplays")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?)#rootNode", "Display root node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?)#blindNode", "Show something alternative when no display is shown.")
	schema:register(XMLValueType.INT, basePath .. ".manureHeap.manureHeapDisplays.display(?)#farmId", "Display owner farm ID", 1)	
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?)#font", "Display font name")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?)#mask", "Display text mask")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?)#fillLevelAlignment", "Display fillLevel alignment")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?)#titleAlignment", "Display title alignment")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?)#capacityAlignment", "Display capacity alignment")
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?)#size", "Display text size", 0.05)	
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?)#scaleX", "Display text scaleX", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?)#scaleY", "Display text scaleY", 1.0)	
	schema:register(XMLValueType.COLOR, basePath .. ".manureHeap.manureHeapDisplays.display(?)#color", "Display text color", "0.9 0.9 0.9 1")
	schema:register(XMLValueType.COLOR, basePath .. ".manureHeap.manureHeapDisplays.display(?)#hiddenColor", "Display text hidden color")
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?)#emissiveScale", "Display font name", 1.0)
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#fillType", "Display fill type mapping")	
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#iconNode", "Display icon node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#titleNode", "Display title node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#fillLevelNode", "Display fill level node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#capacityNode", "Display capacity node")
	schema:register(XMLValueType.NODE_INDEX, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#headLineNode", "Display headline node")	
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineSize", "Display text size for line", 0.05)
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineScaleX", "Display text scaleX for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineScaleY", "Display text scaleY for line", 1.0)
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineEmissiveScale", "Display text size for line", 1.0)
	schema:register(XMLValueType.COLOR, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineColor", "Display text color for line", "0.9 0.9 0.9 1")
	schema:register(XMLValueType.COLOR, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineHiddenColor", "Display text hidden color for line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineFillLevelAlignment", "Display fillLevel alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineTitleAlignment", "Display title alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineCapacityAlignment", "Display capacity alignment for line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineFont", "Display font name for line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineMask", "Display text mask line")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#headLineText", "Display text in headline")
	schema:register(XMLValueType.STRING, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#headLineType", "Display type for headline")
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineTitleTextSize", "Display title text size", 0.05)
	schema:register(XMLValueType.FLOAT, basePath .. ".manureHeap.manureHeapDisplays.display(?).displayLine(?)#lineFillLevelTextSize", "Display fill level text size", 0.05)	
	schema:setXMLSpecializationType()
end

function ManureHeapDisplays:onLoad(savegame)
	self.spec_manureHeapDisplays = {}
	local xmlFile = self.xmlFile
	local components = self.components
	local i3dMappings = self.i3dMappings
	local spec = self.spec_manureHeapDisplays
	
	local manureHeapDisplaysKey = "placeable.manureHeap.manureHeapDisplays"	
	
	spec.manureHeapDisplayLines = {}
	spec.manureHeapHasDisplays = false
	if xmlFile:hasProperty(manureHeapDisplaysKey) then		 
		xmlFile:iterate(manureHeapDisplaysKey .. ".display", function (_, displayKey)
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
				
				spec.manureHeapHasDisplays = true
				spec.updateTimer = 0
				xmlFile:iterate(displayKey .. ".displayLine", function (_, displayLineKey)
					local lineIconNode = xmlFile:getValue(displayLineKey .. "#iconNode", nil, components, i3dMappings)
					local lineTitleNode = xmlFile:getValue(displayLineKey .. "#titleNode", nil, components, i3dMappings)
					local lineCapacityNode = xmlFile:getValue(displayLineKey .. "#capacityNode", nil, components, i3dMappings)
					local lineFillLevelNode = xmlFile:getValue(displayLineKey .. "#fillLevelNode", nil, components, i3dMappings)
					local lineHeadLineNode = xmlFile:getValue(displayLineKey .. "#headLineNode", nil, components, i3dMappings)		
					
					local lineTextSize = xmlFile:getValue(displayLineKey .. "#lineSize") or xmlFile:getValue(displayKey .. "#size", 0.03)
					local lineTitleTextSize = xmlFile:getValue(displayLineKey .. "#lineTitleTextSize") or lineTextSize
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
							displayHeadLineText = lineHeadlineText
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
					if lineFillTypeName ~= nil then
						lineFillType = g_fillTypeManager:getFillTypeByName(lineFillTypeName)
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
						fillLevelTextSize = lineFillLevelTextSize,
						fillType = lineFillType,
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
					table.insert(spec.manureHeapDisplayLines, displayLine)					
				end)
			end
		end)
		
	end
end

function ManureHeapDisplays:onFinalizePlacement(savegame)
	local spec = self.spec_manureHeapDisplays
	if spec.manureHeapHasDisplays then			
		function spec.fillLevelChangedCallback(fillType, delta)
			self:updateDisplayLines(false)
		end		
		for _, sourceStorage in pairs(self.spec_manureHeap.loadingStation:getSourceStorages()) do				
			sourceStorage:addFillLevelChangedListeners(spec.fillLevelChangedCallback)
		end			
	end
end

function ManureHeapDisplays:onPostFinalizePlacement(savegame)	
	local spec = self.spec_manureHeapDisplays
	if spec.manureHeapHasDisplays then		
		table.insert(ManureHeapDisplays.displays, self)		
	end
	self:updateDisplayLines(true)	
end

function ManureHeapDisplays:onDelete()
    table.removeElement(ManureHeapDisplays.displays, self)
end

function ManureHeapDisplays:update(dt)	
	for _, manureHeapDisplay in pairs(ManureHeapDisplays.displays) do		        	
		manureHeapDisplay:renderDisplayTexts()		
    end
end

function ManureHeapDisplays:checkRenderDistance(node)
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

function ManureHeapDisplays:renderDisplayTexts()	 
	if g_dedicatedServer == nil then
		for index, displayLine in pairs(self.spec_manureHeapDisplays.manureHeapDisplayLines) do
			local checkRenderDistance = self:checkRenderDistance(displayLine.rootNode)			
			if checkRenderDistance < 100 then
				local ownerfarmID = self.spec_manureHeap.manureHeap:getOwnerFarmId()
				local checkOwner = false
				local mustRedraw = false
				if ownerfarmID ~= nil and ownerfarmID > 0 and ownerfarmID < 15 then 
					checkOwner = true 
				end
				
				if displayLine.rootNodeActive == false and checkOwner then								
					self.spec_manureHeapDisplays.manureHeapDisplayLines[index].rootNodeActive = true
					self.spec_manureHeapDisplays.manureHeapDisplayLines[index].blindNodeActive = false
					displayLine.rootNodeActive = true
					displayLine.blindNodeActive = false
					self.spec_manureHeapDisplays.manureHeapDisplayLines[index].farmId = ownerfarmID
					displayLine.farmId = ownerfarmID
					mustRedraw = true
				end
				if displayLine.rootNodeActive == true and not checkOwner then				
					self.spec_manureHeapDisplays.manureHeapDisplayLines[index].rootNodeActive = false
					self.spec_manureHeapDisplays.manureHeapDisplayLines[index].blindNodeActive = true
					displayLine.rootNodeActive = false
					displayLine.blindNodeActive = true
					mustRedraw = true
				end
				if mustRedraw == true then
					setVisibility(displayLine.rootNode, displayLine.rootNodeActive)
				end
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
								rendTxt = self.spec_manureHeap.loadingStation:getName()
							end
						end
					end
					if displayLine.titleNode ~= nil then
						transX, transY, transZ = getWorldTranslation(displayLine.titleNode)
						rotX, rotY, rotZ = getWorldRotation(displayLine.titleNode)					
						rendTxt = displayLine.fillType.title
						rendTxtSize = displayLine.titleTextSize
					end
					if rendTxt ~= nil then
						setTextVerticalAlignment(RenderText.VERTICAL_ALIGN_BASELINE)
						setTextColor(displayLine.color[1], displayLine.color[2], displayLine.color[3], displayLine.color[4])
						setTextAlignment(displayLine.titleAlignment)			
						renderText3D(transX, transY, transZ, rotX, rotY, rotZ, rendTxtSize, rendTxt)
					end
					self:updateDisplayLines(true)					
				end
			end
		end		
	end
end

function ManureHeapDisplays:updateDisplayLines(initial)	
	if g_dedicatedServer == nil then
		for _, displayLine in pairs(self.spec_manureHeapDisplays.manureHeapDisplayLines) do			
			if displayLine.fillLevelCharacterLine ~= nil then								
				local fillLevel = self.spec_manureHeap.manureHeap:getFillLevel(self.spec_manureHeap.manureHeap.fillTypeIndex)
				local intFill, floatPartFill = math.modf(fillLevel)				
				local fillLevelValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intFill))				
				displayLine.fontMaterial:updateCharacterLine(displayLine.fillLevelCharacterLine, fillLevelValue)				
			end
			if displayLine.capacityCharacterLine ~= nil and initial == true then				
				local capacity = self.spec_manureHeap.manureHeap:getCapacity(self.spec_manureHeap.manureHeap.fillTypeIndex) or 0
				local intCap, floatPartCap = math.modf(capacity)				
				local capacityValue = string.format("%" .. displayLine.mask:len() .. "s", g_i18n:formatNumber(intCap))
				displayLine.fontMaterial:updateCharacterLine(displayLine.capacityCharacterLine, capacityValue)
			end		
		end
	end
end

addModEventListener(ManureHeapDisplays)