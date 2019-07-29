--物品名称
local mt = ac.skill['游戏难度说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
游戏分十个难度，通关会获得一个对应难度的星数

|cffffE799青铜1星|r 奖励 |cff00ff00【称号】炉火纯青
|cffFFE799白银3星|r 奖励 |cff00ff00【英雄】赵子龙
|cffFFE799黄金5星|r 奖励 |cff00ffff【称号】毁天灭地
|cffFFE799铂金7星|r 奖励 |cff00ffff【英雄】Pa
|cffFFE799钻石10星|r 奖励 |cffffff00【称号】风驰电掣
|cffFFE799星耀10星|r 奖励 |cffFFff00【英雄】手无寸铁的小龙女
|cffFFE799王者15星|r 奖励 |cffFFff00【称号】无双魅影
|cffFFE799最强王者15星|r 奖励 |cffFF0000【英雄】关羽
|cffFFE799最强王者20星|r 奖励 |cffFF0000【神器】幻海雪饮剑
|cffFFE799最强王者25星|r 奖励 |cffFF0000【神器】天罡苍羽翼
|cffFFE799荣耀王者25星|r 奖励 |cffFF0000【神器】紫色哀伤
|cffFFE799巅峰王者25星|r 奖励 |cffFF0000【神器】白龙凝酥翼
|cffFFE799修罗模式25星|r 奖励 |cffFF0000【神器】霜之哀伤
 ]],
}

local mt = ac.skill['地图等级说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00地图等级可解锁肝的内容|r

|cffffE7993级+五星好评|r 奖励 |cff00ff00【礼包】五星好评礼包（价值15元）
|cffffE7995级|r 奖励 |cff00ff00【英雄】夏侯霸（价值25元）
|cffffE79910级|r 奖励 |cff00ffff【英雄】虞姬（价值55元）
|cffffE79915级|r 奖励 |cffffff00【英雄】太极熊猫（价值88元）
|cffffE79920级|r 奖励 |cffff0000【神器】惊虹奔雷剑（价值108元）
|cffffE79925级|r 奖励 |cffff0000【英雄】狄仁杰（价值128元）
|cffffE79930级|r 奖励 |cffff0000【翅膀】玄羽绣云翼（价值100元）
|cffffE79935级|r 奖励 |cffff0000【英雄】伊利丹（价值198元）
 ]],
}

local mt = ac.skill['地图等级福利']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00等级Lv2 攻击加全属性+20，杀怪加金币+50
（通关青铜翻倍）
等级Lv3 每秒加护甲0.5，每秒加全属性+250
（通关青铜翻倍）
等级Lv4 金币加成+25% ，杀敌数加成+10%
（通关白银翻倍）
|cff00ffff等级Lv5 木头加成+7.5% ，火灵加成+7.5%
（通关白银翻倍）
等级Lv6 减少周围护甲+100（通关黄金翻倍）
|cffdf19d0等级Lv7 首充大礼包的资源属性翻倍
(条件：已购买首充大礼包)    
|cffffff00等级Lv8 杀敌加全属性+50（通关黄金翻倍）
等级Lv9 攻击减甲+15（通关铂金翻倍）
等级Lv10 暴击加深+50%（通关铂金翻倍）
|cffdf19d0等级Lv10 永久赞助的资源属性翻倍
(条件：已购买永久赞助)
|cffffff00等级Lv11 技暴加深+50%（通关钻石翻倍）
等级Lv12 全伤加深+5%（通关钻石翻倍）
|cffff0000等级Lv14 龙腾领域（价值55元）
等级Lv17 飞沙热浪领域（价值75元）
等级Lv22 灵霄烟涛领域（价值98元）

|cffffe799持续更新中
 ]],
}
local mt = ac.skill['挖宝积分说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
找新手任务NPC，传送打怪获得藏宝图，|cff00ff00使用藏宝图可以获得大量挖宝积分|r|cffcccccc（搭配商城道具:寻宝小达人效果更佳）|r

|cffffE799每点积分|r 奖励 |cff00ff00200全属性(属性永久存档 上限受地图等级影响)
|cffffE799积分超过2000|r 奖励 |cff00ff00【称号】势不可挡（价值15元）
|cffffE799积分超过5000|r 奖励 |cff00ffff【领域】血雾领域（价值25元）
|cffffE799积分超过10000|r 奖励 |cff00ffff【宠物皮肤】冰龙（价值38元）
|cffffE799积分超过20000|r 奖励 |cffffff00【神器】霸王莲龙锤（价值68元）
|cffffE799积分超过30000|r 奖励 |cffff0000【翅膀】梦蝶仙翼（价值88元）
 ]],
}

local mt = ac.skill['勇士徽章说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00通过替天行道任务获得，每局最多可获得5个徽章，可兑换存档内容：|r 

|cffffE7991枚徽章|r 兑换 |cff00ff00【开局属性】3万全属性
|cffffE7991枚徽章|r 兑换 |cff00ff00【开局属性】6万力量
|cffffE7991枚徽章|r 兑换 |cff00ffff【开局属性】6万敏捷
|cffffE7991枚徽章|r 兑换 |cff00ffff【开局属性】6万智力
|cffffE79920枚徽章|r 兑换 |cffffff00【称号】势不可挡（价值15元）
|cffffE799100枚徽章|r 兑换 |cffffff00【称号】君临天下（价值60元）
|cffffE799250枚徽章|r 兑换 |cffff0000【称号】神帝（价值125元）
|cffffE799500枚徽章|r 兑换 |cffff0000【称号】傲世天下（价值268元）
 ]],
}

local mt = ac.skill['神龙碎片说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00打死最终boss后可挑战，挑战胜利获得|r 

|cffffE79915个耐瑟龙碎片|r 激活 |cff00ff00【宠物皮肤】耐瑟龙（价值10元）
|cffffE79950个Pa碎片|r 激活 |cff00ff00【英雄】Pa（价值45元）
|cffffE79975个冰龙碎片|r 激活 |cff00ffff【宠物皮肤】冰龙（价值38元）
|cffffE799100个小龙女碎片|r 激活 |cff00ffff【英雄】手无寸铁的小龙女(价值65元)
|cffffE799200个莲龙锤碎片|r 激活 |cffffff00【神器】霸王莲龙锤（价值68元）
|cffffE799250个梦蝶仙翼碎片|r 激活 |cffffff00【翅膀】梦蝶仙翼（价值88元）
|cffffE799300个关羽碎片|r 激活 |cffff0000【英雄】关羽（价值100元）
|cffffE799300个精灵龙碎片|r 激活 |cffff0000【宠物皮肤】精灵龙（价值88元）
|cffffE799400个奇美拉碎片|r 激活 |cffff0000【宠物皮肤】奇美拉（价值128元）
 ]],
}

local mt = ac.skill['宠物天赋说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00宠物等级可存档，升级时获得一点宠物天赋，宠物天赋可学习技能，每局都会重置宠物天赋，记得开局点一下|r 

|cffffE7991点宠物天赋|r 奖励 |cff00ff00【杀敌数加成5%】
|cffffE7991点宠物天赋|r 奖励 |cff00ff00【木头加成5%】
|cffffE7991点宠物天赋|r 奖励 |cff00ff00【物品获取率加成5%】
|cffffE7991点宠物天赋|r 奖励 |cff00ffff【火灵加成5%】
|cffffE7991点宠物天赋|r 奖励 |cff00ffff【分裂伤害加成5%】
|cffffE7991点宠物天赋|r 奖励 |cff00ffff【攻击速度加成5%】
|cffffE7991点宠物天赋|r 奖励 |cffffff00【杀怪20力量成长】
|cffffE7991点宠物天赋|r 奖励 |cffffff00【杀怪20敏捷成长】
|cffffE7991点宠物天赋|r 奖励 |cffffff00【杀怪20智力成长】
|cffffE7991点宠物天赋|r 奖励 |cffff0000【杀怪10全属性成长】
|cffffE7991点宠物天赋|r 奖励 |cffff0000【杀怪35攻击成长】
 ]],
}

local mt = ac.skill['评论礼包说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00平台进行评论即可获得，评论礼包属性可存档|r 

|cffffE7991个评论次数|r 奖励 |cffff0000【减少周围护甲】|cff00ffff+1.5*地图等级*评论次数
 ]],
}

