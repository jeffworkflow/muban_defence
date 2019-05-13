local ui            = require 'ui.client.util'
--屏幕右边的 任务提示面板
local task_tip_panel_class

--提示面板中的 提示按钮
local task_tip_button_class


--任务提示按钮类 用做 屏幕右方 提示面板中的 具任务UI对象
task_tip_button_class = extends(taskbar.task_button_class,{
    create = function (task)
        local panel = taskbar.tip_panel_ui

        local button = panel.button_map[task:get_name()]
        if button ~= nil then 
            return 
        end 

        button = panel:add_button('',0,0,panel.w - 32,58)

        button.task = task
        table.insert(task.control,button)
  
        button.title = button:add_text(task:get_title(),10,4,1000,16,16,'left')
        button.text = button:add_text(task:get_progress_tip(),10,30,1000,16,16,'left')
        
        extends(task_tip_button_class,button)

        button.slot_id = panel.count 
        panel.count = panel.count + 1
        panel.button_map[task:get_name()] = button 
        
        panel:sort_task()
        return button
    end,

    destroy = function (self)
        local panel = taskbar.tip_panel_ui
        if self.task == nil then 
            return 
        end 

        panel.button_map[self.task:get_name()] = nil 
        self.task = nil
        button_class.destroy(self)
        panel:sort_task()
    end,

    set_complete = function (self)
        self.text:set_text(self:get_progress_tip())
        self.text:set_color(220,230,50,1)
    end,

    set_condition = function (self,key,value)
        if self.task == nil then 
            return 
        end 
        self.text:set_color(255,255,255,1)
        self.text:set_text(self.task:get_progress_tip())
    end,


})

--任务提示面板类  创建在屏幕右方的面板 并负责处理 所有子成员 任务UI对象的消息处理
task_tip_panel_class = extends(panel_class,{
    create = function ()
        --屏幕右边的提示栏
        local path = 'image\\提示框\\256-256A.tga'
        local panel = panel_class.create(path,1920-400,1080/2-150,400,300,true)
        panel.count = 0
        panel.button_map = {}
        panel.scroll_interval_y = 29
        extends(task_tip_panel_class,panel)
        return panel
    end,

    sort_task = function (self)
        local button_list = {}

        self:set_scroll_y(0)

        for name,button in pairs(self.button_map) do 
            table.insert(button_list,button)
        end 

        table.sort(button_list,function (a,b)
            return a.slot_id < b.slot_id
        end)

        for index,button in ipairs(button_list) do 
            button:show()
            button:set_position(button.x,button.h * (index - 1))
            button.slot_id = index 
        end 
        self.count = #button_list + 1
        
    end,

    on_button_clicked = function (self,button)
        local task = button.task 
        if task == nil then 
            return 
        end 
        local info = {
            type = 'taskbar',
            func_name = 'guide',
            params = {
                [1] = ui.get_hash(task:get_name()),
            }
        }
        ui.send_message(info)
    end,

    on_panel_scroll = function (self,value)
 
    end,
})

taskbar.task_tip_button_class = task_tip_button_class

taskbar.tip_panel_ui = task_tip_panel_class.create()

taskbar.tip_panel_ui:hide()