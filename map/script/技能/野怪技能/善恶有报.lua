local mt = ac.skill['善恶有报'] 

mt{
    level = 1,
    title = "善恶有报",
    tip = [[
        被动1：攻击有50%概率造成3倍伤害，50%概率给敌人增加血量（恶报呈现物暴效果，善报英雄头上+绿色字）
        被动2：降低自己的三维15%

    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 10,
    -- 善报概率
    good_rate = 50,
    -- 善报补血量
    good_value = 1,

    -- 恶报概率
    bad_rate = 50,
    -- 恶报暴击额外倍数
    bad_value = 5,

    -- 特效
    effect = [[]]

}

function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    local attack_rate = {
        { rand = 50, name = '善报'},
        { rand = 50, name = '恶报'}
    }

    self.trg = hero:event '造成伤害'  (function(trg, damage)
        local is_block 
        if not damage:is_common_attack()  then 
            return 
        end 
        local attack_name = ac.get_reward_name(attack_rate)

        if attack_name == '善报' then 
            damage.target:heal
            {
                source = hero,
                skill = self,
                size = 10,
                string = '善报',
                heal = damage.current_damage * self.good_value ,
            }
            is_block = true
        end

        if attack_name == '恶报' then 
            --表示物理暴击
            damage.physicals_crit_flag = true
			damage:mul(self.bad_value)
            is_block = false
        end

        return is_block
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

