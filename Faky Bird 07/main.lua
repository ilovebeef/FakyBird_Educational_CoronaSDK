-----------------------------------------------------------------------------------------
--
-- Faky Bird
-- By: Hong P Nguyen, President of Computer Science Society, C.S.U.E.B.
-- Please credit if you use my code.
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- Making a grid that would help us to align where we want the poles
-----------------------------------------------------------------------------------------
-- 320/40 = 8		16
-- 480/40 = 12		24
-----------------------------------------------------------------------------------------
-- Module Calls
-----------------------------------------------------------------------------------------
local physics = require ("physics")
physics.start ()
	--uncomment to see debug/hybrid
--physics.setDrawMode ("hybrid")
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

local background01 = display.newRect (160, 240, 320, 480)
background01:setFillColor (127/255, 255/255, 212/255)

--Lets make a h-grid
local hX = 160
local hY = 20
for i=1, 24 do
	local myGrid = display.newRect (hX, hY, 320, 2)
	myGrid:setFillColor (0.5,0.5,0.5)
	hY = hY + 20
end

--Lets make the v-grid
local vX = 20
local vY = 240
for i=1, 16 do
	local myGrid = display.newRect (vX, vY, 2, 480)
	myGrid:setFillColor (0.5,0.5,0.5)
	vX = vX + 20
end


--Lets figure what we want for the pole,

local pBot01 = display.newRect (360, 340, 40, 280)
local pTop01 = display.newRect (360, -20, 40, 280)

local pBot02 = display.newRect (480, 380, 40, 280)
local pTop02 = display.newRect (480, 20, 40, 280)

local pBot03 = display.newRect (600, 420, 40, 280)
local pTop03 = display.newRect (600, 60, 40, 280)

local pBot04 = display.newRect (720, 460, 40, 280)
local pTop04 = display.newRect (720, 100, 40, 280)



local fakyBird = display.newRect (50, 50, 20,20)
fakyBird:setFillColor (0.3,0.3,0.3)

-----------------------------------------------------------------------------------------
-- Adds object to the physics engine and some logic
-- Static object are stationary to the physics engine, but can be moved the the dev and 
-- used as a detector.
-----------------------------------------------------------------------------------------
physics.addBody (fakyBird)
fakyBird.gravityScale = 0
fakyBird.isFixedRotation = true
fakyBird.isSensor = true

physics.addBody (pBot01, "static")
physics.addBody (pTop01, "static")

physics.addBody (pBot02, "static")
physics.addBody (pTop02, "static")

physics.addBody (pBot03, "static")
physics.addBody (pTop03, "static")

physics.addBody (pBot04, "static")
physics.addBody (pTop04, "static")

fakyBird.ID = "Bird"
	--will print Bird
--print (fakyBird.ID)

pBot01.ID = "Crash"
pTop01.ID = "Crash"

pBot02.ID = "Crash"
pTop02.ID = "Crash"

pBot03.ID = "Crash"
pTop03.ID = "Crash"

pBot04.ID = "Crash"
pTop04.ID = "Crash"

--physics.setDrawMode ("hybrid")
--physics.setDrawMode ("debug")
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
--	[1][2][3][4]
--	[2][3][4][1]
--	[3][4][1][2]
--  [4][1][2][3]
local xDelta = 2
local fakyYDelta = 7
local fakyFlapDelta = 0
local function flapBird (event)
	if (event.phase == "began") then
		fakyFlapDelta =13
	end
end

-----------------------------------------------------------------------------------------
local function onUpdate (event)
	pBot01.x = pBot01.x - xDelta 
	pTop01.x = pBot01.x - xDelta 

	pBot02.x = pBot02.x - xDelta 
	pTop02.x = pBot02.x - xDelta 

	pBot03.x = pBot03.x - xDelta 
	pTop03.x = pBot03.x - xDelta 

	pBot04.x = pBot04.x - xDelta 
	pTop04.x = pBot04.x - xDelta 


	if (pBot01.x <= -20) then
		pBot01.x = pBot04.x + 120
	elseif (pBot02.x <= -20) then
		pBot02.x = pBot01.x + 120
	elseif (pBot03.x <= -20) then
		pBot03.x = pBot02.x + 120
	elseif (pBot04.x <= -20) then
		pBot04.x = pBot03.x + 120
	end

	if (fakyFlapDelta > 0) then
		fakyBird.y = fakyBird.y - fakyFlapDelta
		fakyFlapDelta = fakyFlapDelta - 0.8
	end
	fakyBird.y = fakyBird.y + fakyYDelta

	if (fakyBird.y < -10) then
		endGame ()
	elseif (fakyBird.y > 480) then
		endGame ()
	end 
end
-----------------------------------------------------------------------------------------
local function onLocalCollision (self, event )
    if ( event.phase == "began" ) then
    	if (self.ID == "Bird" and event.other.ID == "Crash") then
    		endGame ()
    	end
        print( self.ID .. ": collision began with " .. event.other.ID )
    end
end
-----------------------------------------------------------------------------------------
function endGame ()
	fakyBird:removeEventListener( "collision", fakyBird)
	Runtime:removeEventListener ("enterFrame", onUpdate)
	background01:removeEventListener ("touch", flapBird)
	local promptEnd = display.newText ("You lost!",160, 100, font, 32)
	promptEnd:setFillColor (0,0,0)
end
fakyBird.collision = onLocalCollision
fakyBird:addEventListener( "collision", fakyBird)

Runtime:addEventListener ("enterFrame", onUpdate)
background01:addEventListener ("touch", flapBird)
