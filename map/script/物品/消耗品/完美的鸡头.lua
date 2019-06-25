--物品名称
local mt = ac.skill['完美的鸡头']
mt{
--等久
level = 1,
--图标
art = [[jitou.blp]],
--说明
tip = [[ 
 
|cff00ff00食用可+1万智力|r
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
content_tip = '|cffffe799使用说明：|r',
['智力'] = 10000
}

