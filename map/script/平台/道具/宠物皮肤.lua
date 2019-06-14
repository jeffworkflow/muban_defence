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
tip = [[超过XX碎片自动激活，已拥有XX
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['每秒加木头'] = 500,
['生命上限'] = 1000,
['护甲'] = 1000,
['每秒回血'] = 2.5,
--特效
effect = [[chibang2.mdx]]
}

local mt = ac.skill['冰龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[chibang4.blp]],
--说明
tip = [[地图等级40
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['杀怪加全属性'] = 100,
['生命上限'] = 2000,
['护甲'] = 1000,
--特效
effect = [[Hero_DoomBringer_N3.mdx]]
}

local mt = ac.skill['精灵龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[chibang3.blp]],
--说明
tip = [[最强王者50星
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['杀怪加攻击'] = 450,
['吸血'] = 10,
['攻击间隔'] = -0.05,
--特效
effect = [[chibang3.mdx]]
}


local mt = ac.skill['骨龙']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[chibang8.blp]],
--说明
tip = [[商城188
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['杀怪加攻击'] = 600,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[chibang8.mdx]]
}

local mt = ac.skill['奇美拉']
mt{
    is_skill = 1,
    item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[chibang7.blp]],
--说明
tip = [[商城218
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
}

local mt = ac.skill['小悟空']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[chibang7.blp]],
--说明
tip = [[商城218
激活地图等级：%need_map_level%
已拥有碎片：%skin_cnt%
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
['杀怪加攻击'] = 750,
['暴击几率'] = 5,
['技暴几率'] = 5,
['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]],
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
    end    

    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        --改模型
        if self.level > 0 then 
            japi.SetUnitModel(hero.handle,self.effect)
        end    
        
    end   
end    

local mt = ac.skill['宠物皮肤']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cwpf.blp]],
    title = '查看宠物皮肤',
    tip = [[
查看宠物皮肤
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
        --商城 或是 自定义服务器有对应数据则
        --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
        local has_item = player.cus_server and (player.cus_server[skill.name] or 0 )
        local sp_cnt = player.cus_server and (player.cus_server[skill.name..'碎片'] or 0 )
        -- print(has_item,sp_cnt,skill.need_sp_cnt)
        if has_item and has_item == 0 
           and sp_cnt >= skill.need_sp_cnt  
           and player:Map_GetMapLevel() >= skill.need_map_level  
        then 
            local key = ac.server.name2key(skill.name)
            player:SetServerValue(key,1)
            -- player:sendMsg('激活成功：'..skill.name)
        end    

        local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
        if has_mall and has_mall > 0 then 
            skill:set_level(1)
        end
    end 
end  


