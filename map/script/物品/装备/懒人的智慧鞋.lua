--物品名称
local mt = ac.skill['懒人的智慧鞋']
mt{
    --物品技能
    is_skill = true,

    name = "懒人的智慧鞋",
    --类型
    item_type = "装备",
    --品质
    color = "红",
    --图标
    art = "item\\xie406.blp",
    --售价
    gold = 30000,
    tip = [[
|cffffff00点击背包内的藏宝图，开始自动寻宝
吞噬有效|r]],

}


function mt:on_add()
    local hero = self.owner
    hero.wabao_auto = true
end

function mt:on_remove()
    local hero = self.owner
    hero.wabao_auto = false
end