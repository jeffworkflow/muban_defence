--物品名称
local mt = ac.skill['荒芜之戒']
mt{
--等久
level = 1,
--图标
art = [[hwzj.blp]],
--类型
item_type = "装备",
--品质
color ='黑',
--模型
specail_model = [[File00000376 - RC.mdx]],
--冷却
cool = 0,
--描述
tip = [[

|cffcccccc人不仁，无信无义。王不仁，无德无量。地不仁，无草无木。天不仁，无世间万物。万年圣物，荒芜之戒。

|cff00ff00所有队友的攻击减甲+250
]],
--攻击减甲数值
value = 250,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_add()
    local hero = self.owner
    if not hero:is_hero() then 
        return 
    end    
    if not ac.team_attr then ac.team_attr ={} end
    ac.team_attr['攻击减甲'] = (ac.team_attr['攻击减甲'] or 0) + self.value
end  
function mt:on_remove()
    local hero = self.owner
    if not hero:is_hero() then 
        return 
    end    
    if not ac.team_attr then ac.team_attr ={} end
    ac.team_attr['攻击减甲'] = (ac.team_attr['攻击减甲'] or 0) - self.value
end     


local mt = ac.skill['噬魂']
mt{
--等久
level = 1,
--图标
art = [[shihun.blp]],
--类型
item_type = "装备",
--模型
specail_model = [[File00000376 - RC.mdx]],
--品质
color ='黑',
--冷却
cool = 0,
--描述
tip = [[

|cffcccccc上古时期，一根充满戾气的魔棒

|cff00ff00-0.05 攻击间隔，无视攻击间隔上限，仅限携带一个
|cff00ff00+100%  吸血
]],
--唯一
-- unique = true,
-- ['攻击间隔'] = -0.05,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_add()
    local hero = self.owner
    hero.flag_attack_gap = true 
    hero:add('攻击间隔',-0.05)
    hero:add('吸血',100)
end  
function mt:on_remove()
    local hero = self.owner
    hero:add('攻击间隔',0.05)
    hero:add('吸血',-100)
end     
function mt:after_remove(hero)
    local item = hero:has_item(self.name)
    local skl = hero:find_skill(self.name,nil,true)
    if not item and not skl then 
        hero.flag_attack_gap = false 
    end    
    -- print(123)
end    


local mt = ac.skill['魔鬼金矿']
mt{
--等久
level = 1,
--图标
art = [[mgjk.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 0,
--描述
tip = [[

|cffcccccc金矿被魔鬼占据之后，侍僧才可以从中采集黄金资源。

|cff00ff00杀敌数加成+60% 物品获取率+60% 木头加成+60% 火灵加成+60%
]],
['杀敌数加成'] = 60,
['物品获取率'] = 60,
['木头加成'] = 60,
['火灵加成'] = 60,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}



local mt = ac.skill['魔鬼的砒霜']
mt{
--等久
level = 1,
--图标
art = [[mgdps.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "消耗品",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc昨天的蜜糖，今天的砒霜

|cff00ff00点击将砒霜洒向周围1000码的敌人，可减少20%的最大生命
]],
--物品技能
is_skill = true,
--技能目标
-- target_type = ac.skill.TARGET_TYPE_UNIT,
--值
value = 20,
--目标允许	
-- target_data = '敌人', 物品施法没有这些判断
-- range = 1000,   物品施法没有这些判断
effect_area = 1000,
--特效
effect = [[Nortrom_E_Effect.MDX]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner
    -- print(unit:get_name(),unit:get('生命上限'))
    hero:add_effect('origin',self.effect):remove()
    for _,unit in ac.selector()
        : in_range(hero,self.effect_area)
        : is_enemy(hero)
        : ipairs()
    do 
        -- print(-unit:get('生命上限')*self.value/100)
        unit:add('生命',-unit:get('生命上限')*self.value/100)
        -- print('扣掉生命',unit:get('生命'))
    end 

end    


local mt = ac.skill['马可波罗的万花铳']
mt{
--等久
level = 1,
--图标
art = [[mkbl.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc万花丛中过，片花不沾身

|cff00ff00多重射+2（仅远程有效） 触发概率加成+50%
]],
--物品技能
is_skill = true,
['多重射'] = 2,
['触发概率加成'] = 50,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
} 


local mt = ac.skill['聚宝盆']
mt{
--等久
level = 1,
--图标
art = [[jubaopen.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc秒进斗金？

|cff00ff00每秒加木头+750，每秒加火灵+1500
]],
--物品技能
is_skill = true,
['每秒加木头'] = 750,
['每秒加火灵'] = 1500,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
} 


local mt = ac.skill['七星剑']
mt{
--等久
level = 1,
--图标
art = [[qixingjian.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc睹二龙之追飞，见七星之明灭

|cff00ff00全属性+8%
]],
--物品技能
is_skill = true,
['力量%'] = 8,
['敏捷%'] = 8,
['智力%'] = 8,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
} 


local mt = ac.skill['金鼎烈日甲']
mt{
--等久
level = 1,
--图标
art = [[jia405.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[
|cffcccccc连上古之神都编不下去的一件衣服

|cff00ff00护甲+15%
]],
--物品技能
is_skill = true,
['护甲%'] = 15,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
} 


local mt = ac.skill['古代护身符']
mt{
--等久
level = 1,
--图标
art = [[gdhsf.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc耶路撒冷发现的一件迷人的小护身符，是人们一直痴迷于抵御传说中的邪恶之眼

|cff00ff00技能伤害加深+50%
]],
--物品技能
is_skill = true,
['技能伤害加深'] = 50,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
} 


local mt = ac.skill['死神之触']
mt{
--等久
level = 1,
--图标
art = [[sszc.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc嗜血阴灵，伴身左右，逆鳞在手，傲视神魔

|cff00ff00攻击1% 几率对敌人造成最大生命值12%的伤害
]],
--唯一
-- unique = true,
--物品技能
is_skill = true,
--值
value = 12,
chance = 1,
effect = [[AZ_Leviathan_V2.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}  
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
        end 
		--技能是否正在CD
        -- if skill:is_cooling() then
		-- 	return 
		-- end
		local rand = math.random(1,100)
        if rand <= self.chance then 
            --目标特效
            -- print(self.effect)
            ac.effect(damage.target:get_point(),self.effect,0,1,'origin'):remove()
            -- damage.target:add_effect('origin',self.effect):remove()
            --目标减最大
            damage.target:damage
            {
                source = hero,
                damage = damage.target:get('生命上限')*self.value/100,
                skill = skill,
                real_damage = true --真伤

            }
            --激活cd
            -- skill:active_cd()
		end
    end)    
   
end  
function mt:on_remove()
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    -- p.flag_added = false 
end 


local mt = ac.skill['大力丸']
mt{
--等久
level = 1,
--图标
art = [[dlw.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "消耗品",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc固本培元、养益气血

|cff00ff00点击可食用，最大生命值+25%
]],
['生命上限%'] = 25,
--唯一
-- unique = true,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}  


local mt = ac.skill['末世']
mt{
--等久
level = 1,
--图标
art = [[moshi.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--冷却
cool = 1,
--描述
tip = [[

|cffcccccc满目疮痍的崩塌世界，逆天崛起的武道强者。十里之内，漫山遍野。

|cff00ff00全属性+3500万，杀敌数额外+1
]],
['额外杀敌数'] = 1,
['全属性'] = 35000000,
--唯一
-- unique = true,
--物品技能
is_skill = true,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}  





ac.black_item = {
   '荒芜之戒','噬魂','魔鬼金矿','魔鬼的砒霜','古代护身符','马可波罗的万花铳','聚宝盆','七星剑','金鼎烈日甲',
   '死神之触','大力丸','末世'
}
--吞噬丹 吞噬技能（会执行技能上面的属性和on_add）
ac.tunshi_black_item =[[
荒芜之戒 噬魂 死神之触 

]]


