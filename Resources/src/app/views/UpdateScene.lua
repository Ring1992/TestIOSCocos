local UpdateScene = class("UpdateScene", cc.load("mvc").ViewBase)
local UpdateManager = require "UpdateManager"

function UpdateScene:onCreate()
    self.updateView = UpdateManager.create(self)
        :addTo(self)
end

return UpdateScene