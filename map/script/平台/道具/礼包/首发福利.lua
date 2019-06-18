local mt = ac.skill['首发福利']
mt{
--等久
level = 0,
--图标
art = [[sffl.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加68全属性，攻击加68全属性，每秒加68全属性 
|cff00ffff杀敌数加成+25% 木头加成+25% 
物品获取率+25% 火灵加成+25% |r

|cffcccccc（首发福利，限量1000个）|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['攻击加全属性'] = 68,
['每秒加全属性'] = 68,
['杀敌数加成'] = 25,
['木头加成'] = 25,
['物品获取率'] = 25,
['火灵加成'] = 25,
}
mt.on_add = mt.on_cast_start
