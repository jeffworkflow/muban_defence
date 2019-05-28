local slk = require 'jass.slk'

class.actor = extends(class.model){

    new = function (parent,name,x,y)
        local data = nil
        --ac.table.model[name]
        local path = ''
        if data then 
            path = data.screen
        end 

        local model = class.model.new(parent,path,x,y,32,32)
 
        model.__index = class.actor 

      
        model.size = 1
       
        model:set_actor(name)
        
        return model
    end,

    set_actor = function (self,name)
        if name == '' then 
            self:hide()
            return 
        end 

        local unit = ac.table.unit[name]
        if unit == nil then 
            print("单位表UnitData.ini没有该模型数据",name)
            self:hide()
            return 
        end

        local data = ac.table.model[unit.base_id or name]
        if data == nil then 
            print("模型表ModelData.ini没有该模型数据",name,debug.traceback())
            self:hide()
            return 
        end 
        local base = ac.table.unit[unit.base_id or name] or unit
        


        local info = slk.unit[base.id or ''] or {}
        self.data = data 
        self.unit = unit
        self.info = info 
        self:set_name(name)
        self:set_model(data.screen)
        self:set_size()
        self:set_model_offset(0,-(info.moveHeight or 0) / 2)
        self:set_rotate_x(270)
        self:set_rotate_y(280)
        
        self:set_team_color(ac.player.self:get() - 1)
        self:show()
        self:play_animation('stand')
    end,

    get_name = function (self)
        return self.name
    end,

    set_name = function (self,name)
        self.name = name 
    end,


    rate_map = {
        ['生命上限'] = 1,['基础攻击'] = 1,['攻击浮动'] = 1,['白字攻击max'] = 2
    },

    get = function (self,name)
        if self.unit == nil then 
            return 0 
        end

        local level = self:get_level()
        local value = self.unit.attribute[name] or 0
        local num = 1 
        local type = self.rate_map[name]
        if type then
            if level == 2 then 
                num = 2
            elseif level == 3 then 
                num = 4
            end

            if type == 2 then 
                value = self:get('基础攻击') + self:get('浮动攻击')
            end
        end
        return value * num
    end,

    get_level = function (self)
        if not self.unit then 
            return 0 
        end
        return self.unit.card_level or 0 
    end,

    level_color_map = {
        'A0A0A0',
        '5CACEE',
        '0000FF',
        'FF00FF',
        'FF7F50',
    },

    get_title = function (self)
        local level = self:get_gold()
        local color = self.level_color_map[level] or self.level_color_map[1]
        local s = {'|cff',color,self:get_name()}
        
        for i = 1,self:get_gold() do 
            s[#s + 1] = '★'
        end 
        s[#s + 1] = '|r'
        return table.concat(s)
    end,

    get_gold = function (self)
        if not self.unit then 
            return 0 
        end
        return self.unit.gold or 0
    end,

    get_gold_tip = function (self)
        return 'x ' .. self:get_gold()
    end,

    to_string = function (self,list)
        if list == nil then 
            return 
        end 

        local s = {}
        for index,name in ipairs(list) do 
            local data = ac.table.skill[name]
            if data then 
                s[#s + 1] = '|cff' .. (data.color or 'ffffff') 
                s[#s + 1] = name 
                s[#s + 1] = '|r '
            end 
        end
        return table.concat(s)
    end,

    get_race = function (self)
        if not self.unit then 
            return 
        end
        return self:to_string(self.unit.race)
    end,

    get_job = function (self)
        if not self.unit then 
            return 
        end
        return self:to_string(self.unit.job)
    end,

    get_type_list = function (self)
        if not self.unit then 
            return 
        end
        local list = {}
        local race = self.unit.race
        if race then 
            for i,name in ipairs(race) do 
                list[#list + 1] = name 
            end 
        end 

        local job = self.unit.job
        if job then 
            for i,name in ipairs(job) do 
                list[#list + 1] = name 
            end 
        end 
        return list 
    end,

    get_type_tip = function (self)
        if not self.unit then 
            return ''
        end

        return self:get_race() .. self:get_job()
    end,

    set_size = function (self,size)
        if self.info == nil then 
            self.size = size 
            return 
        end
        local scale = self.info.modelScale or 1
        self.size = size or self.size
        class.model.set_size(self,0.001 * scale * self.size)
    end,

    --播放动画 动画名 是否附带alternate swim动画链接名
    play_animation = function (self,name,has_state)
        name = name:lower()
        local animation = self.data.animation
        local info = animation[name]
        if info then 
            self:set_animation_by_index(info.index)
        else 
            local list = {}
            for animate,info in pairs(animation) do 
                if animate:find(name) then 
                    local value = {
                        animate = animate,
                        info = info,
                    }
                    if animate:find('alternate') or animate:find('swim')  then 
                        if has_state then 
                            table.insert(list,value)
                        end 
                    else 
                        table.insert(list,value)
                    end 
                   
                end 
            end 
            table.sort(list,function (a,b)
                return a.animate:len() < b.animate:len()
            end)
            if #list > 0 then 
                local info = list[1].info
                self:set_animation_by_index(info.index)
            end 
        end 
    end,


    

}