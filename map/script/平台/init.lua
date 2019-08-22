require '平台.base'
require '平台.config'
require '平台.自定义服务器'
-- require '平台.自定义服务器.排行榜.排行榜'
require '平台.房间显示'
require '平台.初始化'

require '平台.道具'
require '平台.宠物天赋'

require '平台.巅峰神域'
require '平台.神龙'
require '平台.替天行道'
require '平台.勇士徽章'

-- require '平台.兑换-点金石'
require '平台.地图等级'
require '平台.活动'
require '平台.碎片'
require '平台.评论数'
require '平台.武林大会'
require '平台.难度礼包'
require '平台.精彩活动'
require '平台.重置版奖励'

require '平台.赛季奖励'




-- require '平台.荣耀称号'
-- require '平台.翅膀管理'
-- require '平台.活动'
-- require '平台.英雄熟练度'
-- require '平台.皮肤碎片'

--[[流程：
1.读取开关 开继续，关停止   读取服务器1次
2.读取 每个玩家 选择难度的数据，在游戏开始时。  读取服务器最大6次。
3.读取 16个 排行榜数据。

]]