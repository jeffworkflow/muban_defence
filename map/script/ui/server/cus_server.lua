local ui = require 'ui.server.util'

local cundang = {}
cundang.event = {
    tongbu = function(id,value)
        local p = ac.player(id)
        local value = tostring(value)
    end,
}

s_ui.yanzheng = function()
    local info = {
        type = 'cundang',
        func_name = 'yibu',
        params = {
            [1] = 1,
        }
    }
    ui.send_message(nil,info)
end
ui.register_event('cundang',cundang.event)