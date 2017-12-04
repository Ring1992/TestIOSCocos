local MainScene = class("MainScene", cc.load("mvc").ViewBase)


function MainScene:onCreate()
    -- add background image
    display.newSprite("background/bg.png")
        :move(display.center)
        :addTo(self)

    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    local progress = cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    print("~~~~~~~~~~~~~~~~~~")
    print(display.size)
    print(display.size.width)
    print(display.size.height)
    print("~~~~~~~~~~~~~~~~~~")
    printTable(display.size)
end

return MainScene
