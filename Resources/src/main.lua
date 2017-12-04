
cc.FileUtils:getInstance():setPopupNotify(false)

require "util/tools"
require "config"
require "cocos.init"

local UpdateManager = require "UpdateManager"

local function main()
print("~~~~~~~~~~main~~~~~~~~~")
    cc.Director:getInstance():setDisplayStats(true)
    require("app.MyApp"):create():run("UpdateScene")

    --local scene = cc.Scene:create()
    --scene:addChild(UpdateManager.create())
    --cc.Director:getInstance():replaceScene(scene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
