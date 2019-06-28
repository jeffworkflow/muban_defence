require("平台.自定义服务器.cus_server")
-- require("平台.自定义服务器.黑名单")
require("平台.自定义服务器.排行榜")


-- local ui            = require 'ui.client.util'
-- local json = require 'util.json'
-- local player = require 'ac.player'

-- function player.__index:test_send_message()
--     local info = {
--         type = 'cus_server',
--         func_name = 'read_key_from_server',
--         params = {
--             [1] = '12131',
--         }
--     }
--     ui.send_message(info)
-- end    


-- local ui = require 'ui.server.util'
-- --处理同步请求
-- local event = {
--     --从自定义服务器读取数据
--     read_key_from_server = function (tab_str)
--         local player = ui.player   
--         print(player,tab_str)
--         player:event_notify('读取存档数据')

--     end,
-- }
-- ui.register_event('cus_server',event)

-- for i=1,10 do
--     local player = ac.player[i]
--     if player:is_player() then
--         if player:is_self() then 
--             player:test_send_message()
--         end    
--     end
-- end

