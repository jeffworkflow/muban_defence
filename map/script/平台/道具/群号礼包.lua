local mt = ac.skill['群号礼包']
mt{
--等久
level = 1,
--图标
art = [[qhlb.blp]],
is_skill =true ,
--说明
tip = [[
领取条件：输入群号%qq_qum%发送
属性：
+%award_all_attr% 全属性
+%award_kill_cnt% 杀敌数
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
qq_qum = 123,
award_all_attr = 1000,
award_kill_cnt = 50,
}

function mt:on_award()
    local hero = self.target_hero
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    --添加给英雄
    hero:add('全属性',self.award_all_attr)
    p:add_kill_count(self.award_kill_cnt)
    local tip = '|cffff0000'..p:get_name()..'|r输入群号：|cffffff00'..self.qq_qum..'|r，获得|cffffff00群号礼包|r'
    ac.player.self:sendMsg(tip)
   
end



ac.game:event '玩家-聊天' (function(self, player, str)
    local hero = player.hero
    local p = player
    --输入 群号给奖励
    if tonumber(str) == mt.qq_qum then
        if not player.is_qq_qum  then 
            mt.target_hero = hero
            mt:on_award()
            player.is_qq_qum = true
        end    
    end
end)    