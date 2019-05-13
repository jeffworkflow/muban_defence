local japi = require("jass.japi")
local dbg = require 'jass.debug'
local unit = require 'types.unit'

local hero_key = {
    ['Pa'] = 'SLPA', 
    ['亚瑟王'] = 'SLYSW', 
    ['凯撒'] = 'SLKS',
    ['卜算子'] = 'SLPSZ', 
    ['小昭君'] = 'SLXZJ', 
    ['小黑'] = 'SLXH', 
    ['山丘王'] = 'SLSQW', 
    ['影歌'] = 'SLYG', 
    ['悟空'] = 'SLWK', 
    ['扁鹊'] = 'SLBQ', 
    ['火焰领主'] = 'SLHYLZ', 
    ['牛魔王'] = 'SLNMW', 
    ['诸葛亮'] = 'SLZGL', 
    ['鲁大师'] = 'SLLDS', 
}
ac.hero_key = hero_key
local strong_attr = {
    ['肉盾'] = {
        {0,100,'格挡',0,'新手肉盾'},
        {100,300,'格挡',2,'见习肉盾'},
        {300,1000,'格挡',4,'资深肉盾'},
        {1000,2000,'格挡',6,'精英肉盾'},
        {2000,10000,'格挡',8,'宗师肉盾'},
        {10000,10000000,'格挡',10,'不灭霸者'},
    },
    ['战士'] = {
        {0,100,'生命恢复%',0,'新手战士'},
        {100,300,'生命恢复%',0.5,'见习战士'},
        {300,1000,'生命恢复%',1,'资深战士'},
        {1000,2000,'生命恢复%',1.5,'精英战士'},
        {2000,10000,'生命恢复%',2,'宗师战士'},
        {10000,10000000,'生命恢复%',2.5,'传说剑圣'},
    },
    ['杀手'] = {
        {0,100,'对BOSS额外伤害',0,'新手杀手'},
        {100,300,'对BOSS额外伤害',10,'见习杀手'},
        {300,1000,'对BOSS额外伤害',20,'资深杀手'},
        {1000,2000,'对BOSS额外伤害',30,'精英杀手'},
        {2000,10000,'对BOSS额外伤害',40,'宗师杀手'},
        {10000,10000000,'对BOSS额外伤害',50,'天诛影刃'},
    },
    ['射手'] = {
        {0,100,'攻击距离',0,'新手射手'},
        {100,300,'攻击距离',20,'见习射手'},
        {300,1000,'攻击距离',40,'资深射手'},
        {1000,2000,'攻击距离',60,'精英射手'},
        {2000,10000,'攻击距离',80,'宗师射手'},
        {10000,10000000,'攻击距离',100,'鹰眼神射'},
    },
    ['法师'] = {
        {0,100,'冷却缩减',0,'新手法师'},
        {100,300,'冷却缩减',2,'见习法师'},
        {300,1000,'冷却缩减',4,'资深法师'},
        {1000,2000,'冷却缩减',6,'精英法师'},
        {2000,10000,'冷却缩减',8,'宗师法师'},
        {10000,10000000,'冷却缩减',10,'魔道传奇'},
    },
    ['召唤师'] = {
        {0,100,'额外伤害',0,'新手召唤师'},
        {100,300,'额外伤害',1,'见习召唤师'},
        {300,1000,'额外伤害',2,'资深召唤师'},
        {1000,2000,'额外伤害',3,'精英召唤师'},
        {2000,10000,'额外伤害',4,'宗师召唤师'},
        {10000,10000000,'额外伤害',5,'孤儿的呼唤'},
    },
    ['辅助'] = {
        {0,100,'减甲',0,'新手辅助'},
        {100,300,'减甲',2,'见习辅助'},
        {300,1000,'减甲',4,'资深辅助'},
        {1000,2000,'减甲',6,'精英辅助'},
        {2000,10000,'减甲',8,'宗师辅助'},
        {10000,10000000,'减甲',10,'至贤圣者'},
    },
}
local function get_strong_attr_byxp(key,xp)
    local xp = xp or 0
    for _,v in ipairs(strong_attr[key]) do 
        if  xp >= v[1] and xp < v[2] then 
            return v
        end
    end    
end
local function get_next_strong_attr_byxp(key,xp)
    local xp = xp or 0
    for _,v in ipairs(strong_attr[key]) do 
        if  xp >= v[1] and xp < v[2] then 
            return strong_attr[key][_+1]
        end
    end    
end

ac.wait(1000,function()
    for i=1,6 do 
        local p = ac.player(i)
        if not p.hero_xp then 
            p.hero_xp = {}
        end    
        
        --取得每个玩家的英雄熟练度
        if p:is_player() then 
            for k,v in pairs(hero_key) do 
                local value = tonumber(p:Map_GetServerValue(v))
                if not value or value == '' or value == "" then
                    value = 0 
                end
                p.hero_xp[k] = value
            end   
            
        end 
    end    
    
    --游戏开始后，添加属性
    ac.game:event '游戏-开始' (function() 
        -- print('sdfsdfsdf ')
        local prod_list = {}
        for i=1,6 do 
            local p = ac.player(i)
            local hero = p.hero
            if hero then 
                local name = hero.name 
                local production = hero.data['production']
                print(name,production)
                local temp_tab = {name = hero.name,production=production, value = p.hero_xp[name] }
                if not prod_list[production]  then 
                    prod_list[production] = {}
                end
                table.insert(prod_list[production],temp_tab)    
            end    
        end  
        --取团队中，熟练度最高的职业的经验  
        local prod_max_xp = {}
        for k,v in pairs(prod_list) do
            -- print(k,v)
            prod_max_xp[k] = get_maxtable(v,'value','value')
        end   

        --增加对应团队属性 格挡等
        for k,v in pairs(prod_max_xp) do
            -- print(k,v)
            local max_tab = get_strong_attr_byxp(k,v)

            local key = max_tab[3]
            local value = max_tab[4]
            local skl = ac.skill['英雄熟练度']
            skl[key] = value

        end   

        for i=1,6 do 
            local p = ac.player(i)
            local hero = p.hero
            if hero then 
                hero:add_skill('英雄熟练度','英雄',11)
            end  
        end    
          
        
    end)

    --通关时，获得熟练度

end);

function unit.__index:add_hero_xp(xp)
    if not self:is_hero() then 
        return 
    end    
    local xp = (xp or 0) * (1 + self:get('熟练度加成'))
    local p = self:get_owner()
    local name = self.name 
    -- print(self.name,p)
    if not p.hero_xp[name] then 
        p.hero_xp[name] = 0
    end     
    p.hero_xp[name] =  p.hero_xp[name] + (xp or 0)
    -- 最高5W
    if p.hero_xp[name] >= 50000 then 
        p.hero_xp[name] = 50000
    end    
    self.current_hero_xp = (self.current_hero_xp or 0) + xp
    
    
    if ac.creep['刷怪-无尽'].index >=1 or not ac.final_boss  then 
        --保存经验到服务器存档
        p:Map_SaveServerValue(hero_key[name],tonumber(p.hero_xp[name]))
    end   
    --TAB 面板显示
    local production = self.data['production']
    local max_tab = get_strong_attr_byxp(production,p.hero_xp[name])
    p.sld = max_tab[5] 
    p.sld_value = max_tab[4]
    p.sld_key = max_tab[3]

    --下一级所需
    local next_tab = get_next_strong_attr_byxp(production,p.hero_xp[name])
    if next_tab then 
        self.next_hero_xp = next_tab[1] - p.hero_xp[name]
    end


end

local mt = ac.skill['英雄熟练度']
mt{
    --必填
    is_skill = true, 
    --初始等级
    level = 1, 
    --最大等级
    max_level = 5,
    --标题颜色
    color =  '青',
	--介绍
    tip = [[
|cffffff00熟练度：|r%p_sld% （%hero_xp%）
|cffffff00+%all_attr%|r 全属性
|cffffff00+%sld_value%|r 团队%sld_key%(不可叠加)

|cffffff00获得途径：|r
1.每次通关游戏可获得，并存档
2.挑战镜像成功
3.其它

|cffffff00本局熟练度：|r%current_hero_xp% 
|cffffff00升阶还需：|r%next_hero_xp% 
]],
-- 团队增益：
-- +%格挡% % 格挡几率
-- +%生命恢复%% % 生命恢复
-- +%减甲% 减甲
-- +%攻击距离% 攻击距离
-- +%冷却缩减% % 冷却缩减
-- +%额外伤害% % 额外伤害
-- +%对BOSS额外伤害% % 对BOSS额外伤害

-- 个人增益：
-- +%all_attr% 全属性

-- 总熟练度：%hero_xp%
-- 本局熟练度：%current_hero_xp% (击败最终boss后才生效)
-- 达下阶段还需：%next_hero_xp% 
	--技能图标
    art = [[shuliandu.blp]],

    -- --格挡几率
    ['格挡'] = 0,
    ['生命恢复%'] = 0,
    ['减甲'] = 0,
    ['攻击距离'] = 0,
    ['冷却缩减'] = 0,
    ['额外伤害'] = 0,
    ['对BOSS额外伤害'] = 0,

    all_attr = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        return string.format( "%.1f",(p.hero_xp[hero.name] or 0)/10 )
    end,

    hero_xp = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        return string.format( "%.f",(p.hero_xp[hero.name] or 0) )
    end,

    current_hero_xp = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero 
        return string.format( "%.f",(hero.current_hero_xp or 0))
    end,

    next_hero_xp = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero 
        return string.format( "%.f",(hero.next_hero_xp or 100))
    end,
    p_sld = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero 
        return p.sld
    end,
    sld_key = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero 
        return p.sld_key
    end,
    sld_value = function(self)
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero 
        return p.sld_value
    end,

    
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local value = self.all_attr
    --增加全属性
    hero:add('力量',value)
    hero:add('敏捷',value)
    hero:add('智力',value)

    --增加格挡伤害
    hero:add('格挡伤害',100)

    --增加团队收益部分
    hero:add('格挡',self['格挡'])
    hero:add('减甲',self['减甲'])
    hero:add('攻击距离',self['攻击距离'])
    hero:add('冷却缩减',self['冷却缩减'])
    hero:add('额外伤害',self['额外伤害'])
    hero:add('对BOSS额外伤害',self['对BOSS额外伤害'])

    --每秒回血
    self.trg = hero:loop(1000,function()
        local value = hero:get('生命上限')*self['生命恢复%']/100
        hero:add('生命',value)
    end)

    --加0 初始化 
    hero:add_hero_xp(0)


end
--移除会出错，不能移除
function mt:on_remove()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    local value = self.all_attr
    --增加全属性
    hero:add('力量',-value)
    hero:add('敏捷',-value)
    hero:add('智力',-value)

    --增加团队收益部分
    hero:add('格挡',-self['格挡'])
    hero:add('减甲',-self['减甲'])
    hero:add('攻击距离',-self['攻击距离'])
    hero:add('冷却缩减',-self['冷却缩减'])
    hero:add('额外伤害',-self['额外伤害'])
    hero:add('对BOSS额外伤害',-self['对BOSS额外伤害'])
    
    --增加格挡伤害
    hero:add('格挡伤害',-100)
end
