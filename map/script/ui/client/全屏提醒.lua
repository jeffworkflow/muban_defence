
class.screen_animation = extends(class.panel){
    
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\控制台\\jingong.tga',(1920-700)/2,300,700,250)
        local title = panel:add_text('',(panel.w-260)/2,(panel.h-40)/2-30,260,40,15,4)
        panel.__index = class.screen_animation 
        panel.title = title
        panel:hide()
        return panel
    end,


    --进攻提示
    up_jingong_title = function(self,title)
        self.title:set_text(title)
        if not self.old_x then 
            self.old_x,self.old_y = self:get_position()
        end
        self:set_position(self.old_x,self.old_y)
        self:show()
        
        ac.wait(3*1000,function()
            self:set_position(self.x,50)
        end)
    end,
    move = function(self)

    end,
   
    
}

-- local panel = class.screen_animation.get_instance()








