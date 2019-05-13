

local propbar = {}
local propbar_class = {}

--创建UI
propbar_class = extends( panel_class,{
    
    create = function()
        --创建底层面板
        local panel = panel_class.create('',1168,941,170,112)
        --继承
        extends(propbar_class,panel)
        --禁止鼠标穿透

        --创建6个道具栏
        local button_list = {}
        local y = 0
        for i=1,2 do
            for n=0,2 do
                local x = n * 4 + n * 54
                local button = panel:add_button('image\\控制台\\gezi.tga',x,y,54,54)
                button.texture = button:add_texture('',2,2,50,50)
                button.name = '道具栏'
                table.insert(button_list,button)
                button.slot_id = #button_list

                --创建物品数量文字
                --button.icon_text = button:add_text('10')
            end
            y = 58
        end

        panel.name = '道具栏'
        panel.button_list = button_list
        return panel
    end,

    --鼠标进入

    --鼠标离开

    --鼠标左键点击

    --鼠标右键点击


    --拖放结束事件 拖动的按钮  目标按钮
    on_button_drag_and_drop = function (self,button,target_button)
        if button == target_button then 
            return 
        end 

        if self.unit == nil then
            return
        end

        local map = self.unit:get_propbar()
        local source_slot = button.slot_id
        local source_item = map[source_slot]
        --没有物品 跳出
        if source_item == nil then 
            return 
        end
        --物品不可用 跳出
        if source_item:is_enable() == false then
            return
        end
        
        --如果目标按钮的name = 道具栏，则交换
        if target_button and target_button.name and target_button.name == '道具栏' then
            
        end

        --如果目标按钮为背包栏
        if target_button and target_button.name and target_button.name == '背包栏' then
            -- statements
        end


        --如果目标按钮为空，且鼠标在界面之外 丢弃
        local x = japi.GetMouseVectorX() / 1024 * 1920
        local y = (-(japi.GetMouseVectorY() - 768)) / 768 * 1080
        if target_button == nil  then 
            if self:point_in_rect(x,y) == false then 
                local page_id = source_item.page_id
                local slot_id = source_item.slot_id
                local info = {
                    type = 'bag',
                    func_name = 'discard',
                    params = {
                        [1] = page_id,
                        [2] = slot_id,
                    }
                }
                ui.send_message(info)
                source_item:destroy()
            end
        end
    end,




    --删除物品 槽位ID,是否同步
    remove = function(slot_id,is_sync)
        local button = self.button_list[slot_id]
        if not button then
            return
        end

        local unit = self.unit
        if not unit then
            return
        end

        --删除图标
        button.texture:set_normal_image('')

        --删除表内
        local map = unit:get_propbar()
        map[slot_id] = nil

        --如果需要同步
        if is_sync then
            
        end
    end,
})

propbar_class.create()