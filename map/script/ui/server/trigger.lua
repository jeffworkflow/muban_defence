local ui = require 'ui.server.util'
local unit = require 'types.unit'
local trg = CreateTrigger()
--注册同步事件
-- japi.RegisterMessageEvent(trg)
-- local function action() 
--     local message = japi.GetTriggerMessage()
--     local player = japi.GetMessagePlayer()
--     print(message:len(),message,player)
--     -- ac.player(GetPlayerId(player) + 1)
--     ui.on_custom_ui_event(ac.player(player + 1),message)
-- end

-- TriggerAddAction(trg,action)

--注册同步事件
japi.DzTriggerRegisterSyncData(trg,"ui",false)
TriggerAddAction(trg,function ()
    local message = japi.DzGetTriggerSyncData()
    local player = japi.DzGetTriggerSyncPlayer()
    -- print(message:len(),message,player)
    ui.on_custom_ui_event(ac.player(GetPlayerId(player) + 1),message)
end)