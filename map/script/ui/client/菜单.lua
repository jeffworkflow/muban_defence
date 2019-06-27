

class.screen_button = extends(class.button){
    new = function (parant,x,y,info)
        local button = class.button.new(parant,info.path,x,y,84,84)
        local text = button:add_text(info.name,0,84,84,84,12,'center')

        button.__index = class.screen_button

        button.info = info 
        return button
    end,

    on_button_clicked = function (self)
        if self.info then 
            local key = self.info.key
            japi.SendMessage(0x100,KEY[key],0)
            japi.SendMessage(0x101,KEY[key],1)
        end
    end,

    on_button_mouse_enter = function (self)
        if self.info then 
            self:tooltip(self.info.name,self.info.tip,0,200,84)
        end
    end,
}


local ui_info = {
    {
        name = nil,  
        path = 'image\\控制台\\F2_home.blp',
        key = 'F2', 
        tip = "F2回城"
    },
    {
        name = nil,  
        path = 'f3_liangongfang.blp',
        key = 'F3', 
        tip = "F3进入练功房"
    },

}

for index,info in ipairs(ui_info) do 
    class.screen_button.create(10,50 + index*84*1.2,info)
end 