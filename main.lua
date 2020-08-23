heart = require("heart")

local levelGrid = require("leapYear.resources.configs.levelGrid")

function love.load()
  love.window.setTitle("Leap Year")

  love.window.setMode(800, 600, {
    fullscreentype = "desktop",
    resizable = true,
    -- fullscreen = true,
    -- highdpi = true,
  })

  love.graphics.setDefaultFilter("linear", "nearest")
  love.physics.setMeter(1)
  love.mouse.setVisible(false)

  local resourceLoaders = {
    image = heart.graphics.ImageResourceLoader.new(),
  }

  local gameConfig = require("leapYear.resources.configs.game")
  local levelConfig = require("leapYear.resources.configs.levels.forest")
  local config = setmetatable({entities = levelConfig}, {__index = gameConfig})
  engine = heart.Engine.new(resourceLoaders, config)

  love.handlers.warp = love.warp

  love.event.push("warp", {a = "b"})
end

function love.draw()
  engine:handleEvent("draw")
end

function love.keypressed(key, scancode, isrepeat)
  local ctrlDown = love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")
  local guiDown = love.keyboard.isDown("lgui") or love.keyboard.isDown("lgui")

  if (ctrlDown or guiDown) and key == "p" then
    local timestamp = os.date('%Y-%m-%d-%H-%M-%S')
    local filename = "screenshot-" .. timestamp .. ".png"
    love.graphics.captureScreenshot(filename)

    local saveDirectory = love.filesystem.getSaveDirectory()
    print("Captured screenshot: " .. saveDirectory .. "/" .. filename)
  end
end

function love.resize(width, height)
  engine:handleEvent("resize", width, height)
end

function love.update(dt)
  engine:handleEvent("update", dt)
end

function love.warp(levelX, levelY, entityConfigs)
end
