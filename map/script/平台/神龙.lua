
local mt = ac.skill['挑战耐瑟龙']
mt{
is_skill = 1,
item_type ='神符',
--等级
level = 0,
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

local mt = ac.skill['挑战冰龙']
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

local mt = ac.skill['挑战精灵龙']
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


local mt = ac.skill['挑战骨龙']
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

local mt = ac.skill['挑战奇美拉']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 奇美拉',
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


local mt = ac.skill['挑战Pa']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 pa',
--等级
level = 0,
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

local mt = ac.skill['挑战手无寸铁的小龙女']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 手无寸铁的小龙女',
--等级
level = 0,
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

local mt = ac.skill['挑战关羽']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 关羽',
--等级
level = 0,
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


local mt = ac.skill['挑战霸王莲龙锤']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 霸王莲龙锤',
--等级
level = 0,
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

local mt = ac.skill['挑战梦蝶仙翼']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '挑战 梦蝶仙翼',
--等级
level = 0,
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



--统一加方法
for i,name in ipairs({'挑战耐瑟龙','挑战冰龙','挑战精灵龙','挑战骨龙','挑战奇美拉','挑战Pa','挑战小龙女','挑战关羽','挑战霸王莲龙锤','挑战梦蝶仙翼'}) do
    local mt = ac.skill[name]
   
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
    
        --传送 玩家英雄
        hero = player.hero
        local point = ac.map.rects['练功房刷怪'..player.id]:get_point()
        hero:blink(point,true,false,true)
        -- local x,y=hero:get_point():get()
        -- player:setCamera(ac.point(x+(value[10] or 0),y+(value[11] or 0))) --设置镜头
        local minx, miny, maxx, maxy = ac.map.rects['练功房刷怪'..player.id]:get()
        player:setCameraBounds(minx, miny, maxx, maxy)  --镜头锁定

        --3秒后刷怪
        ac.wait(3*1000,function()
            local unit_name = string.gsub(self.name,'挑战','')
            local unit = ac.player(12):create_unit(unit_name,point,270)
            unit:event '单位-死亡'(function(trg,unit,killer)
                --加碎片，存档。
                local name = unit:get_name()..'碎片'
                local key = ac.server.name2key(name)
                player:AddServerValue(key,ac.g_game_degree)

                player:sendMsg('获得'..ac.g_game_degree..'个'..name)
                player:sendMsg('游戏大通关!')
                player:sendMsg('游戏大通关!')
                player:sendMsg('游戏大通关!')
            end)
        end)

    end   
end    

