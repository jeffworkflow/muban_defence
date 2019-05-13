local ui            = require 'ui.client.util'

--任务类 
task_class = nil

--任务类 具对象 负责 接收来自服务端的数据 跟 更新对应界面上的信息
task_class = {
    create = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then 
            return 
        end 


        task = {
            name        = name,                     --名字
            condition   = {},                       --条件
            complete_condition = data.Condition,    --完成条件
            control     = {},                       --显示该任务的控件表
            time        = 0,                        --时间
            finish      = false,                    --是否完成
            key_list    = {},                       --条件的键值列表
            data        = data,                     --数据表

        }

        setmetatable(task,{__index = task_class})
        for key,value in pairs(data.Condition) do
            task.condition[key] = 0
        end

        local map = {}
        local repl = function (str)
            if map[str] == nil then
                map[str] = 1
                table.insert(task.key_list,tonumber(str) or str)
            end
        end
        data.Descrbe:gsub("%$(.-)%$",repl)
        data.Tip:gsub("%$(.-)%$",repl)

        return task 
    end,

    remove = function (self,type)
        local panel = self.control[type]
        if panel ~= nil then 
            panel:destroy()
            self.control[type] = nil
        end 
    end,

    destroy = function (self)
        for type,panel in pairs(self.control) do 
            panel:destroy()
        end 
    end,

    get_name = function (self)
        return self.name
    end,

    get_type = function (self)
        return task_data_class.get_type(self.name)
    end,

    get_progress = function (self,key)
        return self.condition[key]
    end,

    get_time = function (self)
        return self.time 
    end,

    get_interval_type = function (self)
        return self.data.Interval
    end,

    get_title = function (self)
        if self:get_interval_type() ~= nil then 
            return '[' .. self:get_interval_type() .. '] ' ..self.name
        end 
        return '[' .. self:get_type() .. '] ' ..self.name
    end,

    --获取当前进度
    get_progress = function (self)
        local current_value = 0
        local max_value = 0 
        for key,value in pairs(self.complete_condition) do 
            current_value = current_value + self.condition[key] 
            max_value = max_value + value 
        end 
        return current_value,max_value
    end,

    --获取当前进度提示文本
    get_progress_tip = function (self)
        local tip_str = ''
        for index,str in ipairs(self.key_list) do
            local num = self.condition[str] or 0
            local max = self.complete_condition[str] or 0
            local s = string.format(" %s:(%d/%d) ",str,num,max)
            tip_str = tip_str .. s
        end
        tip_str:gsub('|',' 或 ')
        return tip_str
    end,

    get_descrbe = function (self)
        local repl = function (key)
            if key:len() < 3 then 
                return ''
            end
            key = key:sub(2,key:len()-1)
            if tonumber(key) ~= nil then 
                key = tonumber(key)
            end
            local current = self.condition[key]
            local max  = self.complete_condition[key]
            return table.concat({'(',tostring(current),'/',tostring(max),')'})
        end
        local descrbe = self.data.Descrbe:gsub('(%b$$)',repl)
        local tip = self.data.Tip:gsub('(%b$$)',repl)
        return descrbe,tip
    end,

    set_time = function (self,time,current_time)
        self.time = time 
    end,

    set_complete = function (self)
        if self.finish == true then 
            return 
        end 
        self.finish = true 
        for key,value in pairs(self.complete_condition) do
            self.condition[key] = value
        end
        for type,panel in pairs(self.control) do 
            panel:set_complete()
        end 
    end,



    set_condition = function (self,key,value)
        if self.name == nil then 
            return
        end
        self.condition[key] = value
        local complete = true
        for key,value in pairs(self.condition) do
            if self.complete_condition[key] ~= nil and value < self.complete_condition[key] then 
                complete = false
                break
            end
        end

        if complete == true then
            self:set_complete()
        else
            self.finish = false 
            for type,panel in pairs(self.control) do 
                panel:set_condition(key,value)
            end 
        end 

    end,

}




task_data_class = {
    info_table = {},
    get_task_data = function (name)
        local data_table = ac.table.TaskData
        return data_table[name]
    end,
    compile_string = function (str)
        if str == nil then
            return nil
        end
        str = str:gsub('<#([%x%X]-):',function (hex)
            return "<font color='#"..hex.."'>"
        end)
        str = str:gsub(':>','</font>')
        return str
    end,
    get_type = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then
            return nil
        end
        return data.TaskType or ''
    end,

    get_descrbe = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then
            return nil
        end
        return data.Descrbe--task_data_class.compile_string(data.Descrbe)
    end,
    
    get_tip = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then
            return nil
        end
        return task_data_class.compile_string(data.Tip)
    end,

    get_reward_table = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then
            return nil
        end
        return data.Reward
    end,

    get_condition = function (name)
        local data = task_data_class.get_task_data(name)
        if data == nil then
            return nil
        end
        return data.Condition
    end,
}



taskbar.task_map = {}


taskbar.event = {
    on_create_task = function (name)

        --创建任务数据 并添加给对应的界面控件
        local task = taskbar.task_map[name] or task_class.create(name)
        if task ~= nil then 
            taskbar.task_map[name] = task 
           
            --显示在 屏幕右方的任务栏UI中
            taskbar.task_button_class.create(task)
              
            --显示在 屏幕右方的提示面板中
            taskbar.task_tip_button_class.create(task)
        end 
        
    end,

    on_remove_task = function (name)
        local task = taskbar.task_map[name]
        if task ~= nil then
            task:destroy()
            taskbar.task_map[name] = nil
        end
    end,

    on_set_complete = function (name)
        local task = taskbar.task_map[name]
        if task ~= nil then
            task:set_complete()
        end
    end,
    on_set_time = function (name,time,current_time)
        local task = taskbar.task_map[name]
        if task ~= nil then
            task:set_time(time,current_time)
        end
    end,

    on_set_condition = function (name,key,value)
        local task = taskbar.task_map[name]
        if task ~= nil then
            task:set_condition(key,value)
        end
    end,
    
    on_show_task = function (name)
        if taskbar.ui.is_show == false then
            taskbar.ui:show()
        end
        taskbar.ui:show_task(name)
    end,

}

local ALT = false 


taskbar.on_key_down = function (code)
    local object = taskbar.ui
    

    if code == KEY.X then
        local info = {
            type = 'taskbar',
            func_name = 'demo_x',
        }
        ui.send_message(info)
    elseif code == KEY.Z then
        local info = {
            type = 'taskbar',
            func_name = 'demo_z',
        }
        
        ui.send_message(info)    
    end

    
    if code == KEY.ALT then 
        ALT = true 
    elseif code == KEY.ESC then 
        taskbar.ui:hide()
    end 
    if code == KEY.F and ALT then 
        if taskbar.ui.is_show then 
            taskbar.ui:hide()
        else 
            taskbar.ui:show()
        end 
    end 
    
end

taskbar.on_key_up = function (code)
    if code == KEY.ALT then 
        ALT = false 
    end 
end 

game.register_event(taskbar)--注册事件
ui.register_event('taskbar',taskbar.event)
