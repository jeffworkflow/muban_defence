-- local ui            = require 'ui.client.util'
-- local game          = require 'ui.base.game'

local playermsg = {}

local game_ui = japi.GetGameUI()
--魔兽的提示框
local tsk = japi.FrameGetTooltip()
local new_ui = class.panel:builder
{
    x = 122,
    y = 206,
    w = 800,
    h = 425,
    is_show = true,
    level = 6,
    normal_image = [[]],
    
    --玩家发送消息
    sendMsg = function(self,str,time)
        if not self.tip then 
            self.tip = {} 
        end    
        
        local line_height = 30  --行高
        local font_size = 12  --字体大小
        if not str then return end
        local tt,cnt = string.gsub(str,'\n','\n')
        for s in string.gmatch(str, '[^\r\n]+') do 
            local ts = clean_color(s)
            cnt = cnt + get_len(ts)*font_size / self.w 
            -- print(get_len(ts),get_len(ts)*font_size,cnt)
        end

        local off_line_height = math.floor(cnt or 0) * line_height
        -- print('行高',math.floor(cnt or 0),off_line_height)
        local temp_offlineheight = off_line_height
        for i,tip in ipairs(self.tip) do
            if i <=15 then 
                -- temp_offlineheight = temp_offlineheight + (self.tip[i].off_line_height or 0)
                -- tip:set_position(0,self.h - (i*line_height) - temp_offlineheight)
                tip:set_position(0,tip.y - temp_offlineheight -line_height)
            else 
                tip:destroy()
                table.remove(self.tip,i)
            end        
        end     

        -- 层级需要改变下。
        local no_color_str = clean_color(str)
        local shadow = self:add_text(no_color_str,0,self.h - off_line_height,self.w,125,font_size,'auto_newline')
        -- print(no_color_str)
        shadow:set_color(0Xff000000)

        local tip = shadow:add_text(str,-2,-2,self.w,125,font_size,'auto_newline')
        shadow.tip = tip
        shadow.off_line_height = off_line_height
        shadow:set_time_ex(time or 60) --默认销毁时长
        table.insert(self.tip,1,shadow)
        -- print(tip.w,tip.h)

        -- for i,tip in ipairs(self.tip) do 
        --     print(i,tip:get_text())
        -- end    
    end,
    clearMsg = function(self)
        for i,tip in ipairs(self.tip) do
            tip:set_text('')
            tip.tip:set_text('')
        end
    end
}
ac.wait(0,function()
-- local pannel = class.playermsg.get_instance()
-- pannel:set_level(6)
function ac.player.__index:sendMsg(str,time)
    if self:is_self() then 
        new_ui:sendMsg(str,time)
    end    
end    
function ac.player.__index:sendMsg1(str,time)
    if self.flag_nd_text then 
        return
    end    
    if self:is_self() then 
        new_ui:sendMsg(str,time)
    end    
end    

function ac.player.__index:clearMsg()
    if self:is_self() then 
        new_ui:clearMsg()
    end    
end    
end)

-- text 扩展方法
function class.text:set_time_ex(time)
    -- print('扩展方法')
    game.wait(time * 1000,function ()
        --进行淡化
        game.timer(20,100,function(t)
            -- print((100-t.cnt)/100) 
            if t.count<=0 then 
                self:destroy()
                t:remove()
                return 
            end
            self:set_alpha((100-t.cnt)/100)
        end)
        -- ac.wait(2000,function()
        --     self:destroy()
        -- end)
    end)
end    
--#str 中文 3个字节 ，以下为 中文算2个字节
function get_len(str)
    local count = 0
    for uchar in string.gmatch(str, "([%z\1-\127\194-\244][\128-\191]*)") do 
      if #uchar ~= 1 then
        count = count +2
      else
        count = count +1
      end
    end 
    return count 
end    

