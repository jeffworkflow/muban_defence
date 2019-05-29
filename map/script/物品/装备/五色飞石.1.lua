--物品名称
local mt = ac.skill['五色飞石']
mt{
    --物品技能
    is_skill = true,
    
    level = 1 ,
    max_level = 11,
    --颜色
    color = '紫',
    tip = [[
+%all_attr% 全属性
+%per_all_attr% 每秒加全属性        
+%attack% 攻击
+%defence% 护甲
+%per_gold% 每秒加金币
+%per_wood% 每秒加木头
+%heart_rate% 会心几率
+%heart_damage% 会心伤害

|cffFFE799【进阶】|r 杀死 %kill_cnt% 个敌人，自动进阶]],

    --技能图标
    art = [[qiu305.blp]],
    --全属性
    all_attr = {100,500,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --每秒加全属性
    per_all_attr = {0,1,3,10,30,90,270,810,2430,7290,21870,},
    --攻击
    attack = {0,0,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --护甲
    defence = {1,5,10,20,40,80,160,320,1250,2500,5000,},
    --每秒加金币
    per_gold = {0,50,100,500,1000,5000,5000,5000,5000,5000,5000,},
    --每秒加木头
    per_wood = {0,0,0,0,0,0,1,5,10,50,100,},
    --暴击几率
    heart_rate = {0,0,0,1,2,3,4,5,6,8,10,},
    --暴击伤害
    heart_damage = {0,0,0,10,20,30,40,50,60,80,100,},
    --杀敌个数
    kill_cnt = {10,50,100,200,400,800,1600,3200,6400,12800,25600},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    --升级特效
    effect =[[Hero_CrystalMaiden_N2_V_boom.mdx]],
    --物品详细介绍的title
    content_tip = '基本属性：',
    ['力量'] ={100,200,300,400,500}
}

mt.all_attr_now =0
mt.per_all_attr_now =0
mt.attack_now = 0
mt.defence_now = 0
mt.per_gold_now =0
mt.per_wood_now =0
mt.heart_rate_now =0
mt.heart_damage_now =0

function mt:on_upgrade()
    local hero = self.owner
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    self:set_name(self.name)

	-- hero:add('力量', -self.all_attr_now)
	-- self.all_attr_now = self.all_attr
    -- hero:add('力量', self.all_attr)

	-- hero:add('敏捷', -self.all_attr_now)
	-- self.all_attr_now = self.all_attr
    -- hero:add('敏捷', self.all_attr)

	-- hero:add('智力', -self.all_attr_now)
	-- self.all_attr_now = self.all_attr
    -- hero:add('智力', self.all_attr)

	-- hero:add('每秒加全属性', -self.per_all_attr_now)
	-- self.per_all_attr_now = self.per_all_attr
    -- hero:add('每秒加全属性', self.per_all_attr)
    
	-- hero:add('攻击', -self.attack_now)
	-- self.attack_now = self.attack
	-- hero:add('攻击', self.attack)

	-- hero:add('护甲', -self.defence_now)
	-- self.defence_now = self.defence
    -- hero:add('护甲', self.defence)

	-- hero:add('每秒加金币', -self.per_gold_now)
	-- self.per_gold_now = self.per_gold
    -- hero:add('每秒加金币', self.per_gold)

	-- hero:add('每秒加木头', -self.per_wood_now)
	-- self.per_wood_now = self.per_wood
    -- hero:add('每秒加木头', self.per_wood)

	-- hero:add('会心几率', -self.heart_rate_now)
	-- self.heart_rate_now = self.heart_rate
    -- hero:add('会心几率', self.heart_rate)
    
	-- hero:add('会心伤害', -self.heart_damage_now)
	-- self.heart_damage_now = self.heart_damage
    -- hero:add('会心伤害', self.heart_damage)

    if not self.trg and self.level < self.max_level then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item.level >= item.max_level then 
                    return 
                end
                item:add_item_count(1)
                if item._count >= item.kill_cnt then 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)
                end    
            end    
        end)
    end   
end
function mt:on_add()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 

    -- hero:add('力量',self.all_attr)
    -- hero:add('敏捷',self.all_attr)
    -- hero:add('智力',self.all_attr)
    -- hero:add('每秒加全属性',self.per_all_attr)
    -- hero:add('攻击',self.attack)
    -- hero:add('护甲',self.defence)
    -- hero:add('每秒加金币',self.per_gold)
    -- hero:add('每秒加木头',self.per_wood)
    -- hero:add('会心几率',self.heart_rate)
    -- hero:add('会心伤害',self.heart_damage)


    if not self.trg and self.level < self.max_level then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item.level >= item.max_level then 
                    return 
                end
                item:add_item_count(1)
                if item._count >= item.kill_cnt then 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)
                end    
            end    
        end)
    end   

end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 
end    
--实际是丢掉
function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    

    -- hero:add('力量',-self.all_attr)
    -- hero:add('敏捷',-self.all_attr)
    -- hero:add('智力',-self.all_attr)
    -- hero:add('每秒加全属性',-self.per_all_attr)
    -- hero:add('攻击',-self.attack)
    -- hero:add('护甲',-self.defence)
    -- hero:add('每秒加金币',-self.per_gold)
    -- hero:add('每秒加木头',-self.per_wood)
    -- hero:add('会心几率',-self.heart_rate)
    -- hero:add('会心伤害',-self.heart_damage)
end