local UpdateManager = {}
UpdateManager.__index = UpdateManager

local updateManifests = 
{
    "src/version/project.manifest",
}

local storagePaths = 
{
    "Download",
}

function UpdateManager.create(self)
    local layer = cc.Layer:create()
    local am = nil

    local function onEnter()
        local bg = display.newSprite("background_h.png")
        bg:move(display.center)
        layer:addChild(bg)

local btn_back = ccui.Button:create();
btn_back:loadTextures("Button_Common.png","Button_Common.png","",0);
btn_back:setPosition(cc.p(200,display.height-100))
btn_back:setTitleText("返回")
btn_back:setTitleFontSize(30)
btn_back:setTitleColor(ccc3(0,0,0))
layer:addChild(btn_back)
btn_back:setTouchEnabled(true)
local function clickBack(sender,eventType)
    if eventType == ccui.TouchEventType.ended then
        print("back~~~~~~~")

        local luaoc = require "cocos.cocos2d.luaoc"
        local args = {}
        local className = "Jumping"
        local ok,ret  = luaoc.callStaticMethod(className,"exitGame",args)
        if not ok then
            cc.Director:getInstance():resume()
        else
            print("The ret is:", ret)
            cc.Director:getInstance():endToLua()
            --os.exit()
        end
    end
end
btn_back:addTouchEventListener(clickBack)

        local  progress = cc.Label:create()
        progress:setSystemFontSize(40)
        progress:setTextColor(cc.c3b(255,255,255))
        progress:setPosition(cc.p(display.cx, display.cy))
        progress:setString("检查更新"..os.time())
        layer:addChild(progress)
        local storagePath = cc.FileUtils:getInstance():getWritablePath() .. storagePaths[1]
        am = cc.AssetsManagerEx:create(updateManifests[1],storagePath)
        print("storagePaths : "..storagePath)
        am:retain()

        local function UpdateFinished()
            progress:setString("100%")
        
            if not (cc.FileUtils:getInstance():isDirectoryExist(storagePath)) then         
                cc.FileUtils:getInstance():createDirectory(storagePath)
            end
            local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
            table.insert(searchPaths,1,storagePath .. '/')
            table.insert(searchPaths,2,storagePath .. '/res/')
            table.insert(searchPaths,3,storagePath .. '/src/')
            cc.FileUtils:getInstance():setSearchPaths(searchPaths)

            self:getApp():enterScene("MainScene")
        end
        
        local function onUpdateEvent(event)
            local eventCode = event:getEventCode()
            if eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_NO_LOCAL_MANIFEST then
                print("No local manifest file found, skip assets update.")
            elseif  eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_PROGRESSION then
                local assetId = event:getAssetId()
                local percent = event:getPercent()
                print("percent : " .. percent)
                local strInfo = ""

                if assetId == cc.AssetsManagerExStatic.VERSION_ID then
                    strInfo = string.format("Version file: %d%%", percent)
                elseif assetId == cc.AssetsManagerExStatic.MANIFEST_ID then
                    strInfo = string.format("Manifest file: %d%%", percent)
                else
                    strInfo = string.format("%d%%", percent)
                end
                progress:setString(strInfo)
            elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_DOWNLOAD_MANIFEST or eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_PARSE_MANIFEST then
                    print("Fail to download manifest file, update skipped.")
            elseif eventCode == cc.EventAssetsManagerEx.EventCode.ALREADY_UP_TO_DATE or eventCode == cc.EventAssetsManagerEx.EventCode.UPDATE_FINISHED then
                    print("Update finished.")
                    UpdateFinished()
            elseif eventCode == cc.EventAssetsManagerEx.EventCode.ERROR_UPDATING then
                    print("Asset ", event:getAssetId(), ", ", event:getMessage())
            end
        end
        local listener = cc.EventListenerAssetsManagerEx:create(am,onUpdateEvent)
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
        
        am:update()
    end

    local function onNodeEvent(event)
        if "enter" == event then
            onEnter()
        elseif "exit" == event then
            am:release()
        end
    end
    layer:registerScriptHandler(onNodeEvent)

    return layer
end

return UpdateManager
