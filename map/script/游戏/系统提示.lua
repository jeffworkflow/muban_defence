local jass = require("jass.common")
local tips = {
    '【系统提示】每层都有一朵|cffff0000命运花|r，拾取可以获得神秘效果',
    '【系统提示】|cffff0000海贼王的套装|r，可以让你获得更多资源，冲刺更高层',
    '【系统提示】宠物可以帮英雄进行|cffff0000学习技能、使用药水|r等骚操作',
    '【系统提示】|cffff0000物理暴击或法术暴击，可以与会心暴击相叠加|r',
    '【系统提示】|cffff0000通关游戏进入无尽模式|r，可以获得通关积分，积分可以兑换海量道具',
}
local time = 5 * 60
local time = 10
ac.loop( time * 1000,function ()
    local rand = math.random(#tips)
    local tip = table.concat( tips, "\n")
    jass.ClearTextMessages();
    ac.player.self:sendMsg(tip,30)
end)