
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
cnt = 1,
--全属性
award_all_attr = 1288888,
content_tip = '|cffFFE799【使用说明】：|r',
--物品技能
is_skill = true,

}

--刚开始给与一次重生机会

ac.game:event '游戏-回合开始'(function(_,index,creep)
    if not finds(creep.name,'刷怪1') then
        return 
    end
    if creep.index == 1 then 
        local unit 
        for key,val in pairs(ac.unit.all_units) do 
            if val:get_name() == '基地' then 
                -- print(val:get(str))
                unit = val
                break
            end	
        end	
        local skl = unit:find_skill('重生')
        if not skl then 
            unit:add_skill('重生','隐藏')
        else
            skl.cnt = skl.cnt + 1
        end  
        --添加基地保护buff 基地保护
        -- print(unit:get_name())
        unit:add_buff('基地保护'){
            -- time = 99999999
        }
    end    
end)  


function mt:on_cast_start()
    local unit = self.seller
    local skl = unit:find_skill('重生')
    if not skl then 
        unit:add_skill('重生','隐藏')
    else
        skl.cnt = skl.cnt + 1
    end   
    self:set('cnt',skl.cnt)

    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
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
