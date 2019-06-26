
local rect = require 'types.rect'

-- 杀鸡儆猴

--物品名称
local mt = ac.skill['杀鸡敬猴']
mt{
--等久
level = 1,
--图标
art = [[sjjh.blp]],
--说明
tip = [[

|cffFFE799【任务要求】|r杀死|cffff0000右边花园里|r叽叽喳喳的鸡，小心里面有一只讨厌的猴子

|cffFFE799【任务奖励】|r|cff00ff00杀怪+50金币，攻击+50金币，每秒+50金币|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,

store_affix = '',

content_tip = '',
--物品技能
is_skill = true,
--杀死鸡数
kill_cnt =100,
--每20只
per_kill_cnt = 20,
--奖励属性
award_gold = 50,
--奖励物品
award_item = '五色飞石'
}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    --发小地图的ping提示
    for i=1,3 do  
        local point = ac.map.rects['杀鸡敬猴'..i]:get_point()
        p:pingMinimap(point, 3)
    end    

end


local function task_sjjh(skill)
    local self= skill
    ac.game:event '单位-杀死单位' (function(trg, killer, target)
        if target:get_name() ~= '鸡'  then
            return
        end    
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_sjjh then return end
        
        local hero = p.hero
        if hero  then 
            p.sjjh_cnt = (p.sjjh_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.sjjh_cnt/20)

            p:sendMsg('|cffFFE799【系统消息】|r当前杀鸡进度：|cffff0000'..(p.sjjh_cnt - cnt*20)..'|r/'..self.per_kill_cnt,2)
            if p.sjjh_cnt % 20 == 0 then 
                hero:add('杀怪加金币',self.award_gold)
                hero:add('攻击加金币',self.award_gold)
                hero:add('每秒加金币',self.award_gold)
                p:sendMsg('|cffFFE799【系统消息】|r完成杀鸡任务：|cffff0000'..cnt.. '|r/5，获得|cff00ff00杀怪+50金币，攻击+50金币，每秒+50金币|r',2)
            end

            if p.sjjh_cnt == self.kill_cnt then
                --给物品
                --创建 猴
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('猴',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    local item = ac.item.create_item(self.award_item)
                    item.owner_ship = hero 
                    hero:add_item(item,true)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000齐天大圣|r已出现，小心他的金箍棒 ',2)

                --移除触发
                -- trg:remove()
                p.flag_sjjh = true

            end    
        end
    end)  

end

local skill = ac.skill['杀鸡敬猴']
task_sjjh(skill)