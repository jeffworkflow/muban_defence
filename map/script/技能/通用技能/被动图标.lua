
ac.game:event '技能-获得' (function (_,hero,self)
    if self.passive then 
        self.passive_blend = self:add_blend('off','frame',2)
    end    
end)
