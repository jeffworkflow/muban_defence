local mt = ac.skill['怀孕']
mt{
    size = function (self,hero)
        return hero:get_size() * 0.5
    end,
    never_copy = true
}
mt.title = "怀孕"
mt.tip = [[
    被动1：死亡时，生出两个属性只有20%的儿子
    被动2：提升自己的三维5%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 5

--怀孕一次
mt.child_value = 20
mt.cnt = 1    

mt.effect = [[]]


function mt:on_add()

    local hero = self.owner 
    -- 三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    self.trg = hero:event '单位-即将死亡' (function (_,unit,killer)
        --重生次数 -1 小于1时 ,无法重生，技能移除
        if self.cnt < 1 then 
            return 
        end 
        
        --创建幻象
        local dummy = hero:create_illusion(hero:get_point())
        --没创建成果就返回
        if not dummy then 
            return 
        end
        --属性削弱
        dummy:add('生命上限', - dummy:get('生命上限')*(1-(self.child_value+self.value)/100) )
        dummy:add('生命', dummy:get('生命上限'))
        dummy:add('护甲', - dummy:get('护甲')*(1-(self.child_value+self.value)/100) )
        dummy:add('攻击', - dummy:get('攻击')*(1-(self.child_value+self.value)/100) )

        --设置搜敌范围 对部分单位会失效。
        dummy:set_search_range(99999)
        dummy:set_size(self.size)
        
        --创建幻象
        local dummy = hero:create_illusion(hero:get_point())
        --属性削弱
        dummy:add('生命上限', - dummy:get('生命上限')*(1-(self.child_value+self.value)/100) )
        dummy:add('生命', dummy:get('生命上限'))
        dummy:add('护甲', - dummy:get('护甲')*(1-(self.child_value+self.value)/100) )
        dummy:add('攻击', - dummy:get('攻击')*(1-(self.child_value+self.value)/100) )
        
        --设置搜敌范围 对部分单位会失效。
        dummy:set_search_range(99999)
        dummy:set_size(self.size)

        --每3秒刷新一次攻击目标
        -- self.trg1 = ac.loop(3 * 1000 ,function ()
        --     local unit = dummy
        --     local hero = ac.find_hero(unit)
        --     if hero then 
        --         if unit.target_point and unit.target_point * hero:get_point() < 1000 then 
        --             unit.target_point = hero:get_point()
        --             unit:issue_order('attack',hero:get_point())
        --         else 
        --             unit.target_point = hero:get_point()
        --             if unit:get_point() * hero:get_point() < 1000 then 
        --                 unit:issue_order('attack',hero)
        --             else  
        --                 unit:issue_order('attack',hero:get_point())
        --             end 
        --         end 
        --     end 
        -- end)
        
  
        self.cnt = self.cnt - 1 
        -- 本体正常死亡
        return false 
        
      
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end  
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end    
end

