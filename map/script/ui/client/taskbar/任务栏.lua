

local ui            = require 'ui.client.util'


task_state_icon = {
    ['金钱'] = 'image\\背包\\jinbi.tga',
    ['经验'] = 'image\\背包\\jinbi.tga',
    ['默认'] = 'image\\背包\\jinbi.tga',
}


--任务栏类  实际任务栏的UI类
local taskbar_class

--任务类 
local task_button_class

--任务提示的消息队列
local task_tip_list = {}

--任务面板按钮类 具用于显示 主线 跟 支线 任务在任务栏面板上面的UI显示
task_button_class = extends(button_class,{
    --创建任务
    create = function (task)
        local panel = taskbar.ui
        local name = task:get_name()

        if panel.button_map[name] ~= nil then
            ui_print('任务已存在，不能重复领取')
            return
        end
        
        local width = panel.button_bar.w - 24
        local height = 80
        local path = 'image\\商店\\shop_frame_normal.tga'
        local button = panel.button_bar:add_button('',0,0,width,45)
       
        setmetatable(button,{__index = task_button_class})

        button.text = button:add_text(name,0,0,button.w,button.h,12,'center')
        button.count = panel.count
        button.task = task 

        table.insert(task.control,button)
        table.insert(panel.button_list,button)
        button.list_index = #panel.button_list
        panel.button_map[name] = button
        

        panel:sort_task()
        
        
        return task
    end,

    --删除任务 当失败或完成时都需要调用
    destroy = function (self)
        local panel = taskbar.ui
        if self.task == nil then 
            return
        end

        if self == panel.select_button then 
            panel.select_button = nil 
        end
        if self.list_index == nil then 
            return 
        end 
        table.remove(panel.button_list,self.list_index)
        panel.button_map[self.task:get_name()] = nil
        self.list_index = nil
        self.task = nil
        button_class.destroy(self)

        for index,button in ipairs(panel.button_list) do
            button.list_index = index
        end

       
        --移除按钮后 其他的按钮重新排列一下位置
        panel:sort_task()
        if #panel.button_list == 0 then 
            panel:show_task('')
        end 
        
        for index,button in ipairs(panel.button_list) do
            if button.is_show == true then
                panel:show_task(button.task:get_name())
                break
            end
        end
    end,

    --设置任务完成
    set_complete = function (self)
        local panel = taskbar.ui
        if self.task == nil then 
            return
        end
        self.text:set_color(220,230,50,1)
        if self == panel.select_button then
            panel:show_tip(self)
        end

    end,

    
    --设置任务条件
    set_condition = function (self,key,value)
        local panel = taskbar.ui
        if self.task == nil then 
            return
        end

        self:show_progress_tip(key,value)

        if self == panel.select_button then
            panel:show_tip(self)
        end
    end,

    
    show_progress_tip = function (self,key,value)
        local task = self.task
        if task == nil then 
            return
        end

        local str = string.format("%s %s:(%d/%d)",task:get_name(),key,value,task.complete_condition[key])
        
        self.text:set_color(255,255,255,1)

        table.insert(task_tip_list,{button = self, tip = str})
        if self.parent.timer then 
            self.parent.timer:remove()
        end 
        self.parent.timer = game.loop(400,function (timer)
            if #task_tip_list == 0 then 
                timer:remove()
                self.parent.timer = nil 
                return 
            end

            local value = task_tip_list[1]
            local button = value.button
            local tip = value.tip
            
            table.remove(task_tip_list,1)
            local i = 1 
            while i < #task_tip_list do 
                local info = task_tip_list[i]
                if button == info.button then 
                    tip = info.tip 
                    table.remove(task_tip_list,i)
                else 
                    i = i + 1
                end 
            end 

            if button == nil or button.id == nil then 
                return
            end 

            local text = button._tip_text 
            if text == nil then 
                text = text_class.create('',1200,820,500,500,12)
                text:set_color(255,255,128,1)
                button._tip_text = text
                --让这个 按钮管理 这个任务文本的回收
                table.insert(button.children,text)
            else 
                text:set_position(1200,820)
                text:set_alpha(1)
            end 
            text:set_text(tip)

            local num = 0
            game.loop(33,function ()
                num = num + 1
                if num >= 120 then 
                    text:set_text('')
                else 
                    text:set_position(text.x + 1,text.y - 2)
                    text:set_alpha(text.color.a - 0.02)
                end 
            end)
        end)
    end,

    get_progress_tip = function (self)
        if self.task == nil then 
            return 
        end 
        return self.task:get_progress_tip()
    end,
    
})


--任务栏类 用于显示 任务栏的UI界面 并处理 对应子成员的消息操作
taskbar_class = extends( panel_class , {
    create = function (image_path,x,y,width,height)
        local text_width = width - 188
        local text_height = height / 2
        local text_x = 188 + 15
        local panel = panel_class.create("image\\任务栏\\renw_01.tga",x,y,width,height)
        setmetatable(panel,{__index = taskbar_class})

        local path = "image\\任务栏\\shop_frame_Press.tga"

        --标题
        panel.describe_title = panel:add_text('  任务介绍 ',text_x,88,176,33,21,'center')
        panel.describe_title:set_normal_image(path)
        panel.describe_title:set_color(255,255,255,1)

        --标题
        panel.tip_title = panel:add_text('  任务提示 ',text_x,251,176,33,21,'center')
        panel.tip_title:set_normal_image(path)
        panel.tip_title:set_color(255,255,255,1)
        
        local y = panel.tip_title.h + panel.describe_title.h
        --标题
        panel.reward_title = panel:add_text('  任务奖励 ',text_x,414,176,33,21,'center')
        panel.reward_title:set_normal_image(path)
        panel.reward_title:set_color(255,255,255,1)

        text_width = text_width - 32

        --介绍的文本
        panel.descrbe = panel:add_text('',text_x+12,117+20,text_width,130,12)

        y = panel.descrbe.y + panel.descrbe.h + 33
        --提示的文本
        panel.tip = panel:add_text('',text_x+12,y,text_width,130,12)

        y = panel.tip.y + panel.tip.h + 33
        --奖励的文本
        panel.reward = panel:add_text('',text_x+30,y,text_width,162,12)

        panel.button_map = {}
        panel.button_list = {}

        --添加一个拖动标题
        panel.title_button = panel:add_title_button('','任务栏',0,0,width,64)
        --添加一个关闭按钮
        panel.close_button = panel:add_close_button()
        --放弃 或 领取奖励的按钮
        --panel.end_button = panel:add_end_button(width-128-12,height-48,128,32)
        --panel.end_button:hide()

        --任务标题组
        panel.button_bar = panel:add_button_bar()

       

        --奖励道具列表
        panel.reward_button_list = panel:add_reward_button_list(text_x,y+18,4,2,64)
        

        panel.select_button = nil
        return panel
    end,

    hide = function (self)
        panel_class.hide(self)
        if self.select_button ~= nil then 
            self.select_button:set_normal_image('')
        end 
    end,

    add_button_bar = function (self)
        local info = {
            {'主线',"image\\任务栏\\renw_yeqian_01.png",{0,165,232,1}},
            {'支线',"image\\任务栏\\renw_yeqian_02.png",{128,255,0,1}},
            {'平台',"image\\任务栏\\renw_yeqian_03.png",{0,255,128,1}},
        }

        --任务列表的按钮栏 分别代表每一个任务类型
        local group = self:add_panel('',12,88,188,self.h - 100,true)
        local width = group.w - 24
        local height = 30
        self.title_list = {}
        self.title_map = {}
        for index,data in ipairs(info) do
            y = 4 + index * height
            local title = group:add_button(data[2],0,y,width,height)
            local text = title:add_text(data[1]..'任务',10,0,width,height,12,'center')
            title.task_type = data[1]
            title.has_show = true
            text:set_color(table.unpack(data[3]))
            table.insert(self.title_list,title)
            self.title_map[data[1]] = title
        end

        return group
    end,

    --添加一个结束任务的按钮 
    add_end_button = function (self,x,y,width,height)
        local path = "image\\背包\\package-lattice-back-0.tga"
        local button = self:add_button(path,x,y,width,height)
        button.text = button:add_text('放弃',0,0,button.w,button.h,12,'center')
        --按钮点击关闭
        button.on_button_clicked = function (self)
            local object = self.parent
            local button = object.select_button
            local  task = self.task
            if task == nil then 
                return 
            end 
            if button ~= nil then
                if task.finish == false then
                    --给服务端发送 放弃任务的消息
                    local info = {
                        type = 'taskbar',
                        func_name = 'discard_task',
                        params = {
                            [1] = ui.get_hash(task:get_name()),
                        }
                    }
                    
                    ui.send_message(info)
                else
                    --给服务端发送 领取任务奖励的消息
                    local info = {
                        type = 'taskbar',
                        func_name = 'get_task_reward',
                        params = {
                            [1] = ui.get_hash(task:get_name()),
                        }
                    }
                    
                    ui.send_message(info)

                    --object:remove_task(button.name)
                end
            end
            return false
        end 
        --按钮文本提示
        button.on_button_mouse_enter = function (self)
            local object = self.parent
            if object.select_button ~= nil then
                local task = object.select_button.task 
                if task == nil then 
                    return 
                end 
                if task.finish == false then
                    ui_base_class.set_tooltip(self,"放弃任务",0,0,200,64,16) 
                else
                    ui_base_class.set_tooltip(self,"领取奖励",0,0,200,64,16) 
                end
            end
            return false
        end 
        return button
    end,

    --添加物品按钮列表
    add_reward_button_list = function (self,ox,oy,row,column,size)
        local interval = size / 4
        local value = size + size / 2
        local offset = interval / 2
        local slot_size = size + offset
        local button_size = size - offset

        local reward_button_list = {}

        --槽位背景
        local slot_path = "image\\背包\\zhuangbei_01.png"

        for i = 0 ,  column - 1 do
            for k = 0 , row - 1 do
                local x = ox + k * value + 20
                local y = oy + i * value - 10
                local slot = self:add_panel(slot_path,x,y,slot_size,slot_size)
              
                --创建一个文本
                local text = slot:add_text("",0,button_size,slot.w,button_size/4,button_size/4,'right')
                text:set_color(220,230,50,1)
               

                --创建一个按钮
                local button = slot:add_button("",offset,offset,button_size,button_size)
               
                button.slot = slot
                button.text = text
                button.on_button_mouse_enter = function (button)
                    local name = button.name
                    if name == nil then
                        return 
                    end
  
                    if button.reward_type == '属性' then
                        local tip = '奖励 '..tostring(button.reward_value)..' 点'..name..'的数值嘉奖。'
                        button:set_tooltip(tip,0,0,300,50,16)
                    else
                        local item = button.item 
                      
                        item.tip_ex = nil 
                        if button.reward_value > 0 then 
                            item.tip_ex = '\n奖励 ' .. tostring(button.reward_value) .. ' 件道具'
                        end
                        button:item_tooltip(item)
                    end
                    
                    return false
                end
                table.insert(reward_button_list,button)
                slot:hide()
            end
        end 

        return reward_button_list
    end,

    sort_task = function (self)
        local x = 4
        local y = 4
        local type_table = {}
        local count = 0

        for index,title in ipairs(self.title_list) do
            type_table[title.task_type] = {}
        end
        for index,button in ipairs(self.button_list) do
            if button.task ~= nil then 
                table.insert(type_table[button.task:get_type()],button)
            end 
        end
        for index,title in ipairs(self.title_list) do
            local type = title.task_type
            local list = type_table[type]
            table.sort(list,function (a,b)
                return a.list_index < b.list_index
            end)
            title:set_position(x,y)
            y = y + 30
            for i,button in ipairs(list) do
                count = count + 1
                if title.has_show == true then 
                    button:show()
                    button:set_position(x,y)
                    y = y + 45
                else
                    button:hide()
                end
            end
        end
        self:set_scroll_y(0)

    end,

    --显示指定任务的页面
    show_task = function (self,name)
        if self.select_button ~= nil then 
            self.select_button:set_normal_image('')
        end 
        
        if name == nil or self.button_map[name] == nil then
            self.descrbe:set_text('')
            self.tip:set_text('')
            self.reward:set_text('')
            self.reward_title:set_text(' 任务奖励 :')
            --清空物品按钮列表
            for index,button in ipairs(self.reward_button_list) do
                button.slot:hide()
                button.text:set_text('')
                button:set_normal_image('')
                button.name = nil
                button.item = nil
            end
            return
        end
        local task_button = self.button_map[name]
        local task = task_button.task 
        local count = 0
        local state_list = {}
        local reward_state = task.data.Reward['属性'] or {}

        --遍历奖励的属性 转换成列表 再按名字排序 之后再添加到界面上
        for state_name,value in pairs(reward_state) do 
            table.insert(state_list,{state_name,value})
        end
        table.sort(state_list,function (a,b)
            return a[1] < b[1]
        end)
        for index,data in ipairs(state_list) do
            count = count + 1
            local button = self.reward_button_list[count]
            if button ~= nil then
                local icon = task_state_icon[key] or task_state_icon['默认']
                button.name = data[1]
                button.reward_type = '属性'
                button.reward_value = data[2]
                button.slot:show()
                button.text:set_text(tostring(data[2]))
                button:set_normal_image(icon)
            end
        end
       
        local item_list = {}
        local reward_items = task.data.Reward['道具'] or {}
        --遍历奖励的物品 转换成列表 再按名字排序 之后再添加到界面上
        for item_name,value in pairs(reward_items) do 
            if type(item_name) == 'number' then
                item_name = value 
                value = 1
            end
            table.insert(item_list,{item_name,value})
        end
        table.sort(item_list,function (a,b)
            return a[1] < b[1]
        end)
        for index,data in ipairs(item_list) do
            count = count + 1
            local button = self.reward_button_list[count]
            if button ~= nil then
                local name = data[1]
                button.name = name
                button.reward_type = '道具'
                button.reward_value = data[2]
                button.slot:show()
                if data[2] > 1 then 
                    button.text:set_text(tostring(data[2]))
                else
                    button.text:set_text('')
                end

                --构造一个没有随机属性的物品 没有所属单位 
                local item = ui.bag.item_class.create(nil,0,0,name,0)
                button.item = item

                button:set_normal_image(item:get_icon())
                
            end
        end
        
        if count < #self.reward_button_list then
            for i = count + 1,#self.reward_button_list do
                local button = self.reward_button_list[i]
                if button ~= nil then
                    button.slot:hide()
                    button.name = nil
                    button.reward_type = nil
                    button.reward_value = 0
                end
            end
        end
        
        self:show_tip(task_button)
        
        
        task_button:set_normal_image('image\\商店\\shop_frame_Press.tga')
 
        if task_data_class.get_type(name) == '支线' then
            --self.end_button:show()
        else
	        --self.end_button:hide()
        end
        
        self.select_button = task_button
    end,

    show_tip = function (self,button)
        local task = button.task 
        if task == nil then 
            return 
        end 

        local descrbe,tip = task:get_descrbe()

        self.descrbe:set_text(descrbe)
        self.tip:set_text(tip)

    end,
---------event method-------------------
    on_button_clicked = function (self,button)
        if button.task_type ~= nil then
            button.has_show = not(button.has_show)
            self:show_task('')
            self:sort_task()
            return
        end
        if button.task ~= nil then
            self:show_task(button.task:get_name())
        end
    end,
})


local object = taskbar_class.create('image\\装备栏\\equ_background.tga',350,150,623,683)
object:hide()
taskbar.task_button_class = task_button_class
taskbar.ui = object 


