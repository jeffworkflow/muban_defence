

--排行榜中的 每一个项
class.rank_item = extends(class.panel){
    new = function (parent,x,y,width,height)

        local image = 'image\\排行榜\\background.tga'

        local panel = class.panel.new(parent,'',x,y,width,height)
        local background = panel:add_texture(image,0,0,width,height)
        background:set_alpha(0.6)

        panel.icon = panel:add_button('',8,8,54,48)

        panel.name_text = panel:add_text('阿达萨达',64,4,136,32,12,'center')

        panel.level_text = panel:add_text('段位1级',108,32,100,20,10,'left')
        panel.level_text:set_color(0xffa0a0a0)

        panel.level_icon = panel:add_texture('x.blp',72,32,24,24)

        local progress = panel:add_texture('image\\排行榜\\progress.tga',0,height - 16,width,16)
        progress:set_alpha(0.8)

        progress.black = progress:add_texture('bar_cover.tga',0,0,0,progress.h)

        progress.text = panel:add_text('100%',progress.x,progress.y,progress.w,progress.h,10,'right')
        
        panel.progress = progress

        panel.__index = class.rank_item

        return panel
    end,

    set_value = function (self,value,max_value)
        local rate
        if max_value == 0 then 
            rate = 0 
        else 
            rate = value / max_value 
        end 
		local str = string.format('%.0f%%',rate * 100 )
        self.progress.text:set_text(str)
        self.rate = rate 
        if rate >= 1 then rate = 0.9999 end 
        if rate <= 0 then 
            rate = 0.0001
        end 

        local width = self.w * rate
        local texture = self.progress.black
		texture:set_control_size(self.w - width ,texture.h)
    end,

    set_name = function (self,name)
        self.name = name 
        self.name_text:set_text(name)
    end,

    set_level = function (self,level)
        local data = ac.table.item['棋子等级数据']
        local info = data[level] or data[1]

        self.level_text:set_text(info.name)
        self.level_icon:set_normal_image(info.icon)
    end,

    set_icon = function (self,path)
        self.icon:set_normal_image(path)
    end,

    set_hero = function (self,hero)
        local player = hero:get_owner()
        self.hero = hero 

        self:show()
        self:set_name(player:get_name())
        self:set_level(player:get_level())
        self:set_icon(hero:get_art())
        self:set_value(hero:get('生命'),hero:get('生命上限'))
    end,

    update = function (self)
        local hero = self.hero 
        if hero == nil then 
            return 
        end 

        self:set_value(hero:get('生命'),hero:get('生命上限'))
    end,
    

    on_button_clicked = function (self,button)
        local hero = self.hero 
        if hero == nil then 
            return 
        end 

        if button == self.icon then 
            local player = hero:get_owner()
            ac.player.self:setCamera(player:get_board_camera_point())
            --并且响应选择单位事件
			ClearSelection()
			SelectUnit(hero.handle,true) 

        end

    end,

    on_button_mouse_enter = function (self,button)
        local hero = self.hero 
        if hero == nil then 
            return 
        end
        if button == self.icon then 
            self:tooltip(hero:get_name(),'点击查看该玩家的棋局战况。',1,200,64)
        end
    end,

}

--排行面板
class.rank_panel = extends(class.panel){
    create = function ()
        local panel = class.panel.create('',1920-200,100,200,800)
        panel.__index = class.rank_panel

        panel.list = {}
        for i=1,8 do 
            local x,y = 0, (i - 1) * 100
            local item = panel:add_rank_item(0,y,200,80)
            item:hide()

            panel.list[i] = item       
        end 

        return panel
    end,


    set_hero_list = function (self,list)
        self.hero_list = list
        self:update(true)
    end,


    update = function (self,not_sort)
        if self.hero_list == nil then 
            return 
        end 

        if not_sort ~= true then 
            table.sort(self.hero_list,function (a,b)
                local rate_a = a:get('生命') / a:get('生命上限')
                local rate_b = b:get('生命') / b:get('生命上限')
                return rate_a > rate_b
            end)
        end
        for index,item in ipairs(self.list) do 
            local hero = self.hero_list[index]
            if hero then 
                item:set_hero(hero)
            else 
                item.hero = nil
                item:hide()
            end 
        end 
    end,

}


local panel = class.rank_panel.create()


ac.game:event '游戏开始' (function()
    ac.wait(1000,function ()
        
        local hero_list = {}
        for i=1,8 do 
            local player = ac.player(i)
            local hero = player:get_hero()
            if hero then 
                table.insert(hero_list,hero)
            end 
        end 
        panel:set_hero_list(hero_list)
        
    end)
end)

ac.game:event '玩家-受击' (function()
    panel:update()

end)