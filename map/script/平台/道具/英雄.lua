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
art = [[chibang8.blp]],
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
-- ['杀怪加攻击'] = 750,
-- ['暴击几率'] = 5,
-- ['技暴几率'] = 5,
-- ['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
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
art = [[chibang8.blp]],
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
art = [[chibang8.blp]],
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
-- ['杀怪加攻击'] = 750,
-- ['暴击几率'] = 5,
-- ['技暴几率'] = 5,
-- ['全伤加深'] = 5,
--特效
effect = [[chibang7.mdx]]
}




for i,name in ipairs({'Pa','手无寸铁的小龙女','关羽'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        local target_name = name
        --连续点两下Pa取消特效
        if player.last_tran_unit and player.last_tran_unit == name then 
            target_name = hero:get_name()
        end    
        local id = ac.table.UnitData[target_name].id
        local new_model = slk.unit[id].file
        if new_model and not getextension(new_model) then 
            new_model = new_model..'.mdl'
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

