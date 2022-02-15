-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require("physics")
physics.start()
physics.setGravity(0,0)

-- Seed the random number generator
math.randomseed( os.time() )

-- Configure image sheet
local sheetOptions =
{
    frames =
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {   -- 2) asteroid 2
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        {   -- 3) asteroid 3
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        {   -- 4) ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {   -- 5) laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    },
}

local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions )

-- Initialize variables
local lives = 3
local score = 0
local died = false
 
local asteroidsTable = {}
 
local ship
local gameLoopTimer
local livesText
local scoreText

-- Load the background
local backGroup = display.newGroup()

local background = display.newImageRect("background.png", 800, 1400 )
background.x = display.contentCenterX
background.y = display.contentCenterY

backGroup:insert(background)

local mainGroup = display.newGroup()
ship = display.newImageRect( objectSheet, 4, 98, 79 )
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, { radius=30, isSensor=true } )
ship.myName = "ship"
mainGroup:insert(ship)

-- Display lives and score
local uiGroup = display.newGroup()
livesText = display.newText( "Lives: " .. lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( "Score: " .. score, 400, 80, native.systemFont, 36 )
uiGroup:insert(livesText)
uiGroup:insert(scoreText)

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local function updateText()
    livesText.text = "Lives: " .. lives
    scoreText.text = "Score: " .. score
end