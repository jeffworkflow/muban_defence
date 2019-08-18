local japi = require("jass.japi")
local slk = require 'jass.slk'

local mt = ac.skill['Pa']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 pa',
--等级
level = 0,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNHeroWarden.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000达到铂金7星 且 地图等级≥3|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+50*Lv
【物理伤害加深】+25
【攻击减甲】+35|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(敏捷*20+1w)*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['赵子龙']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[zhaoyun.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000达到白银3星 且 地图等级≥2|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+35*Lv
【分裂伤害】+25%
【攻击减甲】+5

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*15+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['夏侯霸']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[xiahouba.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥5|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+35*Lv
【护甲】+1000
【物品获取率】+20%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*15+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['虞姬']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[yuji.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥10|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+100*Lv
【攻击速度】+50%
【全伤加深】+25%
【减少周围护甲】+1000

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*25+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['太极熊猫']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[taijixiongmao.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥15|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+188*Lv
【物品获取率】+75%
【木头加成】+75%
【杀敌数加成】+75%
【火灵加成】+75%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*30+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['至尊宝']
mt{
is_skill = 1,
--等级
level = 1,
is_spellbook = 1,
is_order = 2,
--图标
art = [[zhizunbao.blp]],
--说明
tip = [[

查看 至尊宝皮肤
 ]],
}
mt.skills = {
    '至尊宝皮肤A','至尊宝皮肤B',
}
-- mt.on_add = ac.skill['巅峰神域'].on_add
function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        local has_mall = player.mall[self.name] or (player.cus_server and player.cus_server[self.name])
        -- print(skill.name,'所需地图等级',ac.server.need_map_level[skill.name]) and player:Map_GetMapLevel() >= (ac.server.need_map_level[skill.name]  or 0) 
        if has_mall and has_mall > 0 then 
            skill:set_level(1)
        end
    end 

end    

local mt = ac.skill['至尊宝皮肤A']
mt{
is_skill = 1,
is_order = 1,
--等级
level = 0,
--图标
art = [[zhizunbao.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000商城购买|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+288*Lv
【攻击减甲】+100
【物理伤害加深】+150%
【全伤加深】+50%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*20+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
effect = 'zhizunbao.mdx'
}

local mt = ac.skill['至尊宝皮肤B']
mt{
is_skill = 1,
is_order = 1,
--等级
level = 0,
--图标
art = [[zhizunbao.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000商城购买|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+288*Lv
【攻击减甲】+100
【物理伤害加深】+150%
【全伤加深】+50%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*20+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
effect = 'wukong2.mdx'
}

local mt = ac.skill['狄仁杰']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[direnjie.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥25|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+288*Lv
【攻击速度】+100%
【攻击减甲】+50
【多重射】+2
【物理伤害加深】+100%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*20+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['伊利丹']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[yinudan.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000地图等级≥32|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+388*Lv
【触发概率加成】+50%
【技暴几率】+20%
【技暴加深】+200%
【技能伤害加深】+50%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(全属性*25+1w)*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['鬼厉']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[guili.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000商城购买|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+588*Lv
【减少周围护甲】+3500
【物理伤害加深】+400%
【免伤】+35%
【全伤加深】+100%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（全属性*40+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
}

local mt = ac.skill['剑仙']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
--图标
art = [[jianxian.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000商城购买|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+888*Lv
【免伤】+50%
【全伤加深】+200%
【攻击减甲】+250
【对BOSS额外伤害】+50%|r

|cff00bdec【被动效果】攻击20%几率造成范围技能伤害
【伤害公式】(全属性*60+1w)*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
['技能伤害加深'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if p.mall and (p.mall['鬼厉'] or 0 >=1) and (p.mall['至尊宝'] or 0 >=1) then 
        val = 35
    end    
    return val
end,
['物理伤害加深'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if p.mall and (p.mall['鬼厉'] or 0 >=1) and (p.mall['至尊宝'] or 0 >=1) then 
        val = 100
    end    
    return val
end,
['攻击减甲'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if p.mall and (p.mall['鬼厉'] or 0 >=1) and (p.mall['至尊宝'] or 0 >=1) then 
        val = 125
    end    
    return val
end,
['全伤加深'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if p.mall and (p.mall['鬼厉'] or 0 >=1) and (p.mall['至尊宝'] or 0 >=1) then 
        val = 100
    end    
    return val
end,
['对BOSS额外伤害'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if p.mall and (p.mall['鬼厉'] or 0 >=1) and (p.mall['至尊宝'] or 0 >=1) then 
        val = 25
    end    
    return val
end,
}

local mt = ac.skill['手无寸铁的小龙女']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 手无寸铁的小龙女',
--等级
level = 0,
--图标
art = [[xiaolongnv.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000达到星耀10星 且 地图等级≥6|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+100*Lv
【触发概率加成】+25%
【技暴几率】+15%
【技暴加深】+150%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*25+10000）*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 50,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['杀怪加攻击'] = 750,
-- ['暴击几率'] = 5,
-- ['技暴几率'] = 5,
-- ['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
}

local mt = ac.skill['关羽']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 关羽',
--等级
level = 0,
--图标
art = [[guanyu.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cffff0000达到最强王者15星 且 地图等级≥10|r

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加全属性】+188*Lv
【杀敌数加成】+75%
【物品获取率】+75%
【木头加成】+75%
【火灵加成】+75%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(全属性*10+1w)*Lv

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r
]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 50,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
-- ['杀怪加攻击'] = 750,
-- ['暴击几率'] = 5,
-- ['技暴几率'] = 5,
-- ['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
}




for i,name in ipairs({'赵子龙','Pa','虞姬','手无寸铁的小龙女','太极熊猫','关羽','狄仁杰','伊利丹','至尊宝皮肤A','至尊宝皮肤B','鬼厉','剑仙',}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        local target_name = name
        --连续点两下Pa取消特效
        if player.last_tran_unit and player.last_tran_unit == name then 
            target_name = hero:get_name()
        end    

        local id 
        local new_model 
        if not finds(target_name,'至尊宝') then 
            id = ac.table.UnitData[target_name].id
            new_model = slk.unit[id].file
            if new_model and not getextension(new_model) then 
                new_model = new_model..'.mdl'
            end	
        else
            new_model = self.effect
        end    
        -- print(new_model)
        --改模型
        if self.level > 0 then 
            japi.SetUnitModel(hero.handle,new_model)
        end   
        player.last_tran_unit = target_name  
        -- ac.wait(10,function() 
        --     --改变大小
        --     if name == '骨龙' then 
        --         hero:set_size(2.5)
        --     elseif name == '精灵龙' then 
        --         hero:set_size(1.5)
        --     else
        --         hero:set_size(1)
        --     end  
            
        -- end)
    end   
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    

