

function ac.jiami(p,key,value)
    local v = ZZBase64.decode(p[key])
    v = v  + value
    p[key] = ZZBase64.encode(v)

    ac.SaveServerValue(p,key,v)
    
    if p:GetServerValueErrorCode() then
        p:Map_Stat_SetStat('JF',tostring(v))
    end
end

--存档
function ac.SaveServerValue(p,KEY,value)
    value = tostring(value)
    local s = ZZBase64.encode(value)
    p:Map_SaveServerValue(KEY,s)
end

--读取
function ac.GetServerValue(p,KEY)
    local value = p:Map_GetServerValue(KEY)
    if not value or value == '' or value == "" then
        return 0
    end

    local t = tonumber(value)
    if t then
        return 0
    end

    return ZZBase64.decode(value)
end

--服务器存档 读取 (整合加密key、商城数据)
function ac.get_server(p,key)
    local value,key_name,is_mall
    key_name,is_mall = ac.get_keyname_by_key(key)
    
    if tonumber(is_mall) == 1 and p:Map_HasMallItem(key) then 
        value = 1
    elseif key == 'jifen' then 
		value = ac.GetServerValue(p,'jifen')
	else	
		value = p:Map_GetServerValue(key)
    end	
    return value,key_name,is_mall
end	


--读取积分
for i=1,8 do
    local player = ac.player[i]
    if player:is_player() then

        --读取积分
        local jifen  = tonumber(ac.GetServerValue(player,'jifen'))
        -- print('服务器积分：',player,jifen)


        --读取波数
        local value = player:Map_GetServerValue('boshu')
        if not value or value == '' or value == "" then
            player.boshu = 0
        else
            player.boshu = tonumber(value)
        end
        -- print('服务器波数：',player, player.boshu)

        --保存服务端积分
        player.jifen = ZZBase64.encode(jifen)

        --修复积分为负数的，并奖励10000积分
        if jifen < 0 then 
            local value = -jifen + 10000
            print(jifen,value)
            ac.jiami(player,'jifen',value)
            player:sendMsg('【系统消息】 已修复积分为0，并发放 积分10000 作为补偿',tonumber(ac.GetServerValue(player,'jifen')))
        end   
        if jifen >= 500000 then  
            local value = -jifen 
            ac.jiami(player,'jifen',value)
            player:sendMsg('【系统消息】 检测到积分过高，积分清零',tonumber(ac.GetServerValue(player,'jifen')))
        end    

    else
        player.jifen = 0
        player.boshu = 0
    end
end


ac.game:event '积分变化'(function(_,p,value)
    ac.jiami(p,'jifen',value)
end)

local function save_jifen()
    --只保存一次
    local value
    value = (ac.total_putong_jifen - (ac.old_total_putong_jifen or 0)) * (ac.g_game_degree or 1) / get_player_count() 
    ac.old_total_putong_jifen = ac.total_putong_jifen

    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then
            -- (p.putong_jifen - (p.old_putong_jifen or 0)) * (p.hero:get '积分加成' + (ac.g_game_degree or 1) )
            local p_value = value * (p.hero:get '积分加成' + 1)
            -- print('当前回合最终加的积分',value,'总积分',ac.total_putong_jifen,'难度倍数',ac.g_game_degree,'在线玩家数',get_player_count(),'积分加成',p.hero:get '积分加成')

            local total_value = (ac.total_putong_jifen* (ac.g_game_degree or 1)) / get_player_count() * (p.hero:get '积分加成' + 1)
            -- print('累计获得的积分',total_value)
            -- end 
            -- print('本回合保存积分：',p,p_value)
            --保存积分
            ac.jiami(p,'jifen',p_value)

            --修改排行榜的积分
            if p:is_self() then
                c_ui.ranking.ui.integral:set_text('本局累计获得积分：'..total_value)
            end

          
        end
    end
end    
ac.save_jifen = save_jifen


local rank_art = {'黑铁','黄铜','白银','黄金','铂金','钻石','大师','王者'}
--设置房间KEY
local function set_fangjian_xm(p,count)
    local value = 1
    --段位为1-7 青铜 白银 黄金 白金 钻石 大师 王者
    if count <= 10 then
        value = 1
    elseif count <=20 then
        value = 2
    elseif count <=30 then
        value = 3
    elseif count <=40 then
        value = 4
    elseif count <=50 then
        value = 5
    elseif count <=70 then
        value = 6
    elseif count <=100 then
        value = 7
    elseif count >= 101 then
        value = 8
    end

    if p:GetServerValueErrorCode() then
        if rank_art[value] then 
            p:Map_Stat_SetStat('DW',rank_art[value])
        end 
    end
    --实时更新游戏内的段位数据
    p.rank = value
end

--保存积分方式： 1.无尽后，每回合开始保存。2.打死最终boss保存
ac.game:event '游戏-回合开始'(function(_,index,creep)
    if creep.name ~= '刷怪-无尽' then
        return
    end    
    print('回合开始4')
    ac.save_jifen()
    
    --保存波数
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then
            --保存最大波数和段位
            if creep.index > (p.boshu or 0) then
                if ac.g_game_degree == 2 then 
                    if creep.index <= 30 then 
                        p:Map_SaveServerValue('boshu',creep.index)
                        set_fangjian_xm(p,creep.index)
                    end    
                elseif ac.g_game_degree == 3 then 
                    if creep.index <= 70 then 
                        p:Map_SaveServerValue('boshu',creep.index)
                        set_fangjian_xm(p,creep.index)
                    end  
                else    
                    p:Map_SaveServerValue('boshu',creep.index)
                    set_fangjian_xm(p,creep.index)
                end    
            end    
        end 
    end      
end)

--游戏结束

-- ac.game:event '游戏-回合开始'(function(_)
ac.game:event '游戏-结束'(function(_)
    local value = ac.creep['刷怪-无尽'].index or 0
    if value == 0 then 
        return 
    end    
    --不是圣人模式返回
    if ac.g_game_degree ~= 4 then 
        return 
    end    

    --保存自定义服务器的排名(每日)
    --每一把保存一次,提早退出 无排名
    for i=1,10 do
        local p = ac.player[i]
        if p.hero  then 
            --保存波束
            p:sp_set_rank('boshu_rank',value)
            p:GetServerValue('boshu_rank',function(data)
                if type(data) ~= 'table' then  
                    return
                end    
                if value >= (tonumber(data.value) or 0) then 
                    p:SetServerValue('boshu_rank',value)
                end   
            end)

            --保存金钱
            local gold = tonumber(p.gold_count)
            p:sp_set_rank('gold',gold)
            --如果当前游戏获得金钱>历史总金钱,保存到服务器里面去. 层数
            p:GetServerValue('gold',function(data)
                if type(data) ~= 'table' then  
                    return
                end    
                -- print_r(data)
                if gold >= (tonumber(data.value) or 0) then 
                    p:SetServerValue('gold',gold)
                end   
            end)
        end      
    end    

end);    




