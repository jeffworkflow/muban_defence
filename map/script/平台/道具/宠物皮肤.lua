local japi = require("jass.japi")
--宠物皮肤
local mt = ac.skill['耐瑟龙']
mt{
is_skill = 1,
item_type ='神符',    
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNNetherDragon.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff神龙碎片超过 10 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+8    杀怪加全属性|r
|cff00ff00+10% 杀敌数加成|r
|cff00ff00+15% 分裂伤害|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 8,
['杀敌数加成'] = 10,
['分裂伤害'] = 15,
--特效
effect = [[units\creeps\NetherDragon\NetherDragon.mdx]]
}

local mt = ac.skill['冰龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNAzureDragon.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff神龙碎片超过 50 自动获得，已拥有碎片：|r%skin_cnt% 或者
|cff00ffff挖宝积分超过 1W 自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+28   杀怪加全属性|r
|cff00ff00+25% 金币加成|r
|cff00ff00+25% 木头加成|r
|cff00ff00+20% 吸血|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,

--所需激活碎片
need_sp_cnt = 50,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 28,
['金币加成'] = 25,
['木头加成'] = 25,
['吸血'] = 20,
--特效
effect = [[units\creeps\AzureDragon\AzureDragon.mdx]]
}

local mt = ac.skill['精灵龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNFaerieDragon.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff神龙碎片超过 250  自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+68  杀怪加全属性|r
|cff00ff00+15% 金币加成|r
|cff00ff00+15% 木头加成|r
|cff00ff00+15% 杀敌数加成|r
|cff00ff00+10% 每秒回血|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 8,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 250,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['金币加成'] = 15,
['木头加成'] = 15,
['杀敌数加成'] = 15,
['每秒回血'] = 10,
--特效
effect = [[units\nightelf\FaerieDragon\FaerieDragon.mdx]]
}


local mt = ac.skill['骨龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[gulong.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【宠物属性】：|r
|cff00ff00+88   杀怪加全属性|r
|cff00ff00+35% 物品获取率|r
|cff00ff00+35% 火灵加成|r
|cff00ffff+35   攻击减甲|r
|cff00ffff+15% 触发概率加成|r
|cff00ffff-10% 技能冷却|r
|cffffff00小悟空+骨龙激活：技能伤害加深+75%， 攻击减甲+100，触发概率加成+35%

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88,
['物品获取率'] = 35,
['火灵加成'] = 35,
['攻击减甲'] = function(self) 
    local val = 35 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['小悟空'] or 0) >=1 then 
        val = val + 100
    end    
    return val
end,
['触发概率加成'] = function(self) 
    local val = 15 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['小悟空'] or 0) >=1 then 
        val = val + 35
    end    
    return val
end,
['技能伤害加深'] = function(self) 
    local val = 0 
    local p = self.owner:get_owner()
    if (p.mall and p.mall['小悟空'] or 0) >=1 then 
        val = val + 75
    end    
    return val
end,
['技能冷却'] = 10,
--特效
effect = [[gulong.mdx]]
}

local mt = ac.skill['奇美拉']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNChimaera.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff神龙碎片超过 350 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+128    杀怪加全属性|r
|cff00ff00+25%  火灵加成|r
|cff00ff00+25%  物品获取率|r
|cff00ff00-0.05  攻击间隔|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 13,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 400,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 128,
['火灵加成'] = 25,
['物品获取率'] = 25,
['攻击间隔'] = -0.05,
--特效
effect = [[units\nightelf\Chimaera\Chimaera.mdx]]
}

local mt = ac.skill['小悟空']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[xwk.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【宠物属性】：|r
|cff00ff00+188  杀怪加全属性|r
|cff00ff00+35% 金币加成|r
|cff00ff00+35% 木头加成|r
|cff00ff00+35% 杀敌数加成|r
|cff00ffff+50   攻击减甲|r
|cff00ffff+25% 触发概率加成|r
|cff00ffff-15% 技能冷却|r
|cffffff00小悟空+骨龙激活：技能伤害加深+75%， 攻击减甲+100，触发概率加成+35%

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 188,
['木头加成'] = 35,
['金币加成'] = 35,
['杀敌数加成'] = 35,
['攻击减甲'] = 50,
['触发概率加成'] = 25,
['技能冷却'] = 15,
--特效
effect = [[xwk.mdx]],
}

local mt = ac.skill['魅影']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[meiying.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 4.5W 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff神龙碎片超过 400  自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【属性】：|r
|cff00ff00+148  杀怪加全属性|r
|cff00ff00+45   攻击减甲|r
|cff00ff00+2.5% 免伤几率|r
|cff00ff00+10%  技能伤害加深|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r
]],

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 15,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,

['杀怪加全属性'] = 148,
['攻击减甲'] = 45,
['免伤几率'] = 2.5,
['技能伤害加深'] = 10,
--特效
effect = [[Hero_Netherdrake_N1.mdx]],
}


local mt = ac.skill['紫霜幽幻龙鹰']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[zsyhly.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 7W 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff神龙碎片超过 500  自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+188  杀怪加全属性|r
|cff00ff00+60 攻击减甲|r
|cff00ff00+2.5% 闪避|r
|cff00ff00+10% 技能伤害加深|r
|cff00ff00+10% 会心伤害|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 17,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,
--所需激活碎片
need_sp_cnt = 650,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 188,
['攻击减甲'] = 60,
['闪避'] = 2.5,
['技能伤害加深'] = 10,
['会心伤害'] = 10,
--特效
effect = [[Hero_Phoenix_N1_purple.mdx]],
}

local mt = ac.skill['齐天大圣']
mt{
is_skill = 1,
--等级
level = 0,
is_spellbook = 1,
is_order = 2,
--图标
art = [[cwqtds.blp]],
--说明
tip = [[

查看 齐天大圣皮肤
 ]],
}
mt.skills = {
    '齐天大圣A','齐天大圣B',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        local has_mall = player.mall[skill.name] 
        -- print(skill.name,'所需地图等级',ac.server.need_map_level[skill.name]) and player:Map_GetMapLevel() >= (ac.server.need_map_level[skill.name]  or 0) 
        if has_mall and has_mall > 0 then 
            skill:set_level(1)
        end
    end 

end    

local mt = ac.skill['齐天大圣A']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[cwqtds.blp]],
title = [[齐天大圣A（绝版）]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【宠物属性】：|r
|cff00ff00+488  杀怪加全属性|r
|cff00ff00+40 每秒加护甲|r
|cff00ff00杀敌数额外+1|r
|cff00ff00练功房怪物数量+3|r

|cffff0000【唯一被动】每秒减少宠物周围敌人血量的5%

|cffffff00齐天大圣+真龙天子激活：攻击减甲+288，全伤加深+288%

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['每秒加护甲'] = 40,
['额外杀敌数'] = 1,  
--特效
effect = [[qtds.mdx]],
}
function mt:on_add()
    --唯一被动
    self.owner:add_skill('火焰','隐藏')
    --练功房数量
    local p = self.owner:get_owner()
    p.more_unit = (p.more_unit or 0) + 3
end    


local mt = ac.skill['齐天大圣B']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
title ='齐天大圣B（新版）',
--图标
art = [[cwqtds.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【宠物属性】：|r
|cff00ff00+488  杀怪加全属性|r
|cff00ff00+488  攻击减甲|r
|cff00ff00+488%  全伤加深|r
|cff00ffff+5%   会心几率|r
|cff00ffff+50%  会心伤害|r
|cffff0000+40 每秒加护甲|r
|cffff0000杀敌数额外+1|r
|cffff0000练功房怪物数量+3|r

|cffdf19d0【唯一被动】每秒减少宠物周围敌人血量的5%（对BOSS无效）

|cffffff00齐天大圣+真龙天子激活：攻击减甲+288，全伤加深+288%

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['攻击减甲'] = 488,
['全伤加深'] = 488,
['会心几率'] = 5,
['会心伤害'] = 150,
['每秒加护甲'] = 40,
['额外杀敌数'] = 1,  
--特效
effect = [[qtds.mdx]],
}
function mt:on_add()
    --唯一被动
    self.owner:add_skill('火焰1','隐藏')
    --练功房数量
    local p = self.owner:get_owner()
    p.more_unit = (p.more_unit or 0) + 3
end    


local mt = ac.skill['天马行空']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[tmxk.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 10W 自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+288  杀怪加全属性|r
|cff00ff00+288  攻击减甲|r
|cff00ff00+35%  技暴加深|r
|cff00ff00+35%  技能伤害加深|r
|cff00ff00+35%  会心伤害|r

|cffffff00获得特殊技能：自动寻宝（英雄技能）|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 33,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,
--所需激活碎片
need_sp_cnt = 850,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 288,
['攻击减甲'] = 288,
['技暴加深'] = 35,
['技能伤害加深'] = 35,
['会心伤害'] = 35,
--特效
effect = [[Pet_TMXK.mdx]],
}
function mt:on_add()
    local hero =self.owner
    local p = hero:get_owner()
    hero = p.hero
    hero.wabao_auto = true --自动挖宝
end    

local mt = ac.skill['玉兔']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[yutu.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+26.8   杀怪加全属性|r
|cff00ff00+26.8   攻击减甲|r
|cff00ff00+26.8%  火灵加成|r
|cff00ff00+26.8%  全伤加深|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,
--所需激活碎片
need_sp_cnt = 850,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 26.8,
['攻击减甲'] = 26.8,
['火灵加成'] = 26.8,
['全伤加深'] = 26.8,
--特效
effect = [[RabbitGold2_BC.mdx]],
} 

local mt = ac.skill['七彩凤凰']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[qcfh.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff深渊乱斗|cffff0000累计|cff00ffff无尽波数=300波

|cffFFE799【宠物属性】：|r
|cff00ff00+288  杀怪加全属性|r
|cff00ff00+288  攻击减甲|r
|cff00ff00+35%  暴击加深|r
|cff00ff00+35%  物理伤害加深|r
|cff00ff00+35%  会心伤害|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 38,

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 288,
['攻击减甲'] = 288,
['暴击加深'] = 35,
['物理伤害加深'] = 35,
['会心伤害'] = 35,

--特效
effect = [[FH.mdx]],
} 

--统一加方法
for i,name in ipairs({'耐瑟龙','冰龙','精灵龙','奇美拉','魅影','紫霜幽幻龙鹰','天马行空','玉兔','七彩凤凰','骨龙','小悟空','齐天大圣A','齐天大圣B'}) do
    local mt = ac.skill[name]

    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()

        --改模型
        if self.level > 0 then 
            japi.SetUnitModel(hero.handle,self.effect)
        end     
        ac.wait(10,function() 
            --改变大小
            local skl = hero:find_skill('宠物天赋',nil,true)
            local base_size = skl.level * 0.5/100
            if name == '骨龙' then 
                hero:set_size(2.5 *(1+base_size))
            elseif name == '精灵龙' then 
                hero:set_size(1.5*(1+base_size))
            else
                hero:set_size(1*(1+base_size))
            end  
            
        end)


    end    
    -- mt.on_add = mt.on_cast_start --自动显示特效
   
end    

local mt = ac.skill['宠物皮肤']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cwpf.blp]],
    title = '宠物皮肤',
    tip = [[

|cffffe799【使用说明】：|r
点击查看|cff00ffff宠物皮肤|r
    ]],
}
mt.skills = {
    '耐瑟龙','冰龙','精灵龙','奇美拉','魅影','紫霜幽幻龙鹰','天马行空','骨龙','小悟空','齐天大圣','宠物皮肤-下一页'
}
function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 

        local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
        if skill.name == '齐天大圣' then 
            print( player.mall[skill.name..'A'], player.mall[skill.name..'B'])
            has_mall = player.mall[skill.name..'A'] or player.mall[skill.name..'B']
        end    
        if has_mall and has_mall > 0 then 
            skill:set_level(1)
        end
    end 
end  


local mt = ac.skill['宠物皮肤-下一页']
mt{
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

查看 下一页
    ]], 
    is_spellbook = 1,
    is_order = 2,
}
mt.skills = {'玉兔','七彩凤凰',}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
        if has_mall and has_mall > 0 then 
            skill:set_level(1)
        end
    end 
end  
