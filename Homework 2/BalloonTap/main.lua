-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local score = 0

local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local scoreText = display.newText(score, display.contentCenterX, 20, native.systemFont, 40)
scoreText:setFillColor(0, 0, 0)

local platform = display.newImageRect("platform.png", 320, 50)
platform.x = display.contentCenterX
platform.y = -25

local platform2 = display.newImageRect("platform.png", 320, 50)
platform2.x = display.contentCenterX
platform2.y = display.contentHeight + 25

local rightPlatform = display.newImageRect("platform.png", 50, display.contentHeight)
rightPlatform.x = display.contentWidth + 25
rightPlatform.y = display.contentCenterY

local leftPlatform = display.newImageRect("platform.png", 50, display.contentHeight)
leftPlatform.x = -25
leftPlatform.y = display.contentCenterY

local balloon = display.newImageRect("balloon.png", 112, 112)
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY
balloon.alpha = 0.8

local physics = require("physics")
physics.start()

local function onEnemyCollision(self, event)
    if (event.phase == "began") then
        if (event.other.myName == "balloon") then
            event.other:removeSelf()
        elseif (event.other.myName =="left platform") then
            self:removeSelf()
            score = score + 1
            scoreText.text = score
        end
    end
end
local function onBalloonCollision(self, event)
    if (event.phase == "began") then
        if (event.other.myName == "left platform") then
            print("left platform collision!")
        end
    end
end

local function createEnemy()
    local enemy = display.newImageRect("platform.png", 50, 10)
    enemy.x = display.contentWidth
    enemy.y = math.random(50, display.contentHeight - 50)

    physics.addBody(enemy, "dynamic")
    enemy.gravityScale = 0
    enemy.isFixedRotation = true

    enemy.myName = "enemy"
    enemy.collision = onEnemyCollision
    enemy:addEventListener("collision")
    enemy:setLinearVelocity(-100, 0)
end

timer.performWithDelay(3000, createEnemy, 0)

physics.addBody(platform, "static")
physics.addBody(platform2, "static")
physics.addBody(rightPlatform, "static")
physics.addBody(leftPlatform, "static")
physics.addBody(balloon, "dynamic", {bounce = .3})

leftPlatform.myName = "left platform"

balloon.myName = "balloon"
balloon.collision = onBalloonCollision
balloon:addEventListener("collision")

local function pushBalloon(event)
    balloon:setLinearVelocity(0,0)
    local dirX = 0
    local dirY = 0

    if (event.x > balloon.x) then
        dirX = -.25
        print("left")
    else
        dirX = .25
        print("right")
    end

    if (event.y > balloon.y) then
        dirY = -1
        print("up")
    else
        dirY = 1
        print("down")
    end

    balloon:applyLinearImpulse(dirX, dirY, balloon.x, balloon.y)
end

background:addEventListener("tap", pushBalloon)