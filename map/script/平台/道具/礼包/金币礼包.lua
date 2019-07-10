local mt = ac.skill['金币礼包']
mt{
--等久
level = 0,
--图标
art = [[jblb.blp]],
is_order = 1,
is_skill =true ,
content_tip = '',
--说明
tip = [[

|cffFFE799【领取条件】|r商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加500金币，杀怪+500金币，攻击+500金币
开局赠送一本随机技能书，发放英雄背包|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--每秒金币
per_gold = 500,
--杀怪加金币
kill_gold = 500,
--攻击加金币
attack_gold = 500,
}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    if p.mall[name] and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('每秒加金币',self.per_gold)
        hero:add('杀怪加金币',self.kill_gold)
        hero:add('攻击加金币',self.attack_gold)
        hero:add_item('随机技能书',true)
        p.mall_flag[name] = true
        
        local tip = '|cffFFE799【系统消息】|r恭喜 |cff00ffff'..p:get_name()..'|r 获得|cffff0000金币礼包|r |cffFFE799【礼包奖励】|r|cff00ff00每秒加500金币，杀怪+500金币，攻击+500金币|r'
        p:sendMsg(tip,3)
    else
        p:sendMsg('条件不足或已领取过',2)    
    end    
end
mt.on_add = mt.on_cast_start