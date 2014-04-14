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

local pBot01 = display.newRect (40, 340, 40, 280)
local pTop01 = display.newRect (40, -20, 40, 280)

local pBot02 = display.newRect (120, 380, 40, 280)
local pTop02 = display.newRect (120, 20, 40, 280)

local pBot03 = display.newRect (200, 420, 40, 280)
local pTop03 = display.newRect (200, 60, 40, 280)

local pBot04 = display.newRect (280, 460, 40, 280)
local pTop04 = display.newRect (280, 100, 40, 280)



local function onUpdate (event)
	pBot01.x = pBot01.x - 0.5
	pTop01.x = pBot01.x - 0.5

	pBot02.x = pBot02.x - 0.5
	pTop02.x = pBot02.x - 0.5

	pBot03.x = pBot03.x - 0.5
	pTop03.x = pBot03.x - 0.5

	pBot04.x = pBot04.x - 0.5
	pTop04.x = pBot04.x - 0.5

end
Runtime:addEventListener ("enterFrame", onUpdate)

