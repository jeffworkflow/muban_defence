
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
    local cheating = [[
        后山一把刀 卡卡发动机  蜗牛互娱 特朗普领航
    ]]
    -- 作弊
    if finds(cheating,p:get_name()) then 
        p.cheating = true 
        require '测试.helper'
    end  
end

--初始化1  copy 网易数据到自己的服务器去； 
-- if ac.server.init then 
--     ac.server.init()  
-- end    

--初始化2 读取自定义服务器的数据 并同步 p.cus_server2[jifen] = 0 | 读取有延迟
ac.wait(1*1000,function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            if player:is_self() then 
                player:sp_get_map_test()
            end    
        end
    end
end)
--初始化2 读取自定义服务器 部分数据
ac.game:event '游戏-开始' (function()
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            if player:is_self() then 
                local key = ac.server.name2key(ac.g_game_degree_name)
                player:GetServerValue(key)

                local key = ac.server.name2key(ac.g_game_degree_name..'无尽')
                if key then 
                    player:GetServerValue(key)
                end    
            end    
        end
    end
    
end)



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
        ac.wait(1100,function()
            player:event_notify '读取存档数据'
            player:event_notify '读取存档数据后'
        end)
    end
end

--初始化3 商城数据 → 业务端
for i=1,10 do
    local p = ac.player[i]  
    --皮肤道具
    if p:is_player() then 
        p:event '读取存档数据' (function()
            for n=1,#ac.mall do
                -- print("01",p:Map_HasMallItem(ac.mall[n][1]))
                local need_map_level = ac.mall[n][3] or 999999999999
                -- print(p:Map_HasMallItem(ac.mall[n][1]),ac.mall[n][1],need_map_level)
                if     (p:Map_HasMallItem(ac.mall[n][1]) 
                    or (p:Map_GetMapLevel() >= need_map_level) 
                    or (p.cheating)) 
                then
                    local name = ac.mall[n][2]  
                    p.mall[name] = 1  
                end  
            end    
        end)    
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

--清理不必要的存档
ac.wait(10,function()
    -- local name = [[谜情小伙]]
    local temp_mall = {
        {'time_qt','青铜时长'},
        {'time_by','白银时长'},
        {'time_hj','黄金时长'},
        {'time_bj','铂金时长'},
        {'time_zs','钻石时长'},
        {'time_xy','星耀时长'},
        {'time_wz','王者时长'},
        {'time_zqwz','最强王者时长'},
        {'time_rywz','荣耀王者时长'},
        {'time_dfwz','巅峰王者时长'},
        {'time_xlms','修罗模式时长'},
        {'time_dpcq','斗破苍穹时长'},
        {'time_wszj','无上之境时长'},
        {'time_wxld','无限乱斗时长'},
        {'time_syld','深渊乱斗时长'},
        {'time_pkms','武林大会时长'},

        {'today_wjxlms','今日修罗模式无尽'},
        {'today_wjxlmsrank','今日修罗模式无尽排名'},
        {'today_wjdpcq','今日斗破苍穹无尽'},
        {'today_wjdpcqrank','今日斗破苍穹无尽排名'},
        {'today_wjwszj','今日无上之境无尽'},
        {'today_wjwszjrank','今日无上之境无尽排名'},

        {'today_wjwxld','今日无限乱斗无尽'},
        {'today_wjwxldrank','今日无限乱斗无尽排名'},

        {'today_wjsyld','今日深渊乱斗无尽'},
        {'today_wjsyldrank','今日深渊乱斗无尽排名'},
        
        {'cntwb','挖宝'},
        {'today_cntwb','今日挖宝'},
        {'today_cntwbrank','今日挖宝排名'},
        
        {'cntwl','比武'},
        {'today_cntwl','今日比武'},
        {'today_cntwlrank','今日比武排名'},


        --以下 网易服务器 不需要继续的存档
        {'hdgx','高兴'},
        {'hdfn','愤怒'},
        {'hdyw','厌恶'},
        {'hdkj','恐惧'},

        {'hhxyj','幻海雪饮剑'},
        {'tgcyy','天罡苍羽翼'},

        {'lhcq','炉火纯青'},
        {'sbkd','势不可挡'},
        {'htmd','毁天灭地'},
        {'dfty','风驰电掣'},
        {'jstj','无双魅影'},
        {'zzl','赵子龙'},
        {'zsas','紫色哀伤'},
        {'blnsy','白龙凝酥翼'},
        {'szas','霜之哀伤'},
        {'lhjyly','烈火金焰领域'},  
        {'lysxy','龙吟双形翼'},
        {'tszg','天使之光'},
        {'byshly','白云四海领域'},
        {'hsslly','烈火天翔领域'},
        {'fthj','方天画戟'},
        {'sswsj','圣神无双剑'},
        {'jlsxy','金鳞双型翼'},
        {'mszxj','灭神紫霄剑'},
        {'cmsxy','赤魔双形翼'},
        
        {'ntgm','逆天改命'},
        {'qcfh','七彩凤凰'},
        {'lsywly','罗刹夜舞领域'},


    }
    for i,data in ipairs(ac.mall) do 
        table.insert(temp_mall,data)
    end

    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() --and finds(name,player:get_name())  
        then
            player:clear_server(temp_mall)
        end
    end
end)

--保存今日榜
local function save_today_rank()
    local today_rank = {
        {'today_wjxlms','今日修罗模式无尽'},
        {'today_wjdpcq','今日斗破苍穹无尽'},
        {'today_wjwszj','今日无上之境无尽'},
        {'today_wjwxld','今日无限乱斗无尽'},
        {'today_wjsyld','今日深渊乱斗无尽'},
    }
    if ac.g_game_degree_attr < 11 then 
        return 
    end    
    if ac.creep['刷怪-无尽1'].index == 0 then 
        return 
    end    
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then 
            --保存波束
            for i ,content in ipairs(today_rank) do 
                if finds(content[2],ac.g_game_degree_name) then 
                    if p:Map_GetMapLevel() >=3 then 
                        p:sp_set_rank(content[1],ac.creep['刷怪-无尽1'].index)
                    end    
                    break
                end    
            end    
        end
    end   
end    

local star2award = {
    --奖励 = 段位 星数 需求地图等级
    
    ['幻海雪饮剑'] = {'星耀',10,10},
    ['天罡苍羽翼'] = {'王者',10,10},
    ['炉火纯青'] = {'青铜',1,2},
    ['毁天灭地'] = {'黄金',3,4},
    ['风驰电掣'] = {'钻石',5,6},
    ['无双魅影'] = {'王者',5,8},
    ['赵子龙'] = {'白银',2,2},
    ['Pa'] = {'铂金',3,4},
    ['手无寸铁的小龙女'] = {'星耀',5,6},
    ['关羽'] = {'最强王者',15,10},
    ['紫色哀伤'] = {'荣耀王者',15,13},
    ['白龙凝酥翼'] = {'巅峰王者',15,15},
    ['霜之哀伤'] = {'修罗模式',25,16},
    ['烈火金焰领域'] = {'斗破苍穹',25,25},
    ['龙吟双形翼'] = {'无上之境',25,29},
    ['灭神紫霄剑'] = {'无限乱斗',25,15},
    
    
    ['天使之光'] = {'修罗模式无尽累计',150,18},
    ['白云四海领域'] = {'修罗模式无尽累计',500,22},
    
    ['烈火天翔领域'] = {'斗破苍穹无尽累计',150,24},
    ['方天画戟'] = {'斗破苍穹无尽累计',500,26},

    ['圣神无双剑'] = {'无上之境无尽累计',150,31},
    ['金鳞双型翼'] = {'无上之境无尽累计',500,33},

    ['赤魔双形翼'] = {'无限乱斗无尽累计',300,36},
    ['真武青焰领域'] = {'无限乱斗无尽累计',800,39},

    ['逆天改命'] = {'深渊乱斗',25,17},
    ['七彩凤凰'] = {'深渊乱斗无尽累计',300,38},
    ['罗刹夜舞领域'] = {'深渊乱斗无尽累计',800,42},
}

--保存修罗模式 星数
ac.game:event '游戏-无尽开始'(function(trg) 
    ac.wait(10,function()   
        for i=1,10 do
            local player = ac.player[i]
            if player:is_player() then
                --保存星数
                local name = ac.g_game_degree_name
                local key = ac.server.name2key(name)
                if player:Map_GetMapLevel() >=3 then 
                    player:AddServerValue(key,1)  -- 自定义服务器
                end    
                player:Map_AddServerValue(key,1) --网易服务器

                player:sendMsg('【游戏胜利】|cffff0000'..name..'星数+1|r')

                --保存游戏时长 只保存自定义服务器
                local name = name..'时长'
                local key = ac.server.name2key(name)
                local cus_value = tonumber((player.cus_server2 and player.cus_server2[name]) or 99999999)
                --游戏时长 < 存档时间 
                if os.difftime(cus_value,ac.g_game_time) > 0 then 
                    if player:Map_GetMapLevel() >=3 then 
                        player:SetServerValue(key,ac.g_game_time) --自定义服务器
                    end    
                    -- player:Map_SaveServerValue(key,ac.g_game_time) --网易服务器
                end    
                --文字提醒
                local str = os.date("!%H:%M:%S",tonumber(ac.g_game_time)) 
                player:sendMsg('【游戏胜利】|cffff0000本次通关时长：'..str..'|r')
                
            end
        end
    end)

    --没两分钟保存一次今日榜
    local time = 2 * 60
    ac.loop(time*1000,function() 
        save_today_rank()
    end)

end)
-- 游戏结束，今日排行榜
ac.game:event '游戏-结束'(function(_)     
    save_today_rank()
end)   

--保存修罗模式 无尽层数
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪-无尽1' then
        return
    end     
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --保存无尽累计值
            local name = ac.g_game_degree_name..'无尽累计'
            local key = ac.server.name2key(name)
            player:Map_AddServerValue(key,1)  -- 网易服务器 无尽累计值

            --保存无尽波数
            local name = ac.g_game_degree_name..'无尽'
            local key = ac.server.name2key(name)
            --波数>存档波数
            local cus_value = tonumber((player.cus_server2 and player.cus_server2[name]) or 0)
            -- p:sp_set_rank('today_boshu',value)
            if index > cus_value then 
                if (ac.flag_map or 0 ) == 1 then  
                    if player:Map_GetMapLevel() >=3 then 
                        player:SetServerValue(key,index)  -- 自定义服务器 
                    end    
                end    
            end   

            local cus_value = tonumber((player.cus_server and player.cus_server[name]) or 0)
            if index > cus_value then 
                player:Map_SaveServerValue(key,index) --网易服务器
            end 
        end
    end        

end)

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
            
            if player:Map_GetMapLevel() >=3 then 
                player:AddServerValue(key,1)  -- 自定义服务器
            end    
            player:Map_AddServerValue(key,1) --网易服务器

            player:sendMsg('【游戏胜利】|cffff0000'..name..'星数+1|r')

            --保存游戏时长 只保存自定义服务器
            local name = name..'时长'
            local key = ac.server.name2key(name)
            local cus_value = tonumber((player.cus_server2 and player.cus_server2[name]) or 99999999)
            --游戏时长 < 存档时间 
            if os.difftime(cus_value,ac.g_game_time) > 0 then 
                if player:Map_GetMapLevel() >=3 then 
                    player:SetServerValue(key,ac.g_game_time) --自定义服务器
                end    
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
        if not player.cus_server then 
            player.cus_server={}
        end    
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
                    if finds(name,'Pa','小龙女','关羽') then 
                       player:Map_SaveServerValue(key,1) --网易服务器
                    else 
                       player.cus_server[name] = 1
                    end      
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
    ['魅影'] = {45000,15},
    ['紫霜幽幻龙鹰'] = {70000,17},
    ['天马行空'] = {100000,33},
    

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
    ['耐瑟龙'] = {10,3},
    ['冰龙'] = {50,5},
    ['精灵龙'] = {250,8},
    ['奇美拉'] = {350,13},
    ['Pa'] = {30,3},
    ['手无寸铁的小龙女'] = {75,6},
    ['关羽'] = {250,10},
    ['霸王莲龙锤'] = {150,10},
    ['梦蝶仙翼'] = {200,10},
    ['魅影'] = {400,15},
    ['紫霜幽幻龙鹰'] = {500,17},
    
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
    ['神帝'] = {0,9},
    ['傲世天下'] = {0,10},
    ['九洲帝王'] = {0,5},
    --精彩活动
    ['缘定三生'] = {0,5},
    ['井底之蛙'] = {0,5},
    ['食物链顶端的人'] = {0,5},
    ['有趣的灵魂'] = {0,5},
    ['蒙娜丽莎的微笑'] = {0,5},

    ['四海共团圆'] = {0,5},
    ['第一个吃螃蟹的人'] = {0,5},
    ['博饼'] = {0,5},
    --英雄
    ['王昭君'] = {0,30},
    ['雅典娜'] = {0,30},
    --宠物皮肤
    ['玉兔'] = {0,5},
}    

--处理替天行道 永久属性
local function ttxd2award()
    local content_data = {
        --奖励 = 每存档力量奖励的值 , 每地图等级上限值
        ['力量'] = {60000,2},
        ['敏捷'] = {60000,2},
        ['智力'] = {60000,2},
        ['全属性'] = {30000,2},

        --奖励 = 杀鸡儆猴奖励每秒全属性, 每地图等级上限值
        ['杀怪加全属性'] = {1,35},
        --奖励 = 在线奖励攻击减甲, 每地图等级上限值（神奇的五分钟）
        ['攻击减甲'] = {1,25},
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


local wldh2award_data = {
    --奖励 = 武林大会积分，地图等级
    ['江湖小虾'] = {250,3},
    ['明日之星'] = {500,6},
    ['武林高手'] = {1000,8},
    ['绝世奇才'] = {1500,10},
    ['威震三界'] = {2000,12},
} 
--处理神龙碎片 及对应的奖励
local function wldh2award() 
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            player:event '读取存档数据' (function()
                for name,data in sortpairs(wldh2award_data) do 
                    --商城 或是 自定义服务器有对应数据则
                    --碎片相关在添加时先判断有没超过100碎片，超过完设置服务器变量为1
                    local has_item = player.cus_server and (player.cus_server[name] or 0 )
                    local jifen = player.cus_server and (player.cus_server['比武积分'] or 0 )
                    -- print(has_item,sp_cnt,skill.need_sp_cnt)
                    if has_item and has_item == 0 
                    and jifen >= (data[1] or 9999999)
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
wldh2award()

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

    for name,data in pairs(wldh2award_data) do
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

ac.wait(1300,function()
    ac.init_need_map_level()
end)

