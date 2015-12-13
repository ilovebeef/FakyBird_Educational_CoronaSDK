-----------------------------------------------------------------------------------------
-- Main menu is used an a UI for user to get into the game, just layer between the main
-- menu and the actual game.
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require ("physics")
physics.start ()
function scene:createScene( event )
	local group = self.view
	-----------------------------------------------------------------------------------------
	-- Load game assets
	-----------------------------------------------------------------------------------------
    local background01 = display.newRect (160, 240, 320, 480)
	background01:setFillColor (127/255, 255/255, 212/255)
	group:insert (background01)

	local myObstacles = {}
	local pIntX = 360
	local pBotY = 340
	for i=1, 4 do
		myObstacles[i] = { 
			pBot = display.newRect (pIntX, pBotY, 40, 280),
			pTop = display.newRect (pIntX, (pBotY-360), 40, 280)
		}
		group:insert (myObstacles[i].pBot)
		group:insert (myObstacles[i].pTop)
		pIntX = pIntX + 120
		pBotY = pBotY + 40
	end

	local fakyBird = display.newRect (50, 50, 20,20)
	fakyBird:setFillColor (0.3,0.3,0.3)
	group:insert (fakyBird)

	local myScore = 0
	local myScoreDisplay = display.newText ("Score: "..myScore, 260, 30, font, 24)
	myScoreDisplay:setFillColor (0,0,0)
	-----------------------------------------------------------------------------------------
	-- Load assets into the physics engine.
	-----------------------------------------------------------------------------------------
	physics.addBody (fakyBird)
	fakyBird.gravityScale = 0
	fakyBird.isFixedRotation = true
	fakyBird.isSensor = true
	fakyBird.ID = "Bird"

	for i=1, #myObstacles do
		myObstacles[i].pBot.ID = "Crash"
		myObstacles[i].pTop.ID = "Crash"
		physics.addBody (myObstacles[i].pBot, "static")
		physics.addBody (myObstacles[i].pTop, "static")
	end
	-----------------------------------------------------------------------------------------
	-- Some game data
	-----------------------------------------------------------------------------------------
	local xDelta = 2
	local fakyYDelta = 7
	local fakyFlapDelta = 0
	local function flapBird (event)
		if (event.phase == "began") then
			fakyFlapDelta =13
		end
	end
	-----------------------------------------------------------------------------------------
	-- Cycle listener
	-----------------------------------------------------------------------------------------
	local function onUpdate (event)
		for i=1, #myObstacles do
			myObstacles[i].pBot.x = myObstacles[i].pBot.x - xDelta
			myObstacles[i].pTop.x = myObstacles[i].pBot.x - xDelta

			if (myObstacles[i].pBot.x <= -20) then
				myObstacles[i].pBot.x = 460--myObTable[#myObTable].pBot.x + 120
				myScore = myScore + 1
				myScoreDisplay.text = ""
				myScoreDisplay.text = "Score: "..myScore
			end
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
	local function onLocalCollision( self, event )
	    if ( event.phase == "began" ) then
	    	if (self.ID == "Bird" and event.other.ID == "Crash") then
	    		endGame ()
	    	end
	    end
	end
	-----------------------------------------------------------------------------------------
	function endGame ()
		fakyBird:removeEventListener( "collision", fakyBird)
		Runtime:removeEventListener ("enterFrame", onUpdate)
		background01:removeEventListener ("touch", flapBird)
		local promptEnd = display.newText ("You lost!",160, 100, font, 32)
		promptEnd:setFillColor (0,0,0)
		local promptReplay = display.newText ("Play Again", 160, 240, font, 32)
		promptReplay:setFillColor (0,0,0)
		group:insert (promptEnd)
		group:insert (promptReplay)
		local function replay(event)
			if (event.phase == "began") then
				myScoreDisplay.text = ""
				storyboard.gotoScene ("mainMenu", {effect = "fade", time = 1000})
			end
		end
		promptReplay:addEventListener ("touch", replay)
	end
	fakyBird.collision = onLocalCollision
	fakyBird:addEventListener( "collision", fakyBird)
	-----------------------------------------------------------------------------------------
	-- Hook up functions
	-----------------------------------------------------------------------------------------
	Runtime:addEventListener ("enterFrame", onUpdate)
	background01:addEventListener ("touch", flapBird)

end

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene