local jass = require 'jass.common'
local mt = ac.skill['皮肤碎片']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[icon/skin.blp]],
    title = '皮肤碎片',
    tip = [[
%skin%
皮肤碎片达100个，即可自动激活皮肤效果
    ]],
    skin = function(self)
        local hero = self.owner 
        local player = hero:get_owner()
        local str =''
        for key,val in pairs(player.skin) do
            str = str .. '|cff'..ac.color_code['淡黄']..key..' |r'..val..'个'..'\n'
        end   
        return str
    end,    

    
}
function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
  
end 
