
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
        -- local start_size = 2
        -- local start_x = (1920-1400)/2
        -- local start_y = 150
        
        self:set_position(self.old_x,self.old_y)
        -- self:set_position(start_x,start_y)
        -- self:set_relative_size(start_size)

        -- self:move_animation(self.old_x+500,self.old_y+540,4)
        self:show()
        
        ac.wait(3*1000,function()
            self:set_position(self.x,50)
        end)
    end,
    -- move = function(self)
        
    --    game.loop(33,function (timer)
    --     set_relative_size
    -- end,
   
    
}

-- local panel = class.screen_animation.get_instance()








