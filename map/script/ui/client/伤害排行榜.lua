

--排行榜中的 每一个项
class.dps_item = extends(class.panel){
    new = function (parent,x,y,width,height)

        local panel = class.panel.new(parent,'',x,y,width,height)

        panel.name_text = panel:add_text('阿达萨达',0,4,200,20,12,'left')
        
        local progress = panel:add_texture('image\\排行榜\\dps_progress.tga',0,height - 16,width,16)

        progress.text = progress:add_text('100%',progress.h,0,progress.w,progress.h,10,'left')
        progress.text:set_color(0xffa0a0a0)
        panel.progress = progress

        panel.__index = class.dps_item

        return panel
    end,

    set_value = function (self,value,max_value)
        local rate
        if max_value == 0 then 
            rate = 0 
        else 
            rate = value / max_value 
        end 
		local str = string.format('  dps (%.0f%%) dps %.0f',rate * 100 ,value)

        self.rate = rate 
        if rate >= 1 then rate = 0.9999 end 
        if rate <= 0 then 
            rate = 0.0001
        end 

        local width = self.w * rate
        local texture = self.progress
        local text = texture.text 

        texture:set_control_size(width,texture.h)
        
        text:set_text(str)
        text:set_position(texture.w,text.y)
    end,

    set_name = function (self,name)
        self.name = name 
        self.name_text:set_text(name)
    end,



}

--排行面板
class.dps_panel = extends(class.panel){
    create = function ()
        local panel = class.panel.create('',10,200,200,400)
        panel.__index = class.dps_panel

        panel.list = {}
        for i=1,10 do 
            local x,y = 0, (i - 1) * 50
            local item = panel:add_dps_item(0,y,200,40)
            item:hide()

            panel.list[i] = item       
        end 

        return panel
    end,


    -- list = { {name = name, damage = value} }
    set_dps_list = function (self,damage_list)
        

        local num = 0
        for i,info in pairs(damage_list) do 
            num = num + info.damage
        end 

        local list = {}
        for i,info in pairs(damage_list) do 
            table.insert(list,{
                name = info.name,
                value = info.damage,
                max_value = num,
            })
        end 

        self.dps_list = list

        self:update(true)
    end,


    update = function (self)
        if self.dps_list == nil then 
            return 
        end 
        self:show()
        
        table.sort(self.dps_list,function (a,b)
            return a.value > b.value
        end)
  
        for index,item in ipairs(self.list) do 
            local data = self.dps_list[index]
            if data then 
                item:show()
                item:set_name(data.name)
                item:set_value(data.value,data.max_value)
            else 
                item.data = nil
                item:hide()
            end 
        end 
    end,

}


local panel = class.dps_panel.create()

ac.game:event '战斗开始' (function()
    panel:hide()
end)

ac.game:event '战斗结束' (function()
    local data_list = ac.player.self.player_DPS_data
    print('DPS_data')
    for k,v in ipairs(data_list) do
        print(k,v)
    end
    if data_list then
        panel:set_dps_list(data_list)
    end 

end)


