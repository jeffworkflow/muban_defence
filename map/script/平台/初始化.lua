
local japi = require 'jass.japi'

--预设
for i=1,10 do
    local p = ac.player[i]  
    if not p.mall then 
        p.mall = {}
    end  
    if not p.cus_server then 
        p.cus_server ={}
    end    
    if not p.mall_flag then 
        p.mall_flag = {}
    end  
    -- 作弊
    if finds(p:get_name(),'后山一把刀','卡卡发动机','蜗牛互娱','特朗普领航') then 
        p.cheating = true 
        require '测试.helper'
    end  
end

--初始化1  copy 网易数据到自己的服务器去； 
if ac.server.init then 
    ac.server.init()  
end    

--初始化2 读取自定义服务器的数据 并同步 p.cus_server2[jifen] = 0 | 读取有延迟
-- for i=1,10 do
--     local player = ac.player[i]
--     if player:is_player() then
--         if player:is_self() then 
--             player:sp_get_map_test()
--         end    
--     end
-- end

--初始化2 读取网易服务器的数据 p.cus_server[jifen] = 0 | 读取有延迟
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then
       for index,data in ipairs(ac.cus_server_key) do
            local key = data[1]
            local key_name = data[2]
            local val = player:Map_GetServerValue(key)
            if not player.cus_server then 
                player.cus_server = {}
            end
            player.cus_server[key_name] = val
            -- print('存档数据:',key,key_name,val)
        end
        ac.wait(100,function()
            player:event_notify '读取存档数据'
        end)
    end
end

--初始化3 商城数据 → 业务端
for i=1,10 do
    local p = ac.player[i]  
    --皮肤道具
    if p:is_player() then 
        for n=1,#ac.mall do
            -- print("01",p:Map_HasMallItem(ac.mall[n][1]))
            local need_map_level = ac.mall[n][3] or 999999999999
            -- print(p:Map_HasMallItem(ac.mall[n][1]),ac.mall[n][1],need_map_level)
            if     (p:Map_HasMallItem(ac.mall[n][1]) 
                or (p:Map_GetServerValue(ac.mall[n][1]) == '1') 
                or (p:Map_GetMapLevel() >= need_map_level) 
                or (p.cheating)) 
            then
                local name = ac.mall[n][2]  
                p.mall[name] = 1  
            end  
        end    
    end    
end 

--处理自定义服务器作弊数据
ac.wait(3000,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() and player.cheating then
            for i,data in ipairs(ac.cus_server_key) do
                player.cus_server[data[2]] = math.max(1,player.cus_server[data[2]] or 0)
            end    
        end
    end
end)

local star2award = {
    --奖励 = 段位 星数 需求地图等级
    
    ['幻海雪饮剑'] = {'最强王者',40,10},
    ['天罡苍羽翼'] = {'最强王者',50,10},
    ['炉火纯青'] = {'青铜',1,2},
    ['毁天灭地'] = {'黄金',5,4},
    ['风驰电掣'] = {'钻石',10,6},
    ['无双魅影'] = {'王者',15,8},
    ['赵子龙'] = {'白银',3,2},
    ['Pa'] = {'铂金',7,4},
    ['手无寸铁的小龙女'] = {'星耀',10,6},
    ['关羽'] = {'最强王者',30,10},
}
--注册 保存青铜，王者等星数
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end    
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --保存星数
            local name = ac.g_game_degree_name
            local key = ac.server.name2key(name)
            -- player:AddServerValue(key,1)  -- 自定义服务器
            player:Map_AddServerValue(key,1) --网易服务器

            player:sendMsg('【游戏胜利】|cffff0000'..name..'星数+1|r')

            --保存游戏时长 只保存自定义服务器
            local name = name..'时长'
            local key = ac.server.name2key(name)
            local cus_value = tonumber((player.cus_server2 and player.cus_server2[name]) or 99999999)
            --游戏时长 < 存档时间 
            if os.difftime(cus_value,ac.g_game_time) > 0 then 
                -- player:SetServerValue(key,ac.g_game_time) --自定义服务器
                -- player:Map_SaveServerValue(key,ac.g_game_time) --网易服务器
            end    
            --文字提醒
            local str = os.date("!%H:%M:%S",tonumber(ac.g_game_time)) 
            player:sendMsg('【游戏胜利】|cffff0000本次通关时长：'..str..'|r')
            
        end
    end
end)    

for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then
        player:event '读取存档数据' (function()
            for name,data in sortpairs(star2award) do 
                --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
                local has_item = player.cus_server and (player.cus_server[name] or 0 )
                local dw_value = player.cus_server and (player.cus_server[data[1]] or 0 )
                if has_item and has_item == 0 
                and dw_value >= (data[2] or 9999999)
                and player:Map_GetMapLevel() >= (data[3]  or 0)
                then 
                    local key = ac.server.name2key(name)
                    -- player:SetServerValue(key,1) 自定义服务器
                    player:Map_SaveServerValue(key,1) --网易服务器
                    -- player:sendMsg('激活成功：'..key)
                end   
            end   
        end)  
    end
end    

    
--处理挖宝积分 及对应的奖励
local wabao2award_data = {
    --奖励 = 积分，地图等级
    ['势不可挡'] = {2000,3},
    ['冰龙'] = {10000,5},
    ['霸王莲龙锤'] = {20000,10},
    ['梦蝶仙翼'] = {30000,10},

    ['血雾领域'] = {5000,4},
    --全属性 = 每点积分加的值,地图等级*上限值
    ['全属性'] = {200,50000},
}            
local function wabao2award()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '读取存档数据' (function()
                for name,data in sortpairs(wabao2award_data) do 
                    if name == '全属性' then 
                    else
                        --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
                        local has_item = player.cus_server and (player.cus_server[name] or 0 )
                        local wabaojifen = player.cus_server and (player.cus_server['挖宝积分'] or 0 )
                        -- print(has_item,sp_cnt,skill.need_sp_cnt)
                        if has_item and has_item == 0 
                        and wabaojifen >= (data[1] or 9999999)
                        and player:Map_GetMapLevel() >= (data[2]  or 9999999)
                        then 
                            local key = ac.server.name2key(name)
                            -- player:SetServerValue(key,1) 自定义服务器
                            player:Map_SaveServerValue(key,1) --网易服务器
                            -- player:sendMsg('激活成功：'..key)
                        end    
                    end    
                end   
            end)  
            player:event '玩家-注册英雄后' (function()
                local map_level = player:Map_GetMapLevel() > 0 and  player:Map_GetMapLevel() or 1
                local wabaojifen = player.cus_server and (player.cus_server['挖宝积分'] or 0 )
                local value = math.min(wabao2award_data['全属性'][1]*wabaojifen,wabao2award_data['全属性'][2] * map_level) --取挖宝积分*500 和地图等级*15000的最小值。
                player.hero:add('全属性',value) 
            end) 
        end
    end    
end
wabao2award()


local shenlong2award_data = {
    --奖励 = 碎片，地图等级
    ['耐瑟龙'] = {15,3},
    ['冰龙'] = {75,5},
    ['精灵龙'] = {300,8},
    ['奇美拉'] = {400,15},
    ['Pa'] = {50,3},
    ['手无寸铁的小龙女'] = {100,6},
    ['关羽'] = {300,10},
    ['霸王莲龙锤'] = {200,10},
    ['梦蝶仙翼'] = {250,10},
} 
--处理神龙碎片 及对应的奖励
local function shenlong2award() 
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '读取存档数据' (function()
                for name,data in sortpairs(shenlong2award_data) do 
                    --商城 或是 自定义服务器有对应数据则
                    --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
                    local has_item = player.cus_server and (player.cus_server[name] or 0 )
                    local suipin = player.cus_server and (player.cus_server[name..'碎片'] or 0 )
                    -- print(has_item,sp_cnt,skill.need_sp_cnt)
                    if has_item and has_item == 0 
                    and suipin >= (data[1] or 9999999)
                    and player:Map_GetMapLevel() >= (data[2]  or 9999999)
                    then 
                        local key = ac.server.name2key(name)
                        -- player:SetServerValue(key,1) 自定义服务器
                        player:Map_SaveServerValue(key,1) --网易服务器
                        -- player:sendMsg('激活成功：'..key)
                    end    
                end   
            end) 
        end
    end    
end
shenlong2award()

--替天行道 兑换称号
local ttxd2award1 = {
    -- 奖励 = 所需数量 所需等级 --真正逻辑处理再 替天行道.lua 里面
    ['势不可挡'] = {0,3},
    ['君临天下'] = {0,4},
    ['神帝'] = {0,10},
    ['傲世天下'] = {0,11},
}    

--处理替天行道 永久属性
local function ttxd2award()
    local content_data = {
        --奖励 = 每存档力量奖励的值 , 每地图等级上限值
        ['力量'] = {60000,1},
        ['敏捷'] = {60000,1},
        ['智力'] = {60000,1},
        ['全属性'] = {30000,1},

        --奖励 = 杀鸡儆猴奖励每秒全属性, 每地图等级上限值
        ['杀怪加全属性'] = {1,25},
    }  
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '玩家-注册英雄后' (function()
                for name,data in sortpairs(content_data) do 
                    local cnt = 0
                    local value = 0
                    if name == '杀怪加全属性' then 
                        cnt= player.cus_server and (player.cus_server['杀鸡儆猴'] or 0 )
                    else
                        cnt= player.cus_server and player.cus_server[name] or 0 
                    end     
                    local map_level = player:Map_GetMapLevel() > 0 and player:Map_GetMapLevel() or 1
                    local cnt = math.min(cnt,data[2]*map_level)
                    value = cnt * data[1]
                    -- print(player:Map_GetMapLevel())
                    -- print(name,value)
                    --增加属性
                    player.hero:add(name,value)
                end   
            end) 
        end
    end    
end
ttxd2award()

--开始进行地图等级集中过滤
ac.server.need_map_level = {}
local function init_need_map_level()
    for i,data in ipairs(ac.cus_server_key) do
        if data[3] then 
            -- print(data[2],data[3])
            ac.server.need_map_level[data[2]] = data[3]
        end    
    end

    for name,data in pairs(star2award) do
        ac.server.need_map_level[name] = data[3]
    end
    for name,data in pairs(wabao2award_data) do
        ac.server.need_map_level[name] = data[2]
    end
    for name,data in pairs(shenlong2award_data) do
        ac.server.need_map_level[name] = data[2]
    end
    for name,data in pairs(ttxd2award1) do
        ac.server.need_map_level[name] = data[2]
    end

    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            for name,val in pairs(p.cus_server) do 
                local real_val = (p:Map_GetMapLevel() >= (ac.server.need_map_level[name] or 0))and val or 0 
                if name ~= '全属性' then 
                    -- print('地图等级',p:Map_GetMapLevel(),ac.server.need_map_level[name],val)
                    -- print('经过地图等级之后的数据：',name,val,real_val)
                    p.cus_server[name] = real_val
                end    
            end    
        end   
    end
end;
ac.init_need_map_level =init_need_map_level
ac.init_need_map_level()


