local jass = require("jass.common")
local tips = {
    '|cffffe799【地图指令】',
    '|cff00ff00输入 ++/--，可调镜头高度',
    '|cff00ff00输入 qx，可取消身上翅膀、领域、称号、武器特效',
    '|cff00ffff输入 tx，可开启/关闭技能特效和伤害文字显示|cffff0000（可解决后期地图报错问题）',
    '|cff00ffff输入 qlwp，可删除除练功房外的所有物品|cffff0000（可解决后期地图报错问题）',
    '|cff00ffff输入 nd，可取消扭蛋文字提醒|cffff0000（可解决后期地图报错问题）',
}
local time = 10 * 60

ac.loop( time * 1000,function ()
    local rand = math.random(#tips)
    local tip = table.concat( tips, "\n")
    jass.ClearTextMessages();
    ac.player.self:sendMsg(tip,10)
end)