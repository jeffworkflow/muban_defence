local mt = ac.skill['天使之光']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 0,
    --魔法书
    is_order = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
    tip = [[%active%
|cffffff00特权1：|r拥有酷炫的翅膀效果
|cffffff00特权2：|r金币获取率+20%； 经验获取率+20%； 物品获取率+20%
|cffffff00特权3：|r移速+50， 攻击速度+100%]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end, 
	--技能图标
	art = [[tszg.blp]],
	--特效
	effect = [[Hero_Slayer_N5S_F_Chest.mdx]],
	--移动速度
	move_speed = 50,
	--攻击速度
	attack_speed = 100,
	--金币加成
	gold_mul = 20,
	--经验加成
    exp_mul = 20,

    item_mul = 20,
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('金币加成',self.gold_mul)
    hero:add('经验加成',self.exp_mul)
    hero:add('移动速度',self.move_speed)
    hero:add('攻击速度',self.attack_speed)
    hero:add('物品获取率',self.item_mul)

    --添加翅膀
    if hero.chibang then 
        hero.chibang:remove()
    end    
    hero.chibang = hero:add_effect('chest',self.effect)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('金币加成',-self.gold_mul)
    hero:add('经验加成',-self.exp_mul)
    hero:add('移动速度',-self.move_speed)
    hero:add('攻击速度',-self.attack_speed)
    hero:add('物品获取率',-self.item_mul)

    --添加翅膀
    if hero.chibang then 
        hero.chibang:remove()
    end    
end
