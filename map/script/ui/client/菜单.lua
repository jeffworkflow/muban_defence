

class.screen_button = extends(class.button){
    new = function (parant,x,y,info)
        local button = class.button.new(parant,info.path,x,y,36,36)
        local text = button:add_text(info.name,0,36,36,36,12,'center')

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
            self:tooltip(self.info.name,self.info.tip,-1,200,64)
        end
    end,
}


local ui_info = {
    {
        name = '图鉴',  
        path = 'image\\控制台\\图鉴.blp',
        key = 'F3', 
        tip = "点击或按F3快捷键可以打开图鉴"
    },
    {
        name = '菜单',  
        path = 'image\\控制台\\菜单.blp',
        key = 'F10', 
        tip = "点击或按F10快捷键可以打开菜单"
    },

}

for index,info in ipairs(ui_info) do 
    class.screen_button.create(1700 + index * 56,20,info)
end 