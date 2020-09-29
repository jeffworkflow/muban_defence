
local tools ={
    add_frame = function (self,off_x,off_y,size,off_size,is_show,on_hide)
        -- print(333,self)
        if self.model_frame then 
            self.model_frame.is_show1 = is_show
            self.model_frame.on_hide = on_hide
            self.model_frame:show()
            return
        end
        local new_ui = class.panel:builder
        {
            parent = self,
            x = 800,--假的
            y = 800,--假的
            w = 80,
            h = 80,
            level = 5,
            is_show = false,
            normal_image = 'Transparent.tga',
            btn = {
                type = 'button',
            },
            model = {
                type = 'model',
                size = 1,
                model = [[tx6.mdx]],
            },
            get_show = function(self)
                -- print('动态边框',self.is_show1)
                return self.is_show1
            end,
            on_hide = on_hide
        }
        new_ui.is_show1 = is_show
        --默认为传进来控件的坐标
        new_ui:set_real_position(self:get_real_position())
        -- print('边框位置：',self:get_real_position())

        if off_x and off_y then 
            new_ui.model:set_model_offset(off_x,off_y)
        end    
        if size then 
            new_ui.model:set_size(size)
        end   
        if off_size then 
            local x,y,z = table.unpack(off_size)
            new_ui.model:set_scale(x,y,z)
        end    
        new_ui:show()   
        --如果外部有传参，会有问题。
        function new_ui.btn:on_button_mouse_enter()  
            if not new_ui:get_show() then 
                new_ui:hide()
                if new_ui.on_hide then 
                    new_ui:on_hide()
                end
            end     
        end   
        self.model_frame = new_ui
        return new_ui
    end,  
    
}
--赋予基础方法
for name, func in pairs(tools) do 
    class.ui_base[name] = func
end 



