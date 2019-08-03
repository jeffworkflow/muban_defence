
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['基地重生']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNImbuedMasonry.blp]],

--说明
tip = [[
 

让基地获得|cff00ff00一次重生的机会|r
当前可重生次数：%cnt%
]],

--物品类型
item_type = '神符',
--售价 500000
wood = 50000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
cnt = function(self)
    local unit 
    for key,val in pairs(ac.shop.unit_list) do 
        if val:get_name() == '基地' then 
            -- print(val:get(str))
            unit = val
            break
        end	
    end	
    local skl = unit and unit:find_skill('重生')
    return  skl and skl.cnt  or 0
end    ,
--全属性
award_all_attr = 1288888,
content_tip = '|cffFFE799【使用说明】：|r',
--物品技能
is_skill = true,

}

--刚开始给与一次重生机会

-- function mt:on_shop_add()
--     local unit = self.owner
--     print(unit:get_name())
--     local skl = unit:find_skill('重生')
--     if not skl then 
--         skl = unit:add_skill('重生','隐藏')
--     else
--         skl.cnt = skl.cnt + 1
--     end   
--     local shop_item = ac.item.shop_item_map[self.name]
--     shop_item:set('cnt',skl.cnt)
--     shop_item:set_tip(shop_item:get_tip())

-- end    
ac.game:event '单位-创建'(function(_,unit)
    if unit:get_name() ~= '基地' then 
        return 
    end    
    local skl = unit:find_skill('重生')
    if not skl then 
        skl = unit:add_skill('重生','隐藏')
    else
        skl.cnt = skl.cnt + 1
    end  
    ac.main_unit = unit
    --添加基地保护buff 基地保护
    -- print(unit:get_name())
    -- unit:add_buff('基地保护'){
    --     -- time = 99999999
    -- } 
end)  
local max_cnt = 100
function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()

    hero = player.hero
    max_cnt = max_cnt - 1
    if max_cnt <= 0 then 
        player:sendMsg('|cff00ff00购买次数已达上限|r',5)
        return true
    end    

    local unit = self.seller
    local skl = unit:find_skill('重生')
    if not skl then 
        skl = unit:add_skill('重生','隐藏')
    else
        skl.cnt = skl.cnt + 1
    end   

    hero:add('全属性',self.award_all_attr)
    player:sendMsg('|cffFFE799【系统消息】|r|cff00ffff'..player:get_name()..'|r 购买了基地重生 奖励|cff00ff001288888全属性|r',2)
    
    --概率得 五道杠少年
    local rate = 10
    -- local rate = 80 --测试用
    if math.random(1,10000)/100 < rate then 
        local skl = hero:find_skill('五道杠少年',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','五道杠少年')
            player.is_show_nickname = '五道杠少年'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 保家爱国 精神可嘉 |r 获得成就|cffff0000 "五道杠青年" |r，奖励 |cffff0000+500w全属性 +25%木头加成|r',6)
            -- ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000吸血+10%，攻击回血+50W|r',6)
        end
    end    
end
