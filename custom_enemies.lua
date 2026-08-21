local enemyPage = action_wheel:newPage("Enemies")

models.custom_enemies.Creeper:setParentType("WORLD")


--test function place a cut out
local totalClones = 0
local enemyCopies = {}


function pings.placeCopies()
if totalClones < 3 then
local original = models.custom_enemies.Creeper
local copy = original:copy("CLONE:".. totalClones)
models.custom_enemies:addChild(copy)
copy:setParentType("WORLD"):setPos(reposition()*16):setVisible(true)
reposition()
copy:getChildren()[1]:setParentType("CAMERA")
table.insert(enemyCopies, copy)
totalClones = totalClones + 1
end
end

--function to remove the copies
function pings.removeCopies()
if totalClones > 0 then
enemyCopies[totalClones]:remove()
table.remove(enemyCopies, totalClones)
totalClones = totalClones - 1
end
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

--quick placement button
local action = enemyPage:newAction()
	:title("Cut Out")
	:item("minecraft:iron_sword")
	:hoverColor(1, 0, 1)
	:setOnLeftClick(pings.placeCopies)
	:setOnRightClick(pings.removeCopies)

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
	
	local action = enemyPage:newAction()
	:title("Return")
	:item("minecraft:barrier")
	:hoverColor(1, 0, 1)
	:setOnLeftClick(returnToMain)
	else
	action_wheel:setPage(enemyPage)
	end
end	

function enemyPageChange()
action_wheel:setPage(enemyPage)
end

function returnToMain()
action_wheel:setPage(lastPage)
end