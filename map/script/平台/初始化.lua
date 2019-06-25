
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
    if finds(p:get_name(),'后山一把火','后山一把刀','卡卡发动机') then 
        p.cheating = true 
        require '测试.helper'
    end  
end

--初始化1  copy 网易数据到自己的服务器去； 
--初始化自己的服务器预设字符串  --暂时去掉 字段太多保存会有问题。
ac.server.init()  

--初始化2 读取自定义服务器的数据 并同步 p.cus_server[jifen] = 0
--读取有延迟
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then
        player:sp_get_map_test()
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
                local key = ac.mall[n][2]  
                p.mall[key] = 1  
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
    ['天罡苍羽翼'] = {'最强王者',50},
    ['炉火纯青'] = {'青铜',1},
    ['毁天灭地'] = {'黄金',5},
    ['巅峰天域'] = {'钻石',10},
    ['九世天尊'] = {'王者',25},
    ['赵子龙'] = {'白银',3},
    ['Pa'] = {'铂金',7},
    ['手无寸铁的小龙女'] = {'星耀',15},
    ['关羽'] = {'最强王者',30},
}
--注册 保存青铜，王者等星数
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end    
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --保存波数
            local name = ac.g_game_degree_name
            local key = ac.server.name2key(name)
            player:AddServerValue(key,1) 
        end
    end
end)    
for i=1,10 do
    local player = ac.player[i]
    if player:is_player() then
        player:event '读取存档数据' (function()
            for name,data in pairs(star2award) do 
                --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
                local has_item = player.cus_server and (player.cus_server[name] or 0 )
                local dw_value = player.cus_server and (player.cus_server[data[1]] or 0 )
                -- print(has_item,sp_cnt,skill.need_sp_cnt)
                if has_item and has_item == 0 
                and dw_value >= (data[2] or 9999999)
                and player:Map_GetMapLevel() >= (data[3]  or 0)
                then 
                    local key = ac.server.name2key(name)
                    player:SetServerValue(key,1)
                    -- player:sendMsg('激活成功：'..key)
                end   
            end   
        end)  
    end
end    

              
--处理挖宝积分 及对应的奖励
local function wabao2award()
    local content_data = {
        --奖励 = 积分，地图等级
        ['势不可挡'] = {5000,3},
        ['冰龙'] = {20000,5},
        ['霸王莲龙锤'] = {40000,10},
        ['梦蝶仙翼'] = {70000,10},
        --全属性 = 每点积分加的值,地图等级*上限值
        ['全属性'] = {500,150000},
    }  
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '读取存档数据' (function()
                for name,data in pairs(content_data) do 
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
                            player:SetServerValue(key,1)
                            -- player:sendMsg('激活成功：'..key)
                        end    
                    end    
                end   
            end)  
            player:event '玩家-注册英雄后' (function()
                local map_level = player:Map_GetMapLevel() 
                local wabaojifen = player.cus_server and (player.cus_server['挖宝积分'] or 0 )
                local value = math.min(content_data['全属性'][1]*wabaojifen,content_data['全属性'][2] * map_level) --取挖宝积分*500 和地图等级*15000的最小值。
                player.hero:add('全属性',value) 
            end) 
        end
    end    
end
wabao2award()


--处理神龙碎片 及对应的奖励
local function shenlong2award()
    local content_data = {
        --奖励 = 碎片，地图等级
        ['耐瑟龙'] = {15,3},
        ['冰龙'] = {75,5},
        ['精灵龙'] = {500,8},
        ['奇美拉'] = {800,10},
        ['Pa'] = {50,3},
        ['手无寸铁的小龙女'] = {150,5},
        ['关羽'] = {500,10},
        ['霸王莲龙锤'] = {300,10},
        ['梦蝶仙翼'] = {400,10},
    }  
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '读取存档数据' (function()
                for name,data in pairs(content_data) do 
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
                        player:SetServerValue(key,1)
                        -- player:sendMsg('激活成功：'..key)
                    end    
                end   
            end) 
        end
    end    
end
shenlong2award()


--处理替天行道 永久属性
local function ttxd2award()
    local content_data = {
        --奖励 = 每存档力量奖励的值 
        ['力量'] = {100000},
        ['敏捷'] = {100000},
        ['智力'] = {100000},
        ['全属性'] = {50000},
    }  
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '玩家-注册英雄后' (function()
                for name,data in pairs(content_data) do 
                    local cnt = player.cus_server and (player.cus_server[name] or 0 )
                    local value = cnt * data[1]
                    --增加属性
                    player.hero:add(name,value)
                end   
            end) 
        end
    end    
end
ttxd2award()