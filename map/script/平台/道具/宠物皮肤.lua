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
|cff00ffff神龙碎片超过 50 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+8    杀怪加全属性|r
|cff00ff00+15% 杀敌数加成|r
|cff00ff00+15% 分裂伤害|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 15,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 8,
['杀敌数加成'] = 15,
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
|cff00ffff神龙碎片超过 75 自动获得，已拥有碎片：|r%skin_cnt% 或者
|cff00ffff挖宝积分超过 2W 自动获得，已拥有积分：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+28   杀怪加全属性|r
|cff00ff00+15% 金币加成|r
|cff00ff00+15% 木头加成|r
|cff00ff00+10% 吸血|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 75,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 28,
['金币加成'] = 15,
['木头加成'] = 15,
['吸血'] = 10,
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
|cff00ffff神龙碎片超过 500  自动获得，已拥有碎片：|r%skin_cnt%

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
need_sp_cnt = 500,
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
|cff00ff00+68   杀怪加全属性|r
|cff00ff00+25% 物品获取率|r
|cff00ff00+25% 火灵加成|r
|cff00ff00+15   攻击减甲|r
|cff00ff00+10% 触发概率加成|r
|cff00ff00-5%  技能冷却|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['物品获取率'] = 25,
['火灵加成'] = 25,
['攻击减甲'] = 15,
['触发概率加成'] = 10,
['技能冷却'] = 5,
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
|cff00ffff神龙碎片超过 800 自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+128    杀怪加全属性|r
|cff00ff00+25%  火灵加成|r
|cff00ff00+25%  物品获取率|r
|cff00ff00-0.05  攻击间隔|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
need_map_level = 10,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[self.name..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 800,
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
|cff00ff00+168  杀怪加全属性|r
|cff00ff00+20% 金币加成|r
|cff00ff00+20% 木头加成|r
|cff00ff00+20% 杀敌数加成|r
|cff00ff00+15   攻击减甲|r
|cff00ff00+10% 触发概率加成|r
|cff00ff00-5%  技能冷却|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 168,
['木头加成'] = 20,
['金币加成'] = 20,
['杀敌数加成'] = 20,
['攻击减甲'] = 15,
['触发概率加成'] = 10,
['技能冷却'] = 5,
--特效
effect = [[xwk.mdx]],
}

--统一加方法
for i,name in ipairs({'耐瑟龙','冰龙','精灵龙','骨龙','奇美拉','小悟空'}) do
    local mt = ac.skill[name]

    function mt:on_add()
        local hero = self.owner
        local player = self.owner:get_owner()

        --改模型
        if self.level > 0 then 
            japi.SetUnitModel(hero.handle,self.effect)
        end     
        ac.wait(10,function() 
            --改变大小
            if name == '骨龙' then 
                hero:set_size(2.5)
            elseif name == '精灵龙' then 
                hero:set_size(1.5)
            else
                hero:set_size(1)
            end  
            
        end)


    end    
    mt.on_cast_start = mt.on_add
   
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
    '耐瑟龙','冰龙','精灵龙','骨龙','奇美拉','小悟空'
}
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


