

class.screen_button = extends(class.button){
    new = function (parant,x,y,info)
        local button = class.button.new(parant,info.path,x,y,84,84)
        button.tx_name = button:add_text(info.name,0,64,84,84,12,'center')
        button.tx_name:set_color(0xffff0000)
        button.__index = class.screen_button

        button.info = info 
        return button
    end,
    fresh_name = function(self)
        --处理 在线奖励 
        local total_time = 300 
        ac.loop(1000,function(t)
            --modify by jeff 
            total_time = total_time - 1
            local str = os.date("!%H:%M:%S", total_time)
            self.tx_name:set_text(str)
            if total_time == 0  then
                --发送文字
                ac.player.self:sendMsg('|cffffe799【系统消息】|r游戏开局已过5分钟 |cff00ffff所有玩家|r获得|cffff0000可存档属性攻击减甲+1|r 按F4可查看全部存档属性')
                for i=1,10 do 
                    local p = ac.player(i)
                    if p:is_player() then 
                       if p.hero then p.hero:add('攻击减甲',1) end 
                       p:Map_AddServerValue('gjjj',1) --保存存档
                    end       
                end    
                self:destroy()
                t:remove()
            end
        
        end)
    end,    

    on_button_clicked = function (self)
        if self.info then 
            local key = self.info.key
            japi.SendMessage(0x100,KEY[key],0)
            japi.SendMessage(0x101,KEY[key],1)
        end
    end,

    on_button_mouse_enter = function (self)
        if self.info then 
            if self.info.name == '神奇的五分钟' then 
                self:tooltip('|cffffe799神奇的五分钟|r',self.info.tip,-1,300,84)

            else
                self:tooltip(self.info.name,self.info.tip,0,200,84)
            end    

        end
    end,
}


local ui_info = {
    {
        name = nil,  
        path = 'image\\控制台\\F2_home.blp',
        key = 'F2', 
        tip = "F2回城"
    },
    {
        name = nil,  
        path = 'f3_liangongfang.blp',
        key = 'F3', 
        tip = "F3进入练功房"
    },
    {
        name = '神奇的五分钟',  
        path = 'wfz.blp',
        -- key = 'F3', 
        tip = "|cff00ff00开局五分钟自动获得|cffff0000攻击减甲+1 （可存档）|r|n|cffcccccc上限受地图等级影响|r",
        x = 1800,
        y = 538
    },

}

for index,info in ipairs(ui_info) do 
    local button 
    if info.x and info.y then 
        button = class.screen_button.create(info.x,info.y,info)
    else      
        button = class.screen_button.create(10,50 + index*84*1.2,info)
    end    
    if info.name =='神奇的五分钟' then 
        button:fresh_name()
    end    
end 