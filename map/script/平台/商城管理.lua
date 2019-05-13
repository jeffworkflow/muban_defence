local jass = require 'jass.common'
local mt = ac.skill['商城管理']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sc.blp]],
    title = '商城管理',
    tip = [[
查看商城道具
    ]],
    
}
mt.skills = {
    '天空的宝藏会员','永久超级赞助','天使之光','战斗机器','魔龙之心','金币多多','寻宝小达人','双倍积分卡'
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        local count = player.mall[skill.name] 
        if count  then 
            skill:set_level(1)
        end
    end 
end 
