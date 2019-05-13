local ui = require 'ui.server.util'
local event = require 'ui.server.event.task'
local taskbar = {}

local task_class 


task_class = {
    create = function (player,name)
        local data = Table.TaskData[name]
        if data == nil then 
            print(name,'添加任务失败，任务数据不存在')
            return 
        end 
        local task_map = player.task_map or {}
        player.task_map = task_map

        if task_map[name] ~= nil then 

            print(name,'任务已存在，不可重复创建')
            return 
        end 

        local task = {
            player      = player, --任务所属玩家
            name        = name,   --任务名字
            time        = 0,      --时间
            finish      = false,  --是否完成
            condition   = {},     -- 任务当前条件进度
            complete_condition = {},-- 完成任务所需条件
            data        = data,
        }

        for key,value in pairs(data.Condition) do 
            task.condition[key] = 0
            task.complete_condition[key] = value
        end 

        local mt = japi.task[name]
        setmetatable(mt,{__index = task_class})
        setmetatable(task,{__index = mt})

        local path = '任务\\' .. task:get_type() .. '\\' .. task:get_name()
        pcall(require,path)

        task_map[name] = task

        local info = {
            type = 'taskbar',
            func_name = 'on_create_task',
            params = {
                [1] = name,
            }
        }
        ui.send_message(task.player,info)

        event.on_add_task(task)
        return task 
    end,

    destroy = function (self)
        if self.is_delete == true then 
            return 
        end 
        event.on_remove_task(self)

        local info = {
            type = 'taskbar',
            func_name = 'on_remove_task',
            params = {
                [1] = self.name,
            }
        }
        ui.send_message(self.player,info)
        if self._timer then 
            self._timer:remove()
            self._timer = nil
        end 
        self.player.task_map[self.name] = nil 
        self.is_delete = true
    end,

    get_name = function (self)
        return self.name 
    end,

    get_type = function (self)
        return self.data.TaskType
    end,

    --获取进度
    get_progress = function (self,key)
        return self.condition[key]
    end,

    --增加进度
    add_progress = function (self,key,value)
        local progress = self:get_progress(key)
        if progress ~= nil then 
            self:set_condition(key,progress + value)
        end 
    end,

    --设置完成
    set_complete = function (self)
        if self.is_delete then 
            return 
        end 

        if self.finish then 
            return 
        end 

        self.finish = true 

        local info = {
            type = 'taskbar',
            func_name = 'on_set_complete',
            params = {
                [1] = self.name,
            }
        }
        ui.send_message(self.player,info)
        event.on_finish_task(self)


        local hero = self.player:get_hero()
        local submit = self.data.Submit
        if submit == nil or hero == nil then 
            return
        end
        --如果提交参数是 坐标 则开启计时器 判断是否进入该区域
        if type(submit) == 'table' then 
            local loc = ac.point(submit[1],submit[2])
            self._timer = ac.loop(500,function ()
                if hero:get_point() * loc < 300 then 
                    self._timer:remove()
                    self._timer = nil
                    event.on_submit_task(self)
                end 
            end)
        --如果提交参数是 字符串 则代表是单位名字 循环遍历周围是否有该npc
        elseif type(submit) == 'string' then 
            self._timer = ac.loop(500,function ()
                for _, u in ac.selector()
                    : in_range(hero:get_point(), 300)
                    : ipairs()
                do
                    if u:get_name() == submit then 
                        self._timer:remove()
                        self._timer = nil
                        event.on_submit_task(self)
                        break
                    end 
                end 
            end)
        end 
    end,

    --设置条件
    set_condition = function (self,key,value)
        value = math.min(value,self.complete_condition[key]) 
        self.condition[key] = value
        local finish = true 
        for key,value in pairs(self.complete_condition) do 
            if self.condition[key] < value then 
                finish = false 
            else 
                self.condition[key] = value
            end 
        end 
        if finish then 
            self:set_complete()
        else 
            self.finish = false 
            local info = {
                type = 'taskbar',
                func_name = 'on_set_condition',
                params = {
                    [1] = self.name,
                    [2] = key,
                    [3] = value,
                }
            }
            ui.send_message(self.player,info)
        end 
    end,

    
    show_task = function (self)
        local info = {
            type = 'taskbar',
            func_name = 'on_show_task',
            params = {
                [1] = self.name,
            }
        }
        ui.send_message(self.player,info)
    end,

    --获取奖励
    get_reward = function (self)

        if self.finish ~= true then 
            return 
        end 
        local player = self.player

        local reward = self.data.Reward 
        if reward == nil then 
            print('数据表里没有奖励 获取失败',self.name)
            return 
        end 

        if player:get_hero() == nil then 
            print('当前玩家没有选择单位 奖励失败')
            return
        end 

        local state = reward['属性']
        if state ~= nil then 
            for key,value in pairs(state) do 
                local func = taskbar.reward_action[key]
                if func then 
                    func(self.player,key,value)
                end 
            end 
        end 

        local item_list = reward['道具']
        local unit = player:get_hero()
        if item_list ~= nil then 
            for name,count in pairs(item_list) do 
                unit:add_item(name,count)
            end 
        end 
        local next = self.data.Next 

        self:destroy()

        --得到奖励后 销毁任务 并添加下一个任务
        if next ~= nil then 
            player:add_task(next)
            ui.print(self.player,'完成',self.name,'新的任务',next)
        else 
            ui.print(self.player,'完成',self.name,'已获得全部奖励。')
        end 
    end,

}

taskbar.event = {

    task  = function (unit_handle,name_hash)
        local unit = ac.unit(ConvertAllianceType(unit_handle))
        if unit == nil then 
            return 
        end 
        local name = ui.get_str(name_hash)
        if name == nil then 
            print('该哈希值不存在，任务引导失败',name_hash)
            return 
        end 
    
        local dialog_map = unit.dialog_map or {}
        unit.dialog_map = dialog_map
        local player = ac.player(GetPlayerId(ui.player) + 1)
        

        dialog_map[name] = true 
        local self = player:add_task(name)
        if self  then 
            ac.game:event '任务-删除' (function (_,task)
                if task == self then 
                    dialog_map[task:get_name()] = nil
                end 
            end)
        end 
    end,

    guide = function (name_hash)
        local name = ui.get_str(name_hash)
        if name == nil then 
            print('该哈希值不存在，任务引导失败',name_hash)
            return 
        end 
        local player = ac.player(GetPlayerId(ui.player) + 1)

        local task = player:get_task(name)
        if task == nil then 
            print('任务不存在')
            return 
        end 

        event.on_guide_task(task)
    end,


    demo_x = function ()
        local player = ac.player(GetPlayerId(ui.player) + 1)
        if player.task_map == nil then 
            return 
        end 

        local task = player:get_task('测试的任务1')
        if task then 
            task:add_progress('x键',1)
        end 

        local task = player:get_task('测试的任务2')
        if task then 
            task:add_progress('x键',1)
        end 

        local task = player:get_task('测试的任务3')
        if task then 
            task:add_progress('x键',1)
        end 
   
    end,

    demo_z = function ()
        local player = ac.player(GetPlayerId(ui.player) + 1)
        if player.task_map == nil then 
            return 
        end 

        local task = player:get_task('测试的任务1')
        if task then 
            task:add_progress('z键',1)
        end 

        local task = player:get_task('测试的任务2')
        if task then 
            task:add_progress('z键',1)
        end 

        local task = player:get_task('测试的任务3')
        if task then 
            task:add_progress('z键',1)
        end 
   
    end,
}


taskbar.reward_action = {
    ['金钱'] = function (player,key,value)
        AdjustPlayerStateBJ( value, player.handle, PLAYER_STATE_RESOURCE_GOLD)
    end,

    ['经验'] = function (player,key,value)
        local unit = player:get_hero() 
        if unit ~= nil then 
            AddHeroXP( unit.handle, value, true )
        end 
    end,
}

taskbar.add_task = function (player,name)
    return task_class.create(player,name)
end


taskbar.get_task = function (player,name)
    if player.task_map == nil then 
        return 
    end 
    return player.task_map[name]
end 



taskbar.get_hero = function (player,unit)
    return player.hero
end

for i=1,12 do
    local player = ac.player(i)
    player.add_task = taskbar.add_task
    player.get_task = taskbar.get_task
    player.get_hero = taskbar.get_hero
end 


ui.taskbar = taskbar 


ui.register_event('taskbar',taskbar.event)

