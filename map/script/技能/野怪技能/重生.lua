local mt = ac.skill['重生']

mt.title = "重生"
mt.tip = [[
    被动1：死亡后，原地0.5S重生一次
    被动2：降低自己的三维27.5%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
-- mt.value = 27.5

--重生时间
mt.time = 8
mt.cnt = 1

mt.effect = [[Abilities\Spells\Orc\Reincarnation\ReincarnationTarget.mdl]]


function mt:on_add()

    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    -- hero:add('生命上限%', -self.value)
    -- hero:add('护甲%', -self.value)
    -- hero:add('攻击%', -self.value)
    -- hero:add('魔抗%', -self.value)

    --重生相关
    self.trg = hero:event '单位-即将死亡' (function (_,unit,killer)
        local point = hero:get_point()
        local effect = ac.effect(point,self.effect,0,1,'origin')
        -- local effect = hero:add_effect('origin',self.effect)
        --发送红色信号
        if unit:get_name() == '基地' then
            local f1 = ac.player.self:cinematic_filter
            {   
                file = 'xueliangguodi.blp',
                start = {100, 100, 100, 100},
                finish = {100, 100, 100, 0},
                time = 5,
            }
        end    

        hero:add_restriction '隐藏'
        hero:add_restriction '定身'
        hero:add_restriction '无敌'
        hero:add_restriction '缴械'

        ac.wait(self.time*1000,function ()

            effect:remove()
            hero:remove_restriction '隐藏'
            hero:remove_restriction '无敌'
            hero:remove_restriction '定身'
            hero:remove_restriction '缴械'

            --用 set,生命加成可能会有问题
            hero:add('生命', hero:get '生命上限')
            
            --重生次数 -1 小于1时 ,无法重生，技能移除
            self.cnt = self.cnt - 1 
            if self.cnt < 1 then 
                self:remove()
            end 
        end)
        -- 中断死亡
        return true 
    
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    -- hero:add('生命上限%', self.value)
    -- hero:add('护甲%', self.value)
    -- hero:add('攻击%', self.value)
    -- hero:add('魔抗%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

