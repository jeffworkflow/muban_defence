
local mt = ac.skill['移动']
mt{
--目标类型 = 单位 or 点
target_type = ac.skill.TARGET_TYPE_UNIT_OR_POINT,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNMove.blp]],
--技能说明
title = '移动',
auto_fresh_tip = false,
tip = [[
命令你的部队去目标区域，在移动的过程中对于敌人的攻击他们将不予理睬。如果将该命令指向某个部队，则你的部队会跟着这个部队移动。]],
--距离
range = 99999,
--快捷键
key = 'M',

is_order = 1,
}
function mt:on_cast_start()
    local hero = self.owner 
    local target = self.target 
    if target then 
        hero:issue_order('move',target)
    end     
end 


local mt = ac.skill['停止']
mt{
--目标类型 = 无目标
target_type = ac.skill.TARGET_TYPE_NONE,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNStop.blp]],
--技能说明
title = '停止',
auto_fresh_tip = false,
tip = [[

无论你的单位先前得到什么命令，都可以让他们停下来。不过他们随后也会对进入射程的敌人进行攻击或者追捕

]],
--快捷键
key = 'S',
is_order = 1,
}

function mt:on_cast_start()
    local hero = self.owner 
    hero:issue_order('stop')
end 

local mt = ac.skill['保持原位']
mt{
--目标类型 = 无目标
target_type = ac.skill.TARGET_TYPE_NONE,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNHoldPosition.blp]],
--技能说明
title = '保持原位',
auto_fresh_tip = false,
tip = [[让你的部队位于原地不动，他们能对进入射程范围内的敌人进行攻击。被施放了该命令后，你的单位不会去追捕敌人的单位也不会去进攻敌人的远程攻击单位。]],
--快捷键
key = 'H',
is_order = 1
}

function mt:on_cast_start()
    local hero = self.owner 
    hero:issue_order('stop')

end 

local mt = ac.skill['攻击']
mt{
--目标类型 = 单位 or 点
target_type = ac.skill.TARGET_TYPE_UNIT_OR_POINT,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNAttack.blp]],
--技能说明
title = '攻击',
auto_fresh_tip = false,
tip = [[

命令你的部队去目标区域，在移动的过程中对于敌人的攻击他们将不予理睬。如果将该命令指向某个部队，则你的部队会跟着这个部队移动

]],
--距离
range = 99999,
--快捷键
key = 'A',
--目标允许	
target_data = '联盟 玩家单位 敌人',
is_order = 1
}
function mt:on_cast_start()
    local hero = self.owner 
    local target = self.target 
    if target then 
        hero:issue_order('attack',target)
    end     
end 


