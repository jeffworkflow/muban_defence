local ui = require 'ui.server.util'
local unit = require 'types.unit'
local japi = require 'jass.japi'
local trg = CreateTrigger()

register_japi[[
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing
    native DzSyncData takes string prefix, string data returns nothing
    native DzGetTriggerSyncData takes nothing returns string
    native DzGetTriggerSyncPlayer takes nothing returns player
]]

if japi.GetGameVersion() >= 7000 and japi.DzTriggerRegisterSyncData then 

    local SendCustomMessage = japi.SendCustomMessage

    rawset(japi,'SendCustomMessage', function (msg)
        japi.DzSyncData('ui', msg)
    end)

    japi.DzTriggerRegisterSyncData(trg, 'ui', false)
    TriggerAddAction(trg,function ()
        local message = japi.DzGetTriggerSyncData()
        local player = japi.DzGetTriggerSyncPlayer()
        -- print('网易同步',GetPlayerId(player) + 1, message)
        ui.on_custom_ui_event(player,message)
    end)

else 
    --注册同步事件
    japi.RegisterMessageEvent(trg)
    TriggerAddAction(trg,function ()
        local message = japi.GetTriggerMessage()
        local player = japi.GetMessagePlayer()
        -- print('自定义同步',GetPlayerId(player) + 1, message)
        ui.on_custom_ui_event(player,message)
      
    end)
end 


