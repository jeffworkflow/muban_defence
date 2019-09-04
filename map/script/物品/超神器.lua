--物品名称
local mt = ac.skill['古代护身符']
mt{
--等久
level = 1,
--图标
art = [[gdhsf.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc耶路撒冷发现的一件迷人的小护身符，是人们一直痴迷于抵御传说中的邪恶之眼

|cff00ff00智力+35%
|cff00ffff技暴加深+800%
|cff00ffff会心伤害+400%
|cff00ffff技能伤害加深+200%
|cffffff00全伤加深+100%
|cffffff00对BOSS额外伤害+50%
]],
--物品技能
is_skill = true,
['智力%'] = 35,
['技暴加深'] = 800,
['会心伤害'] = 400,
['技能伤害加深'] = 200,
['全伤加深'] = 100,
['对BOSS额外伤害'] = 50,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['太初威丸弹弓']
mt{
--等久
level = 1,
--图标
art = [[tcwwdg.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc杀伤力和威慑力极大的一种新型兵器

|cff00ff00敏捷+35%
|cff00ffff攻击减甲+500
|cff00ffff多重射+3
|cffffff00攻击距离+200 
|cffff0000极致的攻击间隔/攻击速度
]],
--物品技能
is_skill = true,
['敏捷%'] = 35,
['攻击减甲'] = 500,
['多重射'] = 3,
['攻击距离'] = 200,
['攻击速度'] = 500,
['攻击间隔'] = -1,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['贯月昆吾剑']
mt{
--等久
level = 1,
--图标
art = [[gykwj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc祖妖昆吾死后,全身精血骨骸凝聚成了一把剑型武器，月圆之夜就会对月咆哮，似欲贯月一般！

|cff00ff00敏捷+35%
|cff00ffff暴击加深+800%
|cff00ffff会心伤害+400%
|cff00ffff物理伤害加深+200%
|cffffff00全伤加深+100%
|cffffff00对BOSS额外伤害+50%
]],
--物品技能
is_skill = true,
['敏捷%'] = 35,
['暴击加深'] = 800,
['会心伤害'] = 400,
['物理伤害加深'] = 200,
['全伤加深'] = 100,
['对BOSS额外伤害'] = 50,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['死狱尊吾刀']
mt{
--等久
level = 1,
--图标
art = [[syzwd.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc经过亿万年的沉淀，死狱血海出现了一把刀状武器，散发着浓烈的血腥气，通体如红宝石一般皎洁无瑕！

|cff00ff00杀怪/攻击/每秒加全属性+2500
|cff00ffff攻击1% 几率对范围的敌人，造成最大生命值8%的伤害
]],
--最大生命值
value = 8,
area =300,
chance = 1,
--物品技能
is_skill = true,
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

    if not hero.flag_syzwd then 
        hero.flag_syzwd = true
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
   
end  
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('杀怪加全属性',-2500)
    hero:add('攻击加全属性',-2500)
    hero:add('每秒加全属性',-2500)
    hero.flag_syzwd = false
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    -- p.flag_added = false 
end 


local mt = ac.skill['混沌太虚甲']
mt{
--等久
level = 1,
--图标
art = [[hdtxj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc十大神器之一，相传为盘古大神破开天地之后，天地胎膜所化，性能不详。

]],
--物品技能
is_skill = true,
['护甲%'] = 25,
['免伤'] = 25,
['免伤几率'] = 25,
['闪避'] = 25,
['每秒回血'] = 25,


--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}

local mt = ac.skill['盘古开天斧']
mt{
--等久
level = 1,
--图标
art = [[pgktf.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc十大神器之一，具有毁天灭地之能，相传为盘古大神所持破开天地之物，性能不详。

]],
--物品技能
is_skill = true,
['力量%'] = 35,
['攻击%'] = 100,
['分裂伤害'] = 500,
['减少周围护甲'] = 5000,
['全伤加深'] = 200,
['对BOSS额外伤害'] = 100,
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}


local mt = ac.skill['往生女娲泪']
mt{
--等久
level = 1,
--图标
art = [[wsnwl.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc女娲的慈悲之泪，具有起死回生之效，佩戴者可以长生不死，青春永葆。

|cff00ff00每秒加全属性+50000
杀怪加攻击+8888
全伤加深+150%

|cff00ffff唯一被动-守护天使：死亡时有 25% 的几率复活，并恢复60%的生命值
]],
--物品技能
is_skill = true,
chance = 25,
heal = 60,
effect = [[Abilities\Spells\Human\Resurrect\ResurrectCaster.mdl]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('每秒加全属性',50000)
    hero:add('杀怪加攻击',8888)
    hero:add('全伤加深',150)
    if not hero.flag_wsnwl then 
        hero.flag_wsnwl = true
        self.trg = hero:event '单位-即将死亡' (function (_,unit,killer)
        
            local rand = math.random(1,100)
            if rand <= self.chance then 
                --目标特效
                -- ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
                hero:add_effect('chest',self.effect):remove()
                --目标减最大 
                hero:heal
                {
                    source = hero,
                    skill = skill,
                    string = '守护天使',
                    size = 10,
                    heal = hero:get('生命上限') * skill.heal/100,
                }	
                -- hero:add('护甲',1000000000)
                return true
            end
        end)    
    end    

end   
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('每秒加全属性',-50000)
    hero:add('杀怪加攻击',-8888)
    hero:add('全伤加深',-150)
    hero.flag_wsnwl = false
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    
end    


local mt = ac.skill['回梦昆仑镜']
mt{
--等久
level = 1,
--图标
art = [[hmklj.blp]],
--类型
item_type = "装备",
--品质
color ='神',
--模型
specail_model = [[File00000376 - Z.mdx]],
--描述
tip = [[

|cffcccccc女娲为救族人以自身神位为代价，于昆仑山之巅化成了一面可以穿越时空界限，可以回到过去，穿越未来的镜子

|cff00ff00暴击加深+800%
技暴加深+800%
会心伤害+800%

|cff00ffff唯一被动-穿越：攻击1%几率让敌人回到过去，并造成大量伤害
]],
--物品技能
is_skill = true,
chance = 1, --测试
real_damage_rate = 95,
effect = [[xrdh.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799物品说明：|r'
}
function mt:on_add()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('暴击加深',800)
    hero:add('技暴加深',800)
    hero:add('会心伤害',800)

    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
        end 
        local str = table.concat(ac.attack_unit)
        if not finds(str,damage.target:get_name()) then 
            return 
        end    
		local rand = math.random(1,100)
        if rand <= self.chance then 
            --目标特效
            ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
            -- hero:add_effect('chest',self.effect):remove()
            --目标减最大 
            damage.target:damage
            {
                source = hero,
                damage = damage.target:get('生命')*self.real_damage_rate/100,
                skill = skill,
                real_damage = true --真伤
            }
            --传送
            if damage.target:is_alive() then 
                damage.target:set_position(ac.map.rects['进攻点']:get_point())
                --目标特效
                ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
            end    
           
        end
        return true
    end)    

end   
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    local skill = self
    hero:add('暴击加深',-800)
    hero:add('技暴加深',-800)
    hero:add('会心伤害',-800)
    
    if self.trg then 
        self.trg:remove()
        self.trg = nil 
    end    
    
end    

ac.god_item = {
    '古代护身符','太初威丸弹弓','贯月昆吾剑','死狱尊吾刀','混沌太虚甲','盘古开天斧','往生女娲泪','回梦昆仑镜'
}

--吞噬丹 吞噬技能（会执行技能上面的属性和on_add）
ac.wait(10,function()
    local item =[[
死狱尊吾刀 往生女娲泪 回梦昆仑镜
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
    if p.kill_nainiu == 3250 then 
         --创建 猴
        local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
        local u = ac.player(12):create_unit('超级大菠萝',point)
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
        p:sendMsg('|cffFFE799【系统消息】|r|cffff0000超级大菠萝|r已出现，小心他超强的攻击力和毁天灭地的魔法 ',2)


        p.kill_nainiu = 0
    end 

end)