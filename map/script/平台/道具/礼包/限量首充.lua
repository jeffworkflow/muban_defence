local mt = ac.skill['限量首充']
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
|cff00ff00杀怪加38全属性，攻击加68全属性，每秒加108全属性 
|cff00ffff杀敌数加成+15% 木头加成+15% 
物品获取率+15% 火灵加成+15% |r
|cffff0000对BOSS额外伤害+5%|r
|cffcccccc（限量首充，限量1000个）|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 38,
['攻击加全属性'] = 68,
['每秒加全属性'] = 108,
['杀敌数加成'] = 15,
['木头加成'] = 15,
['物品获取率'] = 15,
['火灵加成'] = 15,
['对BOSS额外伤害'] = 5,
}
