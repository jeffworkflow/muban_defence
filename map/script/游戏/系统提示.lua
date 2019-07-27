local jass = require("jass.common")
local tips = {
    '|cff00ffff【地图指令】',
    '|cff00ffff输入 ++/--，可调镜头高度',
    '|cff00ffff输入 qx，可取消身上翅膀、领域、称号、武器特效',
    '|cff00ffff输入 -close 1/0，可开启/关闭技能特效和伤害文字显示|cffffff00（可解决后期地图报错问题）',
    '|cff00ffff输入 qlwp，可删除除练功房外的所有物品|cffffff00（可解决后期地图报错问题）',
}
local time = 5 * 60

ac.loop( time * 1000,function ()
    local rand = math.random(#tips)
    local tip = table.concat( tips, "\n")
    jass.ClearTextMessages();
    ac.player.self:sendMsg(tip,10)
end)