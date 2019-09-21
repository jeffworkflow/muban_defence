-- local ui            = require 'ui.client.util'
-- local game          = require 'ui.base.game'

local playermsg = {}

local game_ui = japi.GetGameUI()
--魔兽的提示框
local tsk = japi.FrameGetTooltip()

class.playermsg = extends(class.panel){
    create = function ()
        local w = 900 --宽度
        local h = 425 --高度
        local panel = class.panel.create('',122,206,w,h)
        panel.__index = class.playermsg
        panel.tip = {}
        panel.w=w
        panel.h=h

       
        return panel
    end,

    --玩家发送消息
    sendMsg = function(self,str,time)
        if not self.tip then 
            self.tip = {} 
        end    
        
        local line_height = 30  --行高
        local font_size = 14  --字体大小

        local tt,cnt = string.gsub(str,'\n','\n')
        -- for s in string.gmatch(str, '[^\r\n]+') do 
        --     local ts = s:gsub('|[cC]%w%w%w%w%w%w%w%w(.-)|[rR]','%1'):gsub('|n','\n'):gsub('\r','\n')
        --     print(get_len(ts),get_len(ts)*font_size)
        --     cnt = cnt + get_len(ts)*font_size / self.w 
        -- end

        local off_line_height = (cnt or 0) * line_height
        local temp_offlineheight = off_line_height
        for i,tip in ipairs(self.tip) do
            if i <=15 then 
                temp_offlineheight = temp_offlineheight + (self.tip[i].off_line_height or 0)
                tip:set_position(0,self.h - (i*line_height) - temp_offlineheight)
            else 
                tip:destroy()
                table.remove(self.tip,i)
            end        
        end     

        local tip = self:add_text(str,0,self.h - off_line_height,self.w,125,font_size,'auto_newline')
        tip.off_line_height = off_line_height
        tip:set_time_ex(time or 60) --默认销毁时长
        table.insert(self.tip,1,tip)
        -- print(tip.w,tip.h)

        -- for i,tip in ipairs(self.tip) do 
        --     print(i,tip:get_text())
        -- end    
    end,
}

local pannel = class.playermsg.get_instance()
function ac.player.__index:sendMsg(str,time)
    if self:is_self() then 
        pannel:sendMsg(str,time)
    end    
end    
function ac.player.__index:sendMsg1(str,time)
    if self:is_self() then 
        pannel:sendMsg(str,time)
    end    
end    

-- text 扩展方法
function class.text:set_time_ex(time)
    -- print('扩展方法')
    ac.wait(time * 1000,function ()
        --进行淡化
        ac.timer(20,100,function(t)
            -- print((100-t.cnt)/100) 
            self:set_alpha((100-t.cnt)/100)
        end)
        ac.wait(2000,function()
            self:destroy()
        end)
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

