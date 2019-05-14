
 
local function save_jifen()
    --只保存一次
    local value
    value = (ac.total_putong_jifen - (ac.old_total_putong_jifen or 0)) * (ac.g_game_degree or 1) / get_player_count() 
    ac.old_total_putong_jifen = ac.total_putong_jifen
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then
            local p_value = value * (p.hero:get '积分加成' + 1)
            local total_value = (ac.total_putong_jifen* (ac.g_game_degree or 1)) / get_player_count() * (p.hero:get '积分加成' + 1)
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




