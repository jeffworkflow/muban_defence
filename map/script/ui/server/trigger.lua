local ui = require 'ui.server.util'
local trg = CreateTrigger()


--注册同步事件
japi.RegisterMessageEvent(trg)
TriggerAddAction(trg,function ()
    local message = japi.GetTriggerMessage()
    local player = japi.GetMessagePlayer()
    print(message:len(),message,player)
  
    ui.on_custom_ui_event(player,message)
end)
