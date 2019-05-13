local ui = require 'ui.server.util'
local kzt = {}

kzt.up_jingong_title = function (title)
    local info = {
        type = 'kzt',
        func_name = 'up_jingong_title',
        params = {
            [1] = title,
        }
    }
    ui.send_message(nil,info)
end

local function initialize()
    --保存到ac表中
    ac.ui.kzt = kzt
end

initialize()
return kzt