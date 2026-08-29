local enemyPage = action_wheel:newPage("Enemies")

--variables 
local mainFile = models.custom_enemies:getChildren()
local availableModels = {}
local totalClonesTracker = {}
local totalAllowed = 3
local copyLibrary = {}
local slotOption = 1

--function to set up the index table
function actionSlotGenerator()
for i = 1, #mainFile do
local enemyCopies = {}
table.insert(availableModels, models.custom_enemies:getChildren()[i])
table.insert(copyLibrary, enemyCopies)
table.insert(totalClonesTracker, 0)
local action = enemyPage:newAction()
	:title(models.custom_enemies:getChildren()[i]:getName())
	:item("minecraft:iron_sword")
	:hoverColor(1, 0, 1)
	:setOnLeftClick(function()pings.placeCopies(action_wheel:getSelected())end)
	:setOnRightClick(function()pings.removeCopies(action_wheel:getSelected())end)
	:setOnScroll(pings.scrollSelect)
models.custom_enemies:getChildren()[i]:setParentType("WORLD")
end
for i = 1, totalAllowed do
for x = 1, #copyLibrary do
table.insert(copyLibrary[x], "EMPTY")
end
end
end

--Function to place copies
function pings.placeCopies(index)
if copyLibrary[index][slotOption] == "EMPTY" then
local original = models.custom_enemies:getChildren()[index]
local copy = original:copy("CLONE:".. totalClonesTracker[index])
models.custom_enemies:addChild(copy)
copy:setParentType("WORLD"):setPos(reposition()*16):setVisible(true)
copy:getChildren()[1]:setParentType("CAMERA"):setLight(15)
copyLibrary[index][slotOption] = copy
totalClonesTracker[index] = totalClonesTracker[index] + 1
--text above clone
copyLibrary[index][slotOption]:newPart(copyLibrary[index][slotOption]:getName().. "." .. slotOption)
copyLibrary[index][slotOption]
	:getChildren()[2]
	:setParentType("CAMERA")
	:newText("CloneText"..totalClonesTracker[index])
	:setText(models.custom_enemies:getChildren()[index]:getName()..
	" ".. slotOption)
	:setScale(0.4)
	:setOutline(true)
	:setLight(15)
	:setAlignment("CENTER")
	:setPos(0,40,0)
end
end

--function to remove the copies
function pings.removeCopies(index)
if copyLibrary[index][slotOption] ~= "EMPTY" then
local testPiece = copyLibrary[index][slotOption]
copyLibrary[index][slotOption] = "EMPTY"
testPiece:remove()
end
end

--function to determine which object is being deleted
function pings.scrollSelect(dir)
if dir > 0 and slotOption < totalAllowed then
slotOption = slotOption + 1
end
if dir < 0 and slotOption > 1 then
slotOption = slotOption - 1
end
host:setActionbar(slotOption)
end

--function to create the position of a block closest to the center
function reposition()
local playerX = math.modf(player:getPos().x)
local playerY = player:getPos().y
local playerZ = math.modf(player:getPos().z)
local quickX = 0.5
local quickZ = 0.5

if playerX < 0 then
quickX = quickX * -1
end

if playerZ < 0 then
quickZ = quickZ * -1
end

return vec(playerX+quickX,playerY,playerZ+quickZ)
end

--Automatically creates the action wheel stuff
local lastPage = ""

function events.entity_init()
	if action_wheel:getCurrentPage() ~= nil then
	lastPage = action_wheel:getCurrentPage()
	local action = lastPage:newAction()
	:title("Enemy")
	:item("minecraft:iron_sword")
	:hoverColor(1, 0, 1)
	:setOnLeftClick(enemyPageChange)
	
	actionSlotGenerator()
	local action = enemyPage:newAction()
	:title("Return")
	:item("minecraft:barrier")
	:hoverColor(1, 0, 1)
	:setOnLeftClick(returnToMain)
	else
	action_wheel:setPage(enemyPage)
	actionSlotGenerator()
	end
end	

function enemyPageChange()
action_wheel:setPage(enemyPage)
end

function returnToMain()
action_wheel:setPage(lastPage)
end
