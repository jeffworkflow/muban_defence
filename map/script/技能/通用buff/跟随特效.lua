
local mt = ac.buff['跟随特效']
mt.pulse = 0.1

function mt:on_pulse()
    local hero = self.target
    if self.hearing then
        if self.hearing.type == 'buff' then
            if self.hearing.removed == true then
                self:remove()
            end
        elseif self.hearing.type == 'mover' then
            if self.hearing.removed == true then
                self:remove()
            end
        end
    else
        self:remove()
    end
    if self.point then
        ac.effect_ex
        {
            point = hero:get_point(),
            model = self.model,
            size = self.size,
            rotate = self.rotate,
        }:remove()
    elseif self.unit then
        hero:add_effect(self.ref,self.model):remove()
    end
end

function mt:on_add()
end

function mt:on_remove()
end