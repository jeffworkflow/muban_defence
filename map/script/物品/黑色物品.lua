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
--cd
cool = 1,
--描述
tip = [[

|cffcccccc昨天的蜜糖，今天的砒霜

|cff00ff00点击将砒霜洒向地图中所有的敌人，可减少20%的最大生命
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
effect_area = 99999,
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
--描述
tip = [[

|cffcccccc万花丛中过，片花不沾身

|cff00ff00杀怪/攻击/每秒加敏捷+1000 多重射+2（仅远程有效） 触发概率加成+50%
]],
--物品技能
is_skill = true,
['多重射'] = 2,
['触发概率加成'] = 50,
['攻击加敏捷'] = 1000,
['杀怪加敏捷'] = 1000,
['每秒加敏捷'] = 1000,
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
--描述
tip = [[

|cffcccccc睹二龙之追飞，见七星之明灭

|cff00ff00全属性+10%
]],
--物品技能
is_skill = true,
['力量%'] = 10,
['敏捷%'] = 10,
['智力%'] = 10,
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


-- local mt = ac.skill['古代护身符']
-- mt{
-- --等久
-- level = 1,
-- --图标
-- art = [[gdhsf.blp]],
-- --模型
-- specail_model = [[File00000376 - RC.mdx]],
-- --类型
-- item_type = "装备",
-- --品质
-- color ='黑',
-- --描述
-- tip = [[

-- |cffcccccc耶路撒冷发现的一件迷人的小护身符，是人们一直痴迷于抵御传说中的邪恶之眼

-- |cff00ff00技能伤害加深+50%
-- ]],
-- --物品技能
-- is_skill = true,
-- ['技能伤害加深'] = 50,
-- --物品详细介绍的title
-- content_tip = '|cffffe799物品说明：|r'
-- } 


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
--描述
tip = [[

|cffcccccc嗜血阴灵，伴身左右，逆鳞在手，傲视神魔

|cff00ff00攻击速度+200% 
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
    hero:add('攻击速度',200)

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
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('攻击速度',-200)
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
--cd 
cool = 1,
--品质
color ='黑',
--描述
tip = [[

|cffcccccc固本培元、养益气血

|cff00ff00点击可食用，最大生命值+35%
]],
['生命上限%'] = 35,
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

local mt = ac.skill['明光追影刀']
mt{
--等久
level = 1,
art = [[mgzyd.blp]],
specail_model = [[File00000376 - RC.mdx]],
item_type = "装备",
color ='黑',
tip = [[

|cffcccccc刀光一闪，寒光下映射的一道血光溅起，被砍死的人看到了自己的眼睛。

|cff00ff00+1亿   力量
+200% 分裂伤害
+500% 暴击加深
+100% 物理伤害加深

|cffff0000战士专属（仅战士携带有效）]],
['力量'] = function(self)
    return self.owner.production=='战士' and  100000000 or 0
end,
['分裂伤害'] =  function(self)
    return self.owner.production=='战士'  and  200 or 0
end,
['暴击加深'] = function(self)
    return self.owner.production=='战士'  and  500 or 0
end,
['物理伤害加深'] = function(self)
    return self.owner.production=='战士'  and  100 or 0
end,
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  


local mt = ac.skill['血魂冰魄魔杖']
mt{
--等久
level = 1,
art = [[bhfz.blp]],
specail_model = [[File00000376 - RC.mdx]],
item_type = "装备",
color ='黑',
tip = [[

|cffcccccc强者的世界,属性的世界。

|cff00ff00+1亿   智力
+15%  技能冷却
+25%  触发概率加成
+500% 技暴加深

|cffff0000法师专属（仅法师携带有效）]],
['智力'] = function(self)
    return self.owner.production=='法师' and  100000000 or 0
end,
['技能冷却'] =  function(self)
    return self.owner.production=='法师'  and  15 or 0
end,
['触发概率加成'] = function(self)
    return self.owner.production=='法师'  and  25 or 0
end,
['技暴加深'] = function(self)
    return self.owner.production=='法师'  and  500 or 0
end,
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  


local mt = ac.skill['灵魂之弦']
mt{
--等久
level = 1,
art = [[lhzx.blp]],
specail_model = [[File00000376 - RC.mdx]],
item_type = "装备",
color ='黑',
tip = [[

|cffcccccc灵云缥缈海凝光，疑有疑无在哪边？

|cff00ff00+1亿   敏捷
+2   多重射
-0.2  攻击间隔
+200 攻击距离
+150% 物理伤害加深

|cffff0000射手专属（仅射手携带有效）]],
['敏捷'] = function(self)
    return self.owner.production=='射手' and  100000000 or 0
end,
['多重射'] =  function(self)
    return self.owner.production=='射手'  and  2 or 0
end,
['攻击间隔'] = function(self)
    return self.owner.production=='射手'  and  -0.2 or 0
end,
['攻击距离'] = function(self)
    return self.owner.production=='射手'  and  200 or 0
end,
['物理伤害加深'] = function(self)
    return self.owner.production=='射手'  and  150 or 0
end,
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  


local mt = ac.skill['无尽战刃']
mt{
--等久
level = 1,
art = [[wjzr.blp]],
specail_model = [[File00000376 - RC.mdx]],
item_type = "装备",
color ='黑',
tip = [[

|cffcccccc暗月洒下第一滩污血，时空之神的瞳孔即将打开。

|cff00ff00+5000万 全属性
+350% 暴击加深
+350% 技暴加深
+350% 会心伤害

|cffff0000杀手专属（仅杀手携带有效）]],
['全属性'] = function(self)
    return self.owner.production=='杀手' and  50000000 or 0
end,
['暴击加深'] =  function(self)
    return self.owner.production=='杀手'  and  350 or 0
end,
['技暴加深'] = function(self)
    return self.owner.production=='杀手'  and  350 or 0
end,
['会心伤害'] = function(self)
    return self.owner.production=='杀手'  and  350 or 0
end,
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  

local mt = ac.skill['维特的另一条腿']
mt{
--等久
level = 1,
art = [[wtzj.blp]],
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "消耗品",
--cd 
cool = 1,
color ='黑',
tip = [[

|cffcccccc神奇的力量，神奇的秘密。
 ]],
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  
function mt:on_cast_start()
    --传送
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    -- print(ac.map.rects['奶牛区'],ac.map.rects['奶牛区']:get_point())
    hero:blink(ac.map.rects['奶牛区'],true,false,true)
    --开启奶牛刷怪
    for i=1,3 do 
        local crep = ac.creep['奶牛'..i]
        crep:start()
    end 
    --倒计时
    if not ac.flag_jixian then
        ac.flag_jixian={}
    end    
    if ac.flag_jixian['奶牛'] then 
        ac.flag_jixian['奶牛']:remove()
    end    
    ac.flag_jixian['奶牛'] = ac.timer_ex 
    {
        time = 3*60, 
        -- time = 30,  --测试
        title = '奶牛'.."区,关闭倒计时：",
        func = function ()--关闭刷怪
            for i=1 ,3 do 
                local crep = ac.creep['奶牛'..i] 
                crep:finish(true)
            end  
            ac.flag_jixian['奶牛'] = nil
        end,
    }
   
end    

local mt = ac.skill['制裁之刃']
mt{
--等久
level = 1,
--图标
art = [[zczr.blp]],
--模型
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "装备",
--品质
color ='黑',
--描述
tip = [[

|cffcccccc被它刺中的伤口,是世界上最令人绝望的伤口

|cff00ff00攻击+2.5亿，吸血+20%
|cff00ff00唯一被动-内伤：10几率对周围敌人造成生命恢复效果减少50%，持续0.5秒
]],
area = 500,
--物品技能
is_skill = true,
--值
value = -50,
time =0.5,
chance = 10,
effect = [[Effect_az_heiseguangzhu.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}  
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('攻击',250000000)
    hero:add('吸血',20)

    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
        end 
		local rand = math.random(1,100)
        if rand <= self.chance then 
            --目标特效
            ac.effect(damage.target:get_point(),self.effect,0,1,'origin'):remove()

            for _,unit in ac.selector()
			: in_range(damage.target,skill.area)
			: is_enemy(hero)
			: ipairs()
			do 
                unit:add_buff('生命恢复效果')
                {
                    value = self.value,
                    source = hero,
                    time = self.time,
                    skill = self,
                }
			end 
		end
    end)    
   
end  
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('攻击',-250000000)
    hero:add('吸血',-20)
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    -- p.flag_added = false 
end 



ac.black_item = {
   '荒芜之戒','噬魂','魔鬼金矿','魔鬼的砒霜','维特的另一条腿','马可波罗的万花铳','聚宝盆','七星剑','金鼎烈日甲',
   '死神之触','大力丸','末世',
   '明光追影刀','血魂冰魄魔杖','灵魂之弦','无尽战刃'
}
--吞噬丹 吞噬技能（会执行技能上面的属性和on_add）
ac.tunshi_black_item =[[
荒芜之戒 噬魂 死神之触 

]]


