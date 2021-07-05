local grid = require "grid"

hs.window.animationDuration = 0 -- disable animations

-- Forward function declarations.
local chain = nil
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

hs.hotkey.bind({'ctrl', 'alt'}, '7', (function()
  grid.app(grid.Layout.topTwoThirds)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '8', (function()
  grid.app(grid.Layout.topLastTwoThirds)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '9', (function()
  grid.app(grid.Layout.bottomTwoThirds)
end))

hs.hotkey.bind({'ctrl', 'alt'}, '0', (function()
  grid.app(grid.Layout.bottomLastTwoThirds)
end))

hs.hotkey.bind({'cmd'}, 'escape', (function()
  hs.hints.windowHints()
end))

function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
      if (appName == "Finder") then
          -- Bring all Finder windows forward when one gets activated
          appObject:selectMenuItem({"Window", "Bring All to Front"})
      end
  end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.alert.show("Config loaded")
