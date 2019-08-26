--物品名称
local mt = ac.skill['法师流派']
mt{
--等久
level = 1,
--图标
art = [[hwzj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - RC.mdx]],
--描述
tip = [[

|cffcccccc人不仁，无信无义。王不仁，无德无量。地不仁，无草无木。天不仁，无世间万物。万年圣物，荒芜之戒。

|cff00ff00所有队友的攻击减甲+250
]],
--物品技能
is_skill = true,
['智力%'] = 35,
['技暴加深'] = 35,
['会心伤害'] = 35,
['技能伤害加深'] = 35,
['全伤加深'] = 35,
['对BOSS额外伤害'] = 35,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['射手流派']
mt{
--等久
level = 1,
--图标
art = [[hwzj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
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
['智力%'] = 35,
['技暴加深'] = 35,
['会心伤害'] = 35,
['技能伤害加深'] = 35,
['全伤加深'] = 35,
['对BOSS额外伤害'] = 35,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['杀手流派']
mt{
--等久
level = 1,
--图标
art = [[hwzj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
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
['智力%'] = 35,
['技暴加深'] = 35,
['会心伤害'] = 35,
['技能伤害加深'] = 35,
['全伤加深'] = 35,
['对BOSS额外伤害'] = 35,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['死狱尊吾刀']
mt{
--等久
level = 1,
--图标
art = [[hwzj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - RC.mdx]],
--描述
tip = [[

|cffcccccc人不仁，无信无义。王不仁，无德无量。地不仁，无草无木。天不仁，无世间万物。万年圣物，荒芜之戒。

|cff00ff00所有队友的攻击减甲+250
]],
--最大生命值
value = 8,
area =300,
chance = 1,
--物品技能
is_skill = true,
['智力%'] = 35,
['技暴加深'] = 35,
['会心伤害'] = 35,
['技能伤害加深'] = 35,
['全伤加深'] = 35,
['对BOSS额外伤害'] = 35,
effect = [[AZ_Leviathan_V2.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('杀怪加全属性',2500)
    hero:add('攻击加全属性',2500)
    hero:add('每秒加全属性',2500)

    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
        end 
		local rand = math.random(1,100)
        if rand <= self.chance then 
            --目标特效
            ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
            --目标减最大 
            for _,unit in ac.selector()
            : in_range(damage.target:get_point(),self.area)
            : is_enemy(hero)
            : ipairs()
            do 
                unit:damage
                {
                    source = hero,
                    damage = damage.target:get('生命上限')*self.value/100,
                    skill = skill,
                    real_damage = true --真伤
                }
            end 
		end
    end)    
   
end  
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('杀怪加全属性',-2500)
    hero:add('攻击加全属性',-2500)
    hero:add('每秒加全属性',-2500)
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    -- p.flag_added = false 
end 


ac.god_item = {
    '法师流派','射手流派','杀手流派','死狱尊吾刀'
}

--吞噬丹 吞噬技能（会执行技能上面的属性和on_add）
ac.wait(10,function()
    local item =[[
死狱尊吾刀
    ]]
    ac.tunshi_black_item =ac.tunshi_black_item .. item
end)



ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_name() ~='奶牛' then 
        return
    end    
    local p = killer:get_owner()
    p.kill_nainiu = (p.kill_nainiu or 0) +1
    local hero =p.hero
    if p.kill_nainiu == 100 then 
         --创建 猴
        local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
        local u = ac.player(12):create_u('超级大菠萝',point)
        u:add_buff '定身'{
            time = 2
        }
        u:add_buff '无敌'{
            time = 2
        }
        u:event '单位-死亡' (function(_,unit,killer) 
            --给随机神器
            local rand_item = ac.god_item[math.random(#ac.god_item)]
            ac.item.create_item(rand_item,unit:get_point())
        end)    
        p:sendMsg('|cffFFE799【系统消息】|r|cffff0000齐天大圣|r已出现，小心他的金箍棒 ',2)


        p.kill_nainiu = 0
    end 

end)