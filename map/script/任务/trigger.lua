--该文件为 任务的触发器模板 

local tbl = {}

tbl['移动到引导坐标'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then  
        return 
    end 
    local guide = self.data.Guide 
    if guide == nil then 
        return 
    end 

    local loc = guide['未完成']
    if loc == nil then 
        return 
    end 
    local point = ac.point(loc[1],loc[2])
    self.move_timer = ac.loop(500,function ()
        if hero:get_point() * point < 300 then 
            self:set_complete()
            if self.move_timer then 
                self.move_timer:remove()
                self.move_timer = nil
            end
        end 
    end)
end

tbl['击杀指定单位'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = ac.game:event '单位-死亡' (function (_,unit,killer)
        if killer == nil or killer:get_owner() ~= self.player then 
            return 
        end 
        local name = unit:get_name()
        for key,value in pairs(self.data.Condition) do 
            if key:find(name) ~= nil or key == name then 
                self:add_progress(key,1)
            end 
        end 
    
    end)
    
    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg2:remove()
        end 
    end)
end



tbl['击杀任意单位'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = ac.game:event '单位-死亡' (function (_,unit,killer)
        if killer == nil or killer:get_owner() ~= self.player then 
            return 
        end 
        local name = hero:get_name()
        for key,value in pairs(self.data.Condition) do 
            self:add_progress(key,1)
        end 
    
    end)

    
    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg2:remove()
        end 
    end)
end


tbl['参与击杀指定单位'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = hero:event '造成伤害' (function (_,damage)
        local target = damage.target
        local name = target:get_name()

        local damage_source_list = target.damage_source_list or {}
        target.damage_source_list = damage_source_list
        damage_source_list[hero] = true
           
    
    end)

    self._trg1 = ac.game:event '单位-死亡' (function (_,unit,killer)
        local list = unit.damage_source_list
        local name = unit:get_name()
        if list == nil then 
            return 
        end 
    
        if list[hero] then 
            for key,value in pairs(self.data.Condition) do 
                if key:find(name) ~= nil or key == name then 
                    self:add_progress(key,1)
                end
            end 
        end 
    end)

    
    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg1:remove()
            self._trg2:remove()
        end 
    end)
end



tbl['参与击杀任意单位'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = hero:event '造成伤害' (function (_,damage)
        local target = damage.target
        local name = target:get_name()

        local damage_source_list = target.damage_source_list or {}
        target.damage_source_list = damage_source_list
        damage_source_list[hero] = true
           
    
    end)

    self._trg1 = ac.game:event '单位-死亡' (function (_,unit,killer)
        local list = unit.damage_source_list
        local name = unit:get_name()
        if list == nil then 
            return 
        end 
    
        if list[hero] then 
            for key,value in pairs(self.data.Condition) do 
                self:add_progress(key,1)
            end 
        end 
    end)


    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg1:remove()
            self._trg2:remove()
        end 
    end)
end



tbl['获得指定数量物品'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = ac.game:event '背包-添加物品' (function (_,unit,item,count)
        if item.unit ~= hero then
            return
        end 
        local name = item:get_name()
        for key,value in pairs(self.data.Condition) do 
            if key:find(name) ~= nil or key == name then 
                self:add_progress(key,math.max(1,count))
            end 
        end 
    end)


    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg2:remove()
        end 
    end)
end


tbl['完成指定任务'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = ac.game:event '任务-完成' (function (_,task)
        if task.player ~= self.player then
            return
        end 
        local name = task:get_name()
        for key,value in pairs(self.data.Condition) do 
            if key:find(name) ~= nil or key == name then 
                self:add_progress(key,1)
            end 
        end 
    end)

    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg2:remove()
        end 
    end)
end


tbl['提交指定任务'] = function (self)
    local hero = self.player:get_hero()
    if hero == nil then 
        return 
    end 
    self._trg = ac.game:event '任务-提交' (function (_,task)
        if task.player ~= self.player then
            return
        end 
        local name = task:get_name()
        for key,value in pairs(self.data.Condition) do 
            if key:find(name) ~= nil or key == name then 
                self:add_progress(key,1)
            end 
        end 
    end)

    self._trg2 = ac.game:event '任务-删除' (function (_,task)
        if task == self then 
            self._trg:remove()
            self._trg2:remove()
        end 
    end)
end

--注册触发器
ac.game:event'任务-添加' (function (trg,task)
    
    local trg = task.data.Trigger 
    if trg == nil then 
        return 
    end 

    local func = tbl[trg]
    if func == nil then 
        return 
    end 
    --if task.data.TaskType == '支线' then 
        task.__trg = ac.game:event '任务-提交' (function (_,task2)
            if task == task2 then 
                task:get_reward()
            end 
        end)
    --end
    func(task)
   
end)

ac.game:event'任务-引导' (function (trg,task)
    local guide = task.data.Guide 
    if guide == nil then 
        return 
    end 
    local loc 
    if task.finish then 
        loc = guide['完成']
    else 
        loc = guide['未完成']
    end 
    if loc == nil then 
        return 
    end 
    local hero = task.player:get_hero()
    if hero == nil then 
        return 
    end 
    
    hero:issue_order('move',ac.point(loc[1],loc[2]))
end)