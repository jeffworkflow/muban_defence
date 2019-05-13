local jass = require 'jass.common'
local mt = ac.skill['魔法书demo']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
    title = '选择翅膀',
    tip = [[
    翅膀在商城中购得，选择指定的翅膀对英雄具有辅助效果
    ]],
    
}
mt.skills = {
    '魔法书demo1','魔法书demo2','魔法书demo3',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    print('打开魔法书')
    -- for index,skill in ipairs(self.skill_book) do 
    --     local count = player.bill_item[skill:get_name()] or 0 
    --     if count > 0 then 
    --         skill:set_level(1)
    --     end
    -- end 
end 

local mt = ac.skill['魔法书demo1']
mt{

    is_order = 1,
    level = 0,
    art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
    title = '召唤师翅膀1',
    tip = [[
    提升所有防御塔%rate% %基础攻击
    ]],
    
    rate = 5 ,
    state = '基础攻击%',
    
    model = [[model\wings_green.mdx]],
    socket = 'chest',
    
}

function mt:on_cast_shot()
    local hero = self.owner 
    print('魔法书demo1 施法开始')
end 

local mt = ac.skill['魔法书demo2']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
    title = '选择光环',
    tip = [[
选择光环   选择光环
    ]],

}
mt.skills = {
    '魔法书demo3',
    '魔法书demo4',
}

function mt:on_cast_shot()
    local hero = self.owner 
    print('魔法书demo2 施法开始')
end 


local mt = ac.skill['魔法书demo3']
mt{

    is_order = 1,
    level = 1,
    art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
    title = '召唤师翅膀1',
    tip = [[
    提升所有防御塔%rate% %基础攻击
    ]],
    
    rate = 5 ,
    state = '基础攻击%',
    
    model = [[model\wings_green.mdx]],
    socket = 'chest',
}

local mt = ac.skill['魔法书demo4']
mt{

    is_order = 1,
    level = 0,
    art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
    title = '召唤师翅膀1',
    tip = [[
    提升所有防御塔%rate% %基础攻击
    ]],
    
    rate = 5 ,
    state = '基础攻击%',
    
    model = [[model\wings_green.mdx]],
    socket = 'chest',
}
