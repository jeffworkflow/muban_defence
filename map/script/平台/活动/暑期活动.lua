--五一活动
--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['五一勋章']
mt{
--等久
level = 1,

--图标
art = [[item\wyxz.blp]],

--说明
tip = [[五一节活动： 5个自动合成 宠物经验书（可存档）]],

--品质
color = '紫',

--物品类型
item_type = '消耗品',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 1,

--购买价格
gold = 0,

--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '使用说明：'

}

function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

end

function mt:on_remove()
end

--获得游戏开始时间
-- print(ac.player(1):Map_GetGameStartTime())


ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_owner().id < 11 then 
        return
    end    
    --玩家12（敌对死亡才掉落） 8 0000  40 *200 8000 10*2000 20000
    local rate = 0.05
    -- local rate = 10 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        --掉落
        ac.item.create_item('宠物经验书(中)',unit:get_point())
    end    
end)

