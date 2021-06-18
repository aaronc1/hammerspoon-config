hs.loadSpoon("SpoonInstall")
hs.application.enableSpotlightForNameSearches(true)

-- Faster window animation
hs.window.animationDuration = 0


DefaultBrowser = "com.google.Chrome"
FirefoxBrowser = "org.mozilla.firefoxdeveloperedition"
spoon.SpoonInstall:andUse("URLDispatcher",
               {
                 config = {
                   url_patterns = {
                     { "https?://admin.esalon.com",         FirefoxBrowser },
                     { "https?://reports.%a*.?esalon.com",         FirefoxBrowser },
                     { "https?://www%d*.%a+.?esalon.com",         FirefoxBrowser },
                     { "https?://www%d*.%a+.?colorsmith.co",         FirefoxBrowser },
                     { "https?://www%d*.%a+.?aurahaircare.com",         FirefoxBrowser },
                     { "https?://admin%d*.%a+.?esalon.com",         FirefoxBrowser },
                   },
                   default_handler = DefaultBrowser
                 },
                 start = true
               }
)



term_windows = hs.application.find('iterm2'):allWindows()
first_term = term_windows[1]:id()
second_term = term_windows[2]:id()
function term_geo(window)
  local numScreens = #hs.screen.allScreens()
  if numScreens == 2 then
    if window:id() == first_term then
       return hs.geometry.rect(1980, 38, 840, 1396)
    elseif window:id() == second_term then
       return hs.geometry.rect(1200, 60, 780, 1371)
    end
  elseif numScreens == 1 then
    if window:id() == first_term then
       return hs.geometry.rect(700, 38, 740, 850)
    elseif window:id() == second_term then
       return hs.geometry.rect(1, 60, 700, 850)
    end
  end
end

--local desktopScreen = "DELL U2717D"
--local laptopScreen = "Built-in Retina Display"
local laptopScreen = hs.screen(69734208)
local desktopScreen = "G34WQC"
local dualLayout = {
--      {hs.application.find("slack"), nil, laptopScreen, nil, nil, hs.geometry.rect(-500, 300, 600, 600)},
--      {hs.application.find("slack"), nil, laptopScreen, hs.layout.left75, nil, nil},
      {hs.application.find("slack"), nil, laptopScreen, hs.geometry.rect(0, 0, 0.82, 1), nil, nil},
      {hs.application.find("microsoft teams"), nil, laptopScreen, hs.geometry.rect(0, 0, 0.82, 1), nil, nil},
--      {hs.application.find("signal"), nil, desktopScreen, nil, nil, hs.geometry.rect(1515, 30, 900, 822)},
      {hs.application.find("signal"), nil, laptopScreen, hs.layout.left75, nil, nil},
--      {hs.application.find("discord"), nil, desktopScreen, nil, nil, hs.geometry.rect(1515, 0, 1024, 822)},
      {hs.application.find("discord"), nil, laptopScreen, hs.layout.left75, nil, nil},
      {hs.application.find("chrome"), nil, desktopScreen, nil, nil, hs.geometry.rect(1200, 0, 1620, 1400)},
--      {hs.application.find("calculator"), nil, desktopScreen, nil, nil, hs.geometry.rect(2910, 530, 0, 0)},
      {hs.application.find("calculator"), nil, laptopScreen, hs.geometry.unitrect(0.83,0.65,0.20,0.35), nil, nil},
      {hs.application.find("evernote"), nil, desktopScreen, nil, nil, hs.geometry.rect(2417, 0, 1023, 762)},
      {hs.application.find("yt music"), nil, desktopScreen, nil, nil, hs.geometry.rect(2417, 0, 1023, 762)},
      {hs.application.find("iterm2"), nil, desktopScreen, nil, nil, term_geo},
      {hs.application.find("iterm2"), nil, desktopScreen, nil, nil, term_geo},
      {hs.application.find("textedit"), nil, desktopScreen, nil, nil, hs.geometry.rect(2826, 790, 484, 604)},
      {hs.application.find("firefox"), nil, desktopScreen, nil, nil, hs.geometry.rect(0,0,1200,1400)}
      -- {hs.application.find("firefox"), nil, laptopScreen, hs.layout.maximized, nil, nil},
}
local singleLayout = {
      {hs.application.find("slack"), nil, laptopScreen, nil, nil, hs.geometry.rect(0, 0, 960, 850)},
      {hs.application.find("discord"), nil, laptopScreen, nil, nil, hs.geometry.rect(0, 0, 960, 850)},
      {hs.application.find("chrome"), nil, laptopScreen, hs.layout.maximized, nil, nil},
      {hs.application.find("calculator"), nil, laptopScreen, nil, nil, hs.geometry.rect(1200, 580, 0, 0)},
      {hs.application.find("evernote"), nil, laptopScreen, nil, nil, hs.geometry.rect(800, 0, 900, 762)},
      {hs.application.find("iterm2"), nil, laptopScreen, nil, nil, term_geo},
      {hs.application.find("iterm2"), nil, laptopScreen, nil, nil, term_geo},
      {hs.application.find("textedit"), nil, laptopScreen, nil, nil, hs.geometry.rect(1200, 400, 4601, 604)},
      -- {hs.application.find("firefox"), nil, laptopScreen, hs.layout.maximized, nil, nil},
}


function switchLayout()
  local numScreens = #hs.screen.allScreens()
  local layout = {}
  if numScreens == 1 then
    layout = singleLayout
    hs.alert.show("Single screen");
  elseif numScreens == 2 then
    layout = dualLayout
    hs.alert.show("Dual screen");
  end
  hs.layout.apply(layout)
end


screenWatch = hs.screen.watcher.new(function ()
  switchLayout()
end)
screenWatch:start()




local mash_app = {"ctrl", "shift"}
hs.hotkey.bind({"cmd", "ctrl"}, "r", function()
  switchLayout()
end)
hs.hotkey.bind({"cmd", "ctrl"}, "e", function()
  hs.reload()
end)
hs.hotkey.bind(mash_app, "1", function() 
  --hs.application.launchOrFocusByBundleID("code.googlecode.iterm2")
  activateApp = false
  iterm_app = hs.application.find("iterm2")
  if (iterm_app:isFrontmost() == true) then
    activateApp = true
  end
  hs.application.launchOrFocus("iterm")
  if (activateApp == true) then
    iterm_app:activate(true)
  end
end)
hs.hotkey.bind(mash_app, "2", function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind(mash_app, "3", function() hs.application.launchOrFocusByBundleID(FirefoxBrowser) end)
hs.hotkey.bind(mash_app, "4", function() 
  music_app = hs.application.find("YT Music")
  if (music_app:isFrontmost() == true) then
    hs.application.launchOrFocus("spotify")
  else
    hs.application.launchOrFocus("YT Music")
  end
end)
hs.hotkey.bind(mash_app, "5", function() 
  hs.application.launchOrFocus("Slack")
end)
hs.hotkey.bind(mash_app, "7", function() 
  hs.application.launchOrFocus("TextEdit")
  textedit_app = hs.application.find("textedit")
  textedit_app:selectMenuItem({"Window", "Bring All to Front"})
end)
hs.hotkey.bind(mash_app, "8", function() hs.application.launchOrFocus("Discord") end)
hs.hotkey.bind(mash_app, "9", function() hs.application.launchOrFocus("Evernote") end)
hs.hotkey.bind(mash_app, "0", function() hs.application.launchOrFocus("Signal") end)
hs.hotkey.bind(mash_app, "b", function() 
  output, status, t, rc = hs.execute("/usr/local/bin/blueutil -p")
  -- foo = hs.logger.new('test', 'debug')
  -- foo.d(output)
  output = tonumber(output)
  if (output == 1) then
    -- foo.d('here on')
    hs.execute("/usr/local/bin/blueutil -p 0")
    hs.alert.show("Bluetooth off");
  else
    -- foo.d('here off')
    hs.execute("/usr/local/bin/blueutil -p 1")
    hs.alert.show("Bluetooth on");
  end
end)

hs.hotkey.bind(mash_app, "=", function() hs.application.launchOrFocus("zoom.us") end)
blinkStatus = ""
hs.hotkey.bind(mash_app, "`", function()
    if blinkStatus == "" then
      hs.alert("Blink Red")
      blinkStatus = "red"
      hs.execute("curl 'http://localhost:8934/blink1/fadeToRGB?rgb=%23ff0000'")
    elseif blinkStatus == "red" then
      hs.alert("Blink Green")
      blinkStatus = "green"
      hs.execute("curl 'http://localhost:8934/blink1/fadeToRGB?rgb=%2300ff00'")
    elseif blinkStatus == "green" then
      hs.alert("Blink Off")
      blinkStatus = ""
      hs.execute("curl 'http://localhost:8934/blink1/off'")
    end
end)
hs.hotkey.bind(mash_app, "t", function()
  resizewindowz("righthalf")
end)
hs.hotkey.bind(mash_app, "r", function()
  resizewindowz("rightthird")
end)
hs.hotkey.bind(mash_app, "e", function()
  resizewindowz("righthalf")
end)
hs.hotkey.bind(mash_app, "f", function()
  resizewindowz("full")
end)
hs.hotkey.bind(mash_app, "q", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)
hs.hotkey.bind(mash_app, "w", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.35
  f.h = max.h
  win:setFrame(f)
end)
hs.hotkey.bind(mash_app, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + ((max.w / 3) * 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w / 3
  f.h = max.h / 2
  win:setFrame(f)
end)
hs.hotkey.bind(mash_app, "z", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)
hs.hotkey.bind(mash_app, "n", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)
function resizewindowz(where)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local x = max.x
  local w = max.w
  if (where == "rightthird") then
    x = max.x + ((max.w / 3.2) * 2)
    w = max.w / 2.7
  end
  if (where == "righthalf") then
    x = max.x + (max.w / 2)
    w = max.w / 2
  end
  f.x = x
  f.y = max.y
  f.w = w
  f.h = max.h
  win:setFrame(f)
end
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

function turnOnBlink()
  hs.alert.show("Blink On")
  hs.execute("curl 'http://localhost:8934/blink1/fadeToRGB?rgb=%23ffcc00'")
end

function turnOffBlink()
  hs.alert.show("Blink Off")
  hs.execute("curl 'http://localhost:8934/blink1/off'")
end

--[[
function sleepWatch(eventType)
  local action = "unknown"
  foo = hs.logger.new('test', 'debug')
  if (eventType == hs.caffeinate.watcher.systemWillSleep) then
    hs.execute("/usr/local/bin/blueutil -p 0")
    foo.d('Bluetooth off')
  elseif (eventType == hs.caffeinate.watcher.systemDidWake) then
    hs.execute("/usr/local/bin/blueutil -p 1")
    foo.d('Bluetooth on')
  end
end
local sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()
--]]

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
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


updateZoomStatus = function(event)
  hs.printf("updateZoomStatus(%s)", event)
  if (event == "from-running-to-meeting") then
     hs.execute("curl 'http://localhost:8934/blink1/fadeToRGB?rgb=%23ff0000'")
  elseif (event == "from-meeting-to-running") or (event == "from-running-to-closed") then
     hs.execute("curl 'http://localhost:8934/blink1/off'")
  end
end

hs.loadSpoon("Zoom")
spoon.Zoom:setStatusCallback(updateZoomStatus)
spoon.Zoom:start()


--[[ Show all running applications in console
hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:name()) end)
--]]
