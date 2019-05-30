local mt = ac.skill['空间之力']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return (self.owner:get('全属性')*5+10000)* self.level
end,
	--属性加成
 ['每秒加全属性'] = {250,500,750,1000,1200},
	--介绍
	tip = [[|cffffff00【每秒加全属性】+250*Lv|r

|cff00bdec被动效果：攻击8%几率造成范围技能伤害
伤害公式：（全属性*5+10000）*Lv|r

]],
    --模型
    model = [[AZ_Goods_TP_Target_effect.MDX]],
    art =[[kongjianzhili.blp]],
	--爆炸半径
    hit_area = function(self,hero)
        return 150 + hero:get '额外范围'
    end,
    --伤害类型
    damage_type ='法术'
}

function mt:on_add()
    local hero = self.owner
    local skill = self
    --记录默认攻击方式
    if not hero.oldfunc then
        hero.oldfunc = hero.range_attack_start
    end

    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local max_damage = self.current_damage

        local target = damage.target
        local area = self.hit_area

        ac.effect(target:get_point(),[[Effect_RightDust.mdx]],0,1,'origin'):remove()
        for _, u in ac.selector():in_range(target,area):is_enemy(hero):ipairs() do
            u:damage{
                source = hero,
                skill = self,
                damage = max_damage,
                damage_type = skill.damage_type,
            }
        end

        --还原默认攻击方式
        hero.range_attack_start = hero.oldfunc
    end

    self.trg = hero:event '造成伤害效果' (function(_, damage)
        --触发时修改攻击方式
        if math.random(100) <= self.chance then  
            self = self:create_cast()
            --当前伤害要在回调前初始化
            self.current_damage = self.damage
            hero:event_notify('触发天赋技能', self)

            range_attack_start(hero,damage)
        end 

        return false
    end)

end


function mt:on_remove()
    local hero = self.owner
    hero.range_attack_start = hero.oldfunc
    self.trg:remove()
end


