local mt = ac.skill['肝帝']
mt{
--等久
level = 0,
--图标
art = [[yjzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加88全属性，攻击加188全属性，每秒加588全属性
|cff00ffff杀敌数加成+30% 木头加成+30% 
物品获取率+30% 火灵加成+30% |r
|cffff0000攻击减甲+25 减少周围护甲1000|r

|cffffff00地图等级>=10，永久赞助的资源属性效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88,
['攻击加全属性'] = 188,
['每秒加全属性'] = 588,
}
