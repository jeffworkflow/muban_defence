local i = 0
local event = {
    --1秒60帧，没帧调用一次on_update
--    on_update = function ()
--     i = i + 1 
--     print('on_update:',i)
--    end ,
   on_mouse_up = function()
    local current_time = ac.clock()
    ac.player.self.last_click_time = ac.player.self.last_click_time or 0
    local time = current_time - ac.player.self.last_click_time
    if time < 15 then
        -- print('小于50')
        return true
    end
    ac.player.self.last_click_time = current_time
end,
}
if not global_test then 
    ac.wait(5*60*1000,function()
        game.register_event(event)
    end)
end
-- local time = 1/60
-- local tx = 0
-- ac.loop(time*1000,function()
--     tx = tx + 1
--     print('ac.loop:',tx)
-- end)


