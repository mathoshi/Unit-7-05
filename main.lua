-----------------------------------------------------------------------------------------
--
-- Created by: Matsuru Hoshi
-- Created on: Apr 17, 2016
--
-- This will implement physics while moving a sprite
-----------------------------------------------------------------------------------------

local physics = require( "physics")

physics.start()
physics.setGravity( 0, 100)
physics.setDrawMode("hybrid")

local background = display.newImageRect( "assets/substreet.png", display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

local ground = display.newRect( display.contentCenterX, 555, 500, 60)
ground.id = "ground"
physics.addBody( ground, "static", {
	friction = 0.5,
	bounce = 0
	})

local wall = display.newRect( -32, display.contentCenterY, 60, 560)
wall.id = "wall"
physics.addBody( wall, "static", {
	friction = 0.5,
	bounce = 0.1
	})

local rightRect = display.newRoundedRect( 270, 480, 80, 60, 10)
rightRect:setFillColor( 124/255, 124/255, 124/255)
rightRect.alpha = 0.90

local leftRect = display.newRoundedRect( 50, 480, 80, 60, 10)
leftRect:setFillColor( 124/255, 124/255, 124/255)
leftRect.alpha = 0.90

local upRect = display.newRoundedRect( 270, 410, 80, 60, 10)
upRect:setFillColor( 124/255, 124/255, 124/255)
upRect.alpha = 0.90

local downRect = display.newRoundedRect( 50, 410, 80, 60, 10)
downRect:setFillColor( 124/255, 124/255, 124/255)
downRect.alpha = 0.90

local leftArrow = display.newImageRect( "assets/leftarrow.png", 60, 60)
leftArrow.x = 50
leftArrow.y = 480

local rightArrow = display.newImageRect( "assets/arrow.png", 60, 60)
rightArrow.x = 270
rightArrow.y = 480

local upArrow = display.newImageRect( "assets/uparrow.png", 60, 60)
upArrow.x = 270
upArrow.y = 410

local downArrow = display.newImageRect( "assets/downarrow.png", 60, 60)
downArrow.x = 50
downArrow.y = 410

local luxoball = display.newImageRect( "assets/luxoball.png", 100, 98)
luxoball.x = display.contentCenterX
luxoball.y = 100
luxoball.id = "luxoball"
physics.addBody( luxoball, "dynamic", {
	density = 1,
	friction = 0.5,
	bounce = 0.3
	})

local box = display.newRect( 160, 300, 50, 50)
box.id = "box"
physics.addBody( box, "dynamic", {
	density = 0.1,
	friction = 0.3
	})

local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end
 


function rightArrow:touch( event )
    if ( event.phase == "moved" or event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( luxoball, { 
        	x = 25, -- move 0 in the x direction 
        	y = -25, -- move up 50 pixels
        	time = 1 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "moved" or event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( luxoball, { 
            x = -25, -- move  in the x direction 
            y = -50, -- move up
            time = 1 -- move in a 1/10 of a second
            } )
    end

    return true
end

function upArrow:touch( event )
    if ( event.phase == "moved" or event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( luxoball, { 
            x = 0, -- move 0 in the x direction 
            y = -100, -- move up 50 pixels
            time = 1 -- move in a 1/10 of a second
            } )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "moved" or event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( luxoball, { 
            x = 0, -- move 0 in the x direction 
            y = 50, -- move up 50 pixels
            time = 1 -- move in a 1/10 of a second
            } )
    end

    return true
end

-- if character falls off the end of the world, respawn back to where it came from
function checkCharacterPosition( event )
    -- check every frame to see if character has fallen
    if luxoball.y > display.contentHeight + 500 then
        luxoball.x = display.contentCenterX 
        luxoball.y = display.contentCenterY
    end
end

luxoball.collision = characterCollision
luxoball:addEventListener( "collision")
rightArrow:addEventListener( "touch", rightArrow )
leftArrow:addEventListener( "touch", leftArrow )
upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
Runtime:addEventListener( "enterFrame", checkCharacterPosition )
