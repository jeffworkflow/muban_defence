--物品名称
local mt = ac.skill['完美的鸡头']
mt{
--等久
level = 1,
--图标
art = [[jitou.blp]],
--说明
tip = [[使用后加1万智力

|cffdf19d0 PS：可以给宠物，让宠物帮忙吃药|r
]],
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '使用说明：',
['智力'] = 10000
}

