local grid = require "grid"

hs.window.animationDuration = 0 -- disable animations

-- Forward function declarations.
local activate = nil
local activateLayout = nil
local canManageWindow = nil
local chain = nil
local handleScreenEvent = nil
local handleWindowEvent = nil
local hide = nil
local initEventHandling = nil
local internalDisplay = nil
local tearDownEventHandling = nil
local windowCount = nil

local screenCount = #hs.screen.allScreens()

local lastSeenChain = nil
local lastSeenWindow = nil
local lastSeenAt = nil

chain = (function(movements)
    local chainResetInterval = 2 -- seconds
    local cycleLength = #movements
    local sequenceNumber = 1
  
    return function()
      local win = hs.window.frontmostWindow()
      local id = win:id()
      local now = hs.timer.secondsSinceEpoch()
      local screen = win:screen()
  
      if
        lastSeenChain ~= movements or
        lastSeenAt < now - chainResetInterval or
        lastSeenWindow ~= id
      then
        sequenceNumber = 1
        lastSeenChain = movements
      elseif (sequenceNumber == 1) then
        -- At end of chain, restart chain on next screen.
        screen = screen:next()
      end
      lastSeenAt = now
      lastSeenWindow = id
  
      hs.grid.set(win, movements[sequenceNumber], screen)
      sequenceNumber = sequenceNumber % cycleLength + 1
    end
  end)

--
-- Key bindings.
--
hs.hotkey.bind({'ctrl', 'alt'}, 'right', chain({
  grid.Layout.rightHalf,
  grid.Layout.leftHalf,
}))

hs.hotkey.bind({'ctrl', 'alt'}, 'left', chain({
  grid.Layout.leftHalf,
  grid.Layout.rightHalf,
}))

hs.hotkey.bind({'ctrl', 'alt'}, 'up', chain({
  grid.Layout.topHalf,
  grid.Layout.bottomHalf,
}))

hs.hotkey.bind({'ctrl', 'alt'}, 'down', chain({
  grid.Layout.bottomHalf,
  grid.Layout.topHalf,
}))

hs.hotkey.bind({'ctrl', 'alt'}, 'return', (function()
  grid.app(grid.Layout.fullScreen)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'u', (function()
  grid.app(grid.Layout.topLeft)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'j', (function()
  grid.app(grid.Layout.bottomLeft)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'k', (function()
  grid.app(grid.Layout.bottomRight)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'w', (function()
  grid.app(grid.Layout.leftTwoThirds)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'e', (function()
  grid.app(grid.Layout.rightTwoThirds)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'a', (function()
  grid.app(grid.Layout.leftThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 's', (function()
  grid.app(grid.Layout.centerThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'd', (function()
  grid.app(grid.Layout.rightThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'c', (function()
  grid.app(grid.Layout.centeredBig)
end))

hs.hotkey.bind({'ctrl', 'alt'}, 'm', (function()
  grid.app(grid.Layout.bottomBig)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '1', (function()
  grid.app(grid.Layout.topThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '2', (function()
  grid.app(grid.Layout.topMiddleThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '3', (function()
  grid.app(grid.Layout.topLastThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '4', (function()
  grid.app(grid.Layout.bottomThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '5', (function()
  grid.app(grid.Layout.bottomMiddleThird)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '6', (function()
  grid.app(grid.Layout.bottomLastThird)
end))

hs.hotkey.bind({'cmd'}, 'escape', (function()
  hs.hints.windowHints()
end))

hs.alert.show("Config loaded")
