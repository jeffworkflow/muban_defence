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
|cffFFE799黄金3星|r 奖励 |cff00ff00【称号】毁天灭地
|cffFFE799铂金3星|r 奖励 |cff00ff00【英雄】Pa
|cffFFE799钻石5星|r 奖励 |cff00ffff【称号】风驰电掣
|cffFFE799星耀5星|r 奖励 |cff00ffff【英雄】小龙女
|cffFFE799星耀10星|r 奖励 |cffFFff00【神器】幻海雪饮剑
|cffFFE799王者5星|r 奖励 |cff00ffff【称号】无双魅影
|cffFFE799王者10星|r 奖励 |cffFFff00【翅膀】天罡苍羽翼
|cffFFE799最强王者15星|r 奖励 |cff00ffff【英雄】关羽
|cffFFE799荣耀王者15星|r 奖励 |cffFFff00【神器】紫色哀伤
|cffFFE799巅峰王者15星|r 奖励 |cffFF0000【翅膀】白龙凝酥翼
|cffFFE799修罗模式25星|r 奖励 |cffFF0000【神器】霜之哀伤
|cffFFE799斗破苍穹25星|r 奖励 |cffFF0000【领域】烈火金焰
|cffFFE799无上之境25星|r 奖励 |cffFF0000【翅膀】龙吟双形翼
|cffFFE799无限乱斗25星|r 奖励 |cffFF0000【神器】灭神紫霄剑
 ]],
}

local mt = ac.skill['无尽挑战说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
游戏中有四个难度（无限乱斗\无上之境\斗破苍穹\修罗模式)，通关后会进入“无尽挑战”

|cffFFE799修罗模式|cffff0000累计|cffFFE799无尽波数=150波|r 奖励 |cff00ff00【翅膀】天使之光
|cffFFE799修罗模式|cffff0000累计|cffFFE799无尽波数=500波|r 奖励 |cff00ff00【领域】白云四海领域
|cffFFE799斗破苍穹|cffff0000累计|cffFFE799无尽波数=150波|r 奖励 |cff00ffff【领域】烈火天翔领域
|cffFFE799斗破苍穹|cffff0000累计|cffFFE799无尽波数=500波|r 奖励 |cff00ffff【神器】方天画戟
|cffFFE799无上之境|cffff0000累计|cffFFE799无尽波数=150波|r 奖励 |cffffff00【神器】圣神无双剑
|cffFFE799无上之境|cffff0000累计|cffFFE799无尽波数=500波|r 奖励 |cffffff00【翅膀】金鳞双型翼
|cffFFE799无限乱斗|cffff0000累计|cffFFE799无尽波数=300波|r 奖励 |cffff0000【翅膀】赤魔双形翼
|cffFFE799无限乱斗|cffff0000累计|cffFFE799无尽波数=800波|r 奖励 |cffff0000【领域】真武青焰领域
 ]],
}

-- 青铜1星 奖励 【称号】炉火纯青（价值15元）
-- 白银3星 奖励 【英雄】赵子龙（价值25元）
-- 黄金3星 奖励 【称号】毁天灭地（价值35元）
-- 铂金3星 奖励 【英雄】Pa（价值45元）
-- 钻石5星 奖励 【称号】风驰电掣（价值55元）
-- 星耀5星 奖励 【英雄】小龙女（价值65元）
-- 星耀10星 奖励 【神器】幻海雪饮剑（价值120元）
-- 王者5星 奖励 【称号】无双魅影（价值100元）
-- 王者10星 奖励 【翅膀】天罡苍羽翼（价值150元）
-- 最强王者15星 奖励 【英雄】关羽（价值200元）
-- 荣耀王者15星 奖励 【神器】紫色哀伤（价值200元）
-- 巅峰王者15星 奖励 【翅膀】白龙凝酥翼（价值200元）
-- 修罗模式25星 奖励 【神器】霜之哀伤（价值200元）
-- 斗破苍穹25星 奖励 【领域】烈火金焰（价值200元）
-- 无上之境25星 奖励 【翅膀】龙吟双形翼（价值200元）

local mt = ac.skill['地图等级说明1']
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
|cffffE79910级|r 奖励 |cff00ff00【英雄】虞姬（价值55元）
|cffffE79913级|r 奖励 |cff00ff00【领域】龙腾领域（价值55元）
|cffffE79915级|r 奖励 |cff00ffff【英雄】太极熊猫（价值88元）
|cffffE79916级|r 奖励 |cffdf19d0【商城道具】神仙水（价值28元）
（如果已购买，属性可叠加）
|cffffE79917级|r 奖励 |cff00ffff【领域】飞沙热浪领域（价值75元）
|cffffE79920级|r 奖励 |cff00ffff【神器】惊虹奔雷剑（价值108元）
|cffffE79922级|r 奖励 |cffffff00【领域】灵霄烟涛领域（价值98元）
|cffffE79925级|r 奖励 |cffffff00【英雄】狄仁杰（价值128元）
|cffffE79926级|r 奖励 |cffffff00【神器】飞星雷火剑（价值138元）
|cffffE79928级|r 奖励 |cffffff00【翅膀】白羽金虹翼（价值168元）
|cffffE79930级|r 奖励 |cffff0000【翅膀】玄羽绣云翼（价值100元）
|cffffE79932级|r 奖励 |cffff0000【英雄】伊利丹（价值198元）
|cffffE79935级|r 奖励 |cffff0000【英雄】关公（价值298元）
|cffffE79937级|r 奖励 |cffff0000【领域】赤霞万象领域（价值245元）
|cffffE79938级|r 奖励 |cffdf19d0【商城道具】孤风青龙领域|cff00ffff（价值228元，
仅基础属性有效，无外观、羁绊效果，如果已购买，属性可叠加）
|cffffE79940级|r 奖励 |cffdf19d0【商城道具】永久超级赞助|cff00ffff（价值288元）
（如果已购买，属性可叠加）
|cffffE79945级|r 奖励 |cffdf19d0【商城道具】远影苍龙领域|cff00ffff（价值388元，
仅基础属性有效，无外观、羁绊效果，如果已购买，属性可叠加）
|cffffE79950级|r 奖励 |cffdf19d0【商城道具】真龙天子|cff00ffff（价值468元，
仅基础属性有效，无技能、外观、羁绊效果，如果已购买，属性可叠加）
|cffffE79955级|r 奖励 |cffdf19d0【商城道具】齐天大圣（新版）|cff00ffff（价值468元，
仅基础属性有效，无技能、外观、羁绊效果，如果已购买，属性可叠加）
 ]],
}

local mt = ac.skill['地图等级说明2']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00地图等级直接奖励额外属性|r

|cffffE7992级|r 奖励 |cff00ff00攻击加全属性+20，杀怪加金币+50
（通关青铜翻倍）
|cffffE7993级|r 奖励 |cff00ff00每秒加护甲0.5，每秒加全属性+250
（通关青铜翻倍）
|cffffE7994级|r 奖励 |cff00ff00金币加成+25% ，杀敌数加成+10%
（通关白银翻倍）
|cffffE7995级|r 奖励 |cff00ffff木头加成+7.5% ，火灵加成+7.5%
（通关白银翻倍）
|cffffE7996级|r 奖励 |cff00ffff减少周围护甲+100（通关黄金翻倍）
|cffffE7997级|r 奖励 |cffdf19d0首充大礼包的资源属性翻倍
(条件：已购买首充大礼包)    
|cffffE7998级|r 奖励 |cffffff00杀敌加全属性+50（通关黄金翻倍）
|cffffE7999级|r 奖励 |cffffff00攻击减甲+15（通关铂金翻倍）
|cffffE79910级|r 奖励 |cffffff00暴击加深+50%（通关铂金翻倍）
|cffffE79910级|r 奖励 |cffdf19d0永久赞助的资源属性翻倍
(条件：已购买永久赞助)
|cffffE79911级|r 奖励 |cffff0000技暴加深+50%（通关钻石翻倍）
|cffffE79912级|r 奖励 |cffff0000全伤加深+5%（通关钻石翻倍）
 ]],
}

local mt = ac.skill['地图等级说明3']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[

|cffffe799持续更新中]],
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
|cffffE799积分超过45000|r 奖励 |cffff0000【宠物皮肤】魅影（价值145元）
|cffffE799积分超过70000|r 奖励 |cffff0000【宠物皮肤】紫霜幽幻龙鹰（价值188元）
|cffffE799积分超过100000|r 奖励 |cffff0000【宠物皮肤】天马行空（价值288元）
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
|cffffE79915枚徽章|r 兑换 |cffffff00【称号】势不可挡（价值15元）
|cffffE79975枚徽章|r 兑换 |cffffff00【称号】君临天下（价值60元）
|cffffE799200枚徽章|r 兑换 |cffff0000【称号】神帝（价值125元）
|cffffE799350枚徽章|r 兑换 |cffff0000【称号】傲世天下（价值268元）
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

|cffffE79910个耐瑟龙碎片|r 激活 |cff00ff00【宠物皮肤】耐瑟龙（价值10元）
|cffffE79930个Pa碎片|r 激活 |cff00ff00【英雄】Pa（价值45元）
|cffffE79950个冰龙碎片|r 激活 |cff00ff00【宠物皮肤】冰龙（价值38元）
|cffffE79975个小龙女碎片|r 激活 |cff00ffff【英雄】手无寸铁的小龙女(价值65元)
|cffffE799150个莲龙锤碎片|r 激活 |cff00ffff【神器】霸王莲龙锤（价值68元）
|cffffE799200个梦蝶仙翼碎片|r 激活 |cff00ffff【翅膀】梦蝶仙翼（价值88元）
|cffffE799250个关羽碎片|r 激活 |cffffff00【英雄】关羽（价值100元）
|cffffE799250个精灵龙碎片|r 激活 |cffffff00【宠物皮肤】精灵龙（价值88元）
|cffffE799350个奇美拉碎片|r 激活 |cffffff00【宠物皮肤】奇美拉（价值128元）
|cffffE799400个魅影碎片|r 激活 |cffff0000【宠物皮肤】魅影（价值148元）
|cffffE799500个紫霜幽幻龙鹰碎片|r 激活 |cffff0000【宠物皮肤】紫霜幽幻龙鹰（价值188元）
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

local mt = ac.skill['其它可存档内容说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[

|cffffE799【杀鸡儆猴】|r 奖励 
|cffff0000【杀怪加全属性】|cff00ffff+1*杀猴次数

|cffffE799【神奇的五分钟】|r 奖励 
|cffff0000【攻击减甲】|cff00ffff+1*游戏时间超过5分钟的局数

|cffffE799【评论礼包】|r 奖励 
|cffff0000【减少周围护甲】|cff00ffff+1.5*地图等级*评论次数
|cffff0000【攻击加全属性】|cff00ffff+1*地图等级*评论次数

|cffffE799【难度礼包】|r 奖励 
|cffff0000【每秒加护甲】|cff00ffff+0.1*地图等级*游戏难度
 ]],
}

local mt = ac.skill['比武积分说明']
mt{
    --类型
    item_type = "神符",
    art = [[xsgl.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    store_affix ='',
    tip = [[ 
|cff00ff00开局选择“武林大会”模式，局内和玩家PK可获得|r 

|cffffE799比武积分超过250|r 奖励 |cff00ff00【成就】江湖小虾（价值28元）
|cffffE799比武积分超过500|r 奖励 |cff00ffff【成就】明日之星（价值58元）
|cffffE799比武积分超过1000|r 奖励 |cffffff00【成就】武林高手（价值88元）
|cffffE799比武积分超过1500|r 奖励 |cffff0000【成就】绝世奇才（价值128元）
|cffffE799比武积分超过2000|r 奖励 |cffff0000【成就】威震三界（价值158元）
 ]],
}

