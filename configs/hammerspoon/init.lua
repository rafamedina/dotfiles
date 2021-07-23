local grid = require("grid")
hs.window.animationDuration = 0
-- disable animations
-- Forward function declarations.
local chain = nil
local lastSeenChain = nil
local lastSeenWindow = nil
local lastSeenAt = nil
local appWatcher = nil
local windowSize = { frame = nil, zoom = false }
chain = function(movements)
	local chainResetInterval = 2
	-- seconds
	local cycleLength = #movements
	local sequenceNumber = 1
	return function()
		local win = hs.window.frontmostWindow()
		local id = win:id()
		local now = hs.timer.secondsSinceEpoch()
		local screen = win:screen()
		if lastSeenChain ~= movements or lastSeenAt < now - chainResetInterval or lastSeenWindow ~= id then
			sequenceNumber = 1
			lastSeenChain = movements
		elseif sequenceNumber == 1 then
			-- At end of chain, restart chain on next screen.
			screen = screen:next()
		end
		lastSeenAt = now
		lastSeenWindow = id
		hs.grid.set(win, movements[sequenceNumber], screen)
		sequenceNumber = sequenceNumber % cycleLength + 1
		appWatcher:start()
	end
end
--
-- Key bindings.
--
local hotkeys = hs.hotkey.modal.new({ "cmd", "shift", "alt" }, "F19")
hotkeys:bind({ "ctrl", "alt" }, "right", chain({ grid.Layout.rightHalf, grid.Layout.leftHalf }))
hotkeys:bind({ "ctrl", "alt" }, "left", chain({ grid.Layout.leftHalf, grid.Layout.rightHalf }))
hotkeys:bind({ "ctrl", "alt" }, "up", chain({ grid.Layout.topHalf, grid.Layout.bottomHalf }))
hotkeys:bind({ "ctrl", "alt" }, "down", chain({ grid.Layout.bottomHalf, grid.Layout.topHalf }))
hotkeys:bind({ "ctrl", "alt", "shift" }, "return", function()
	grid.app(grid.Layout.fullScreen)
end)
hotkeys:bind({ "ctrl", "alt" }, "u", function()
	grid.app(grid.Layout.topLeft)
end)
hotkeys:bind({ "ctrl", "alt" }, "i", function()
	grid.app(grid.Layout.topRight)
end)
hotkeys:bind({ "ctrl", "alt" }, "j", function()
	grid.app(grid.Layout.bottomLeft)
end)
hotkeys:bind({ "ctrl", "alt" }, "k", function()
	grid.app(grid.Layout.bottomRight)
end)
hotkeys:bind({ "ctrl", "alt" }, "w", function()
	grid.app(grid.Layout.leftTwoThirds)
end)
hotkeys:bind({ "ctrl", "alt" }, "e", function()
	grid.app(grid.Layout.rightTwoThirds)
end)
hotkeys:bind({ "ctrl", "alt" }, "a", function()
	grid.app(grid.Layout.leftThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "s", function()
	grid.app(grid.Layout.centerThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "d", function()
	grid.app(grid.Layout.rightThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "c", function()
	grid.app(grid.Layout.centeredBig)
end)
hotkeys:bind({ "ctrl", "alt" }, "m", function()
	grid.app(grid.Layout.bottomBig)
end)
hotkeys:bind({ "ctrl", "alt" }, "1", function()
	grid.app(grid.Layout.topThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "2", function()
	grid.app(grid.Layout.topMiddleThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "3", function()
	grid.app(grid.Layout.topLastThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "4", function()
	grid.app(grid.Layout.bottomThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "5", function()
	grid.app(grid.Layout.bottomMiddleThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "6", function()
	grid.app(grid.Layout.bottomLastThird)
end)
hotkeys:bind({ "ctrl", "alt" }, "7", function()
	grid.app(grid.Layout.topTwoThirds)
end)
hotkeys:bind({ "ctrl", "alt" }, "8", function()
	grid.app(grid.Layout.topLastTwoThirds)
end)
hotkeys:bind({ "ctrl", "alt" }, "9", function()
	grid.app(grid.Layout.bottomTwoThirds)
end)
hotkeys:bind({ "ctrl", "alt" }, "0", function()
	grid.app(grid.Layout.bottomLastTwoThirds)
end)

hotkeys:bind({ "ctrl", "alt"}, "return", function()
	local win = hs.window.frontmostWindow()
	if windowSize["zoom"] == false then
		windowSize["frame"] = win:frame()
		grid.app(grid.Layout.fullScreen)
		windowSize["zoom"] = true
	else
		win:setFrame(windowSize["frame"])
		windowSize["zoom"] = false
	end
end)

hotkeys:bind({ "cmd" }, "escape", function()
	-- hs.hints.windowHints()
	hs.hints.windowHints(hs.window.visibleWindows())
end)

function applicationWatcher(appName, eventType, appObject)

	windowSize["zoom"] = false
	if appName == "Finder" then
		if eventType == hs.application.watcher.activated then
			-- hotkeys:exit()
			-- Bring all Finder windows forward when one gets activated
			appObject:selectMenuItem({ "Window", "Bring All to Front" })
		elseif eventType == hs.application.watcher.deactivated then
			-- Emacs just lost focus, enable our hotkeys
			-- hotkeys:enter()
		end
	end
end

appWatcher = hs.application.watcher.new(applicationWatcher):start()
hotkeys:enter()

function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

local reloadWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
