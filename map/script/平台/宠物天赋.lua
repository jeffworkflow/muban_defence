local japi = require("jass.japi")
local dbg = require 'jass.debug'
local unit = require 'types.unit'

local mt = ac.skill['宠物天赋']
mt{
    is_spellbook = 1,
    -- is_order = 2,
    --可能会掉线 math.min(100,ac.player.self:Map_GetMapLevel()),
    max_level = 100,
    --标题颜色
    color =  '紫',
	--介绍
    tip = [[|cff00ffff(可用天赋点：%spell_stack%|cff00ffff %need_xp_tip%|cff00ffff)|r

|cffFFE799【使用说明】：|r
|cff00ff00打开天赋菜单，分配宠物的天赋点|r
%strong_attr_tip%
|cffcccccc食用宠物经验书可升级宠物，宠物等级可存档，最大等级受限于地图等级|r
]],
    --初始等级
    level = 1, 
	--技能图标
    art = [[ReplaceableTextures\CommandButtons\BTNSkillz.blp]],
    model_size = function(self,hero)
        return 1 + self.level * 0.01
    end,  
    --充能模式
    -- cooldown_mode = 1,  
    -- cool = 999999,
    --显示层数
    show_stack = 1,
    --已学习点数
    used_point = 0,
    --剩余学习点数
    remain_point = function(self,hero)
        return (self.level - self.used_point)
    end,
    spell_stack = function(self,hero)
        return (self.level - self.used_point)
    end,
    strong_attr_tip = function(self,hero)
        local tip = ''
        local hero = self.owner:get_owner().hero 
        if hero.strong_attr then 
            for k,v in sortpairs(hero.strong_attr) do 
                -- print(hero,k,v[1],v[2])
                local sigle_value = v[1]
                local total_value = v[1] * v[2]
                local affict = '+'
                if v[1] < 0 then 
                    affict = ''
                end    

                local str = k:sub(-1)
                if str =='%' then 
                    k = k:sub(1,-2)
                    -- print('截取之后的字符串',k,k:sub(1,-2))
                    sigle_value = tostring(sigle_value) .. '%'
                    total_value = tostring(total_value) .. '%'
                end    
                -- print(value)
                v[4] = '|cff'..ac.color_code['淡黄']..affict.. sigle_value .. ' '..k..' ('..v[2]..'/'..v[3]..')'

                local total_tip = '|cff'..ac.color_code['淡黄']..affict.. total_value .. ' '..k..' ('..v[2]..'/'..v[3]..')'

                if v[2] ~= 0 then 
                    tip = tip ..total_tip..'|r\n' 
                end    
            end    
        end    
        return tip 
    end,  
    need_xp_tip =  function(self,hero )
        return '|cff00ffff升级还需经验：|r'..'|cff'..ac.color_code['绿']..self.need_xp..'|r'
    end,
    need_xp = 1000,
    effect =  [[Hero_CrystalMaiden_N2_V_boom.mdx]],   
	
}
mt.skills = {'宠物-杀敌数加成','宠物-木头加成','宠物-物品获取率加成','宠物-火灵加成','宠物-分裂伤害加成','宠物-攻击速度加成','宠物-杀怪力量成长','宠物-杀怪敏捷成长','宠物-杀怪智力成长','宠物-杀怪全属性成长','宠物-杀怪攻击成长'}

--每次升级增加 宠物模型大小
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    hero:set_size(self.model_size)
    -- print(self.effect)
    --升级特效
    local eff = ac.effect(hero:get_point(),self.effect,0,1,'chest'):remove()
end    
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    hero:set_size(self.model_size) 

    --处理 皮肤碎片相关
    local value = tonumber(p.cus_server['宠物天赋'])
    -- print(value)
    -- print('宠物天赋',value)
    if not value or value == '' or value == "" then
        value = 0 
    end
    ac.wait(500,function()
        if value > 0 then
            hero:peon_add_xp(value)
        end    
    end )
end

--宠物天赋里面的技能，
local peon_skill = {
    --技能，技能显示的名字，属性名，数值，图标，tip
    ['宠物-杀敌数加成'] = {'杀敌数加成','杀敌数加成',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前杀敌数加成 +%杀敌数加成%|cff00ff00 %|r|n|n]]},
    ['宠物-木头加成'] = {'木头加成','木头加成',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前木头加成 +%木头加成%|cff00ff00 %|r|n|n]]},
    ['宠物-物品获取率加成'] = {'物品获取率加成','物品获取率',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前物品获取率加成 +%物品获取率%|cff00ff00 %|r|n|n]]},
    ['宠物-火灵加成'] = {'火灵加成','火灵加成',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前火灵加成 +%火灵加成%|cff00ff00 %|r|n|n]]},
    ['宠物-分裂伤害加成'] = {'分裂伤害加成','分裂伤害',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前分裂伤害加成 +%分裂伤害%|cff00ff00 %|r|n|n]]},
    ['宠物-攻击速度加成'] = {'攻击速度加成','攻击速度',5,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升5%，当前攻击速度加成 +%攻击速度%|cff00ff00 %|r|n|n]]},
    ['宠物-杀怪力量成长'] = {'宠物-杀怪力量成长','杀怪加力量',20,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升20，当前杀怪加力量 +%杀怪加力量%|cff00ff00|r|n|n]]},
    ['宠物-杀怪敏捷成长'] = {'宠物-杀怪敏捷成长','杀怪加敏捷',20,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升20，当前杀怪加敏捷 +%杀怪加敏捷%|cff00ff00|r|n|n]]},
    ['宠物-杀怪智力成长'] = {'宠物-杀怪智力成长','杀怪加智力',20,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升20，当前杀怪加智力 +%杀怪加智力%|cff00ff00|r|n|n]]},
    ['宠物-杀怪全属性成长'] = {'宠物-杀怪全属性成长','杀怪加全属性',10,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升10，当前杀怪加全属性 +%杀怪加全属性%|cff00ff00|r|n|n]]},
    ['宠物-杀怪攻击成长'] = {'宠物-杀怪攻击成长','杀怪加攻击',35,[[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],[[|n|cffFFE799【使用说明】：|r|n|cff00ff00点击可升级，每级提升35，当前杀怪加攻击 +%杀怪加攻击%|cff00ff00|r|n|n]]},
}
for k,v in sortpairs(peon_skill) do 
    local mt = ac.skill[k]
    mt{
        --等级
        level = 0,
        max_level = 10,
        force_cast = 1, --强制施法
        strong_hero = 1, --作用在人身上
        --魔法书相关
        -- is_order = 1 , 显示出正常等级，cd等
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        --冷却
        cool = 0,
        not_dis = true, --不用暗图标
        content_tip = '',
        item_type_tip = '',
        --物品技能
        is_skill = true,
        --商店名词缀
        store_affix = '',
        title = v[1],
        art = v[4],
        tip = function(self)
            local hero = self.owner
            local skl = hero:find_skill('宠物天赋',nil,true)
            -- print(skl.remain_point)
            local str = '|cff00ffff可用天赋点:|r |cffffff00'..(skl and skl.remain_point or 0)..'|r\n'
            return str..v[5]
        end,
        [v[2]] = {v[3],v[3]*10},
    }   
    -- if v[2] then 
    --     mt[v[2]] = {v[3],v[3]*10}
    -- end   
    function mt:on_cast_start() 
        local hero = self.owner
        local player = hero:get_owner()
        if self.level >= self.max_level then 
            return
        end    
        
        local skl = hero:find_skill('宠物天赋',nil,true)
        local up_level = skl.level >=40 and 10 or 1 
        up_level = skl.remain_point >=10 and 10 or 1

        if skl.remain_point >= up_level  then 
            skl:set('used_point',skl.used_point + up_level) 
            skl:set('remain_point',skl.remain_point - up_level)

            -- self:upgrade(up_level)
            local t_skl = hero:find_skill(self.name,nil,true)
            if t_skl then t_skl:upgrade(up_level) end
            
        end    
    end    
end

ac.game:event'单位-获得技能' (function (_,hero,skill)
    -- if finds(skill.name,'宠物') then
    --     ac.wait(500,function ()
    --         skill:set_art(skill.art)
    --     end)
    -- end
end)




-- 1 1000
-- 2 3000
-- 3 6000
--获得升级所需要的经验
function unit.__index:peon_get_upgrade_xp(lv)
    local lv = lv or 0
    if lv >0 then 
        return self:peon_get_upgrade_xp(lv-1) + lv *1000	 
    else 
        return 0
    end        
end   

--获得经验对应的等级
function unit.__index:peon_get_lv_by_xp(xp)
    local xp = xp or 0
    local lv = 1
  
    local flag = true 
    while flag do
        flag = false  
        local total_xp = self:peon_get_upgrade_xp(lv)
        if xp < total_xp then 
            lv = lv + 1
            flag = true
        end    
    end    
	return lv 
end   

--增加经验
function unit.__index:peon_add_xp(xp)
    local player = self:get_owner()
    self.peon_xp = (self.peon_xp or 0) + xp 
    --保存经验到服务器存档
    -- player:SetServerValue('cwtf',tonumber(self.peon_xp)) 自定义服务器
    player:Map_SaveServerValue('cwtf',tonumber(self.peon_xp)) --网易服务器
    --升级
    self.peon_lv = self.peon_lv or 1
    local flag = true 
    while flag do
        flag = false  
        local need_xp = self:peon_get_upgrade_xp(self.peon_lv) - self.peon_xp
        local name = self:get_name()
        -- name = name ..'-Lv'..self.peon_lv ..'(升级所需经验：'..need_xp..')'
        -- name = '升级所需经验：'..'|cff'..ac.color_code['红']..need_xp..'|r'
        -- print(name)
        local skill = self:find_skill('宠物天赋')
        if skill then
            --更改宠物天赋的tip显示
            skill:set('need_xp',need_xp)
            skill:fresh_tip()
        end 

        --地图等级限制
        local map_level = player:Map_GetMapLevel() * 3
        if self.peon_xp >= self:peon_get_upgrade_xp(self.peon_lv) then
            if self.peon_lv <= map_level then 
                self.peon_lv = self.peon_lv + 1
                skill:upgrade(1)
                ac.game:event_notify('宠物升级',self)
                flag = true
            end    
        end 
    end
    --改变宠物的名字 不是英雄单位无法修改
    -- japi.EXSetUnitArrayString(base.string2id(self.id), 61, 0, name)

	return unit	 
end  



--宠物经验书处理
local peon_xp_item ={
    {'宠物经验书(小)',50},
    {'宠物经验书(中)',200},
    {'宠物经验书(大)',1000}
}
for i,data in ipairs(peon_xp_item) do
    --物品名称
    local mt = ac.skill[data[1]]
    mt{
    --等久
    level = 1,
    --图标
    art = [[ReplaceableTextures\CommandButtons\BTNScroll.blp]],
    --说明
    tip = [[


|cff00ffff食用后可以提升宠物|r %xp%|cffffff00点经验|r

|cffcccccc宠物升级可以获得可分配的天赋点，宠物等级可存档|r]],
    --品质
    color = '紫',
    --物品类型
    item_type = '消耗品',
    --不能被当做合成的材料，也不能被合出来 后续处理。
    -- is_not_hecheng = true,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0.1,
    --经验
    xp = data[2],
    --购买价格
    gold = 0,
    --物品数量
    _count = 1,
    --物品模型
    specail_model = [[ScrollHealing.mdx]],
    model_size = 1.3,
    titile = '|cffff0000宠物经验书|r',
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r'
    }
    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        hero = player.peon
        hero:peon_add_xp(self.xp)
    end
end

--宠物经验书掉落
-- 8%掉落
-- local rate = 8
-- ac.game:event '单位-死亡' (function (_,unit,killer)
--     -- 无尽可掉落
--     -- if ac.creep['刷怪-无尽'].index >= 1 then 
--     --     return 
--     -- end    
--     if unit and unit.data and unit.data.type =='boss' then 
--         -- print(unit)
--         local rand = math.random(1,100)
--         if rand < rate then 
--            ac.item.create_item('宠物经验书',unit:get_point())
--         end
--     end    
-- end)