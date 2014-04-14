-----------------------------------------------------------------------------------------
-- Main menu is used an a UI for user to get into the game, just layer between the main
-- menu and the actual game.
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

function scene:createScene( event )
    --Group represent the display group of this view, makes it easier to delete everything
    --Just remember to insert into it, ex: group:insert(obj)
 	local group = self.view
 	local playD = display.newText ("Play", 160, 240, font, 30)
 	-----------------------------------------------------------------------------------------
	-- Add local asset to group, for removal when leaving scene
	-----------------------------------------------------------------------------------------
 	group:insert (playD)
	local function playDListener (event)
		if (event.phase == "began") then
			storyboard.gotoScene ("playGame", {effect = "fade", time = 500})
		end
		return true--good practice
	end
	playD:addEventListener ("touch", playDListener)
end

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
return scene