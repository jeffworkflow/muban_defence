
local rect = require 'types.rect'

-- 杀鸡儆猴

--物品名称
local mt = ac.skill['杀鸡儆猴']
mt{
--等久
level = 1,
--图标
art = [[sjjh.blp]],
--说明
tip = [[

|cffFFE799【任务要求】|r杀死|cffff0000右边花园里|r叽叽喳喳的鸡，小心里面有一只讨厌的猴子
|cff00ffff（击杀可获|cffff0000 杀怪全属性+1永久存档奖励 |cff00ffff上限受地图等级影响）

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
        local point = ac.map.rects['杀鸡儆猴'..i]:get_point()
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
                    local player = hero:get_owner()
                    item.owner_ship = hero 
                    hero:add_item(item,true)
                    --保存到服务器存档
                    hero:add('杀怪加全属性',1)
                    -- player:AddServerValue('sjjh',1) 自定义服务器
                    player:Map_AddServerValue('sjjh',1) --
                    player:sendMsg('|cffFFE799【系统消息】|r恭喜获得 |cff00ff00杀怪加全属性+1|r 的|cffff0000永久存档奖励|r |cffffe799当前杀怪加全属性+|cffffe799'..((player.cus_server and player.cus_server['杀鸡儆猴']) or 0)..'|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000齐天大圣|r已出现，小心他的金箍棒 ',2)
                p.flag_sjjh = true

            end    
        end
    end)  

end

local skill = ac.skill['杀鸡儆猴']
task_sjjh(skill)





--任务系统
local task_detail = {
    ['吞噬极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_tsjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.tsjx_cnt = (p.tsjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.tsjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.tsjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.tsjx_cnt % per_kill_cnt == 0 then 
                hero:add_item('点金石',true)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000点金石+1|r',2)
            end

            if p.tsjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('吞噬极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add_item('吞噬丹',true)
                    p.max_tunshi_cnt = (p.max_tunshi_cnt or 8) + 1  --最大吞噬次数为9次，之前8次。
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000吞噬丹+1 物品吞噬极限+1|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_tsjx = true
            end
        end    

    end, 
    ['强化极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_qhjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.qhjx_cnt = (p.qhjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.qhjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.qhjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.qhjx_cnt % per_kill_cnt == 0 then 
                --奖励随机技能书
                local skl_name = ac.skill_list2[math.random(#ac.skill_list2)]
                hero:add_skill_item(skl_name)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000随机技能书|r',2)
            end

            if p.qhjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('强化极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add_item('恶魔果实',true)
                    p.max_ruti_cnt = (p.max_ruti_cnt or 8) + 1 
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000恶魔果实+1 技能强化极限+1|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_qhjx = true
            end
        end    

    end,   
    ['暴击极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_bjjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.bjjx_cnt = (p.bjjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.bjjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.bjjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.bjjx_cnt % per_kill_cnt == 0 then 
                hero:add('暴击加深',50)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000暴击加深+50%|r',2)
            end

            if p.bjjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('暴击极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('暴击几率',5)
                    hero:add('暴击几率极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000暴击几率+5%（无视暴击几率上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_bjjx = true
            end
        end    

    end,       
    ['免伤几率极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_msjl then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.msjl_cnt = (p.msjl_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.msjl_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.msjl_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.msjl_cnt % per_kill_cnt == 0 then 
                hero:add('生命上限%',5)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000生命上限+5%|r',2)
            end

            if p.msjl_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('免伤几率极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('免伤几率',5)
                    hero:add('免伤几率极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000免伤几率+5%（无视免伤几率上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_msjl = true
            end
        end    
    end,         
    ['技暴极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_jbjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.jbjx_cnt = (p.jbjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.jbjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.jbjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.jbjx_cnt % per_kill_cnt == 0 then 
                hero:add('技暴加深',50)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000技暴加深+50%|r',2)
            end

            if p.jbjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('技暴极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('技暴几率',5)
                    hero:add('技暴几率极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000技暴几率+5%（无视技暴几率上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_jbjx = true
            end
        end    
    end,           
    ['闪避极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_sbjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.sbjx_cnt = (p.sbjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.sbjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.sbjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.sbjx_cnt % per_kill_cnt == 0 then 
                hero:add('敏捷%',5)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000敏捷+5%|r',2)
            end

            if p.sbjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('闪避极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('闪避',5)
                    hero:add('闪避极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000闪避+5%（无视闪避上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_sbjx = true
            end
        end    
    end,     
         
    ['会心极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_hxjl then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.hxjl_cnt = (p.hxjl_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.hxjl_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.hxjl_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.hxjl_cnt % per_kill_cnt == 0 then 
                hero:add('会心伤害',50)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000会心伤害+50%|r',2)
            end

            if p.hxjl_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('会心极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('会心几率',5)
                    hero:add('会心几率极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000会心几率+5%（无视会心几率上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_hxjl = true
            end
        end    
    end,     
         
    ['免伤极限守卫'] = function(killer,target)
        --召唤物杀死也继承
        local p = killer:get_owner()
        if p.flag_msjx then return end
        local per_kill_cnt = 200 --每20只给奖励
        local max_kill_cnt = 1000 --达到100只给奖励

        local hero = p.hero
        if hero  then 
            p.msjx_cnt = (p.msjx_cnt or 0) + 1
            --处理每20只奖励杀怪+金币
            local cnt = math.floor(p.msjx_cnt/per_kill_cnt)

            p:sendMsg('|cffFFE799【系统消息】|r当前挑战进度：|cffff0000'..(p.msjx_cnt - cnt*per_kill_cnt)..'|r/'..per_kill_cnt,2)
            if p.msjx_cnt % per_kill_cnt == 0 then 
                hero:add('护甲%',5)
                p:sendMsg('|cffFFE799【系统消息】|r完成挑战任务：|cffff0000'..cnt.. '|r/5，获得|cffff0000护甲+5%|r',2)
            end

            if p.msjx_cnt == max_kill_cnt then
                --boss事件
                local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
                local unit = ac.player(12):create_unit('免伤极限BOSS',point)
                unit:add_buff '定身'{
                    time = 2
                }
                unit:add_buff '无敌'{
                    time = 2
                }
                unit:event '单位-死亡' (function(_,unit,killer) 
                    hero:add('免伤',5)
                    hero:add('免伤极限',5)
                    p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00恭喜挑战成功|r，奖励 |cffff0000免伤+5%（无视免伤上限）|r',6)
                end)    
                p:sendMsg('|cffFFE799【系统消息】|r|cffff0000极限BOSS|r已出现，请尽快击杀',2)
                p.flag_msjx = true
            end
        end    
    end,     
}


ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    pcall(task_detail[name],killer,target)
end)    

