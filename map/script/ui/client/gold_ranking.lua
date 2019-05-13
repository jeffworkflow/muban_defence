
local gold_ranking = {}

gold_ranking = extends( panel_class,{
    create = function()
        --创建底层面板 x,y,width,height
        local panel = panel_class.create('image\\提示框\\bj2.tga',470+475+30,200,475,620)
        --panel:set_alpha(0xff*0.9)
        --继承
        extends(gold_ranking,panel)
        
        --头部
        local top_panel = panel:add_panel('',0,20,475,100)
        --标题 (title,0,0,width,height,font_size,4)
        local title = top_panel:add_text('福布斯排行榜',0,0,475,100,16,4)
        title:set_color(243,246,4,1)
        panel.title = title
        --小标题 显示难度
        local two_title = top_panel:add_text('(圣人模式)',0,0,475,25,10,4)
        two_title:set_color(200,202,8,1)
        panel.two_title = two_title

        --积分
        local integral = top_panel:add_text('',40,top_panel.h-35,200,25,8,3)
        integral:set_color(120,120,120,1)
        panel.integral = integral
        -- --时间
        -- local time = top_panel:add_text('17:59',750,top_panel.h-53,200,25,8,4)
        -- time:set_color(120,120,120,1)
        --日期
        local date = top_panel:add_text('1小时刷新一次',280,top_panel.h-35,200,25,8,4)
        date:set_color(120,120,120,1)
        panel.date = date

        --画一条线 (image_path,x,y,width,height)
        local line = panel:add_texture('image\\角色信息\\line.tga',30,top_panel.y+top_panel.h,405,1)
        line:set_alpha(0xff*0.6)

        --数据面板
        local data_panel = panel:add_panel('',40,line.h+line.y+20,400,400)

        --篮框 用于显示自己的位置
        local lk = data_panel:add_texture('image\\排行榜\\phb_zj.tga',10,77,440,20)
        panel.lk = lk
        lk:hide()
        --玩家
        local p = data_panel:add_text('玩家',0,0,120,20,10,1)
        p:set_color(120,120,120,1)

        --段位
        local gold = data_panel:add_text('最高资产',160,0,80,20,10,1)
        gold:set_color(120,120,120,1)

        --排名
        local rank = data_panel:add_text('排名',280,0,80,20,10,1)
        rank:set_color(120,120,120,1)

        panel.player = {}
        panel.gold = {}
        panel.rank = {}
        local color = {}
        --玩家
        for i = 0,9 do
            local y = i*40+30
            --设置颜色
            if i == 0 then
                color = {255,0,0,1}
            elseif i == 1 then
                color = {22,134,221,1}
            elseif i == 2 then
                color = {23,198,97,1}
            else
                color = {255,255,255,1}
            end

            local p = data_panel:add_text('',0,y,120,35,9,4)
            table.insert(panel.player,p)
            p:set_color(color[1],color[2],color[3],color[4])
            
            local gold = data_panel:add_text('',160,y,80,35,9,4)
            table.insert(panel.gold,gold)
            gold:set_color(color[1],color[2],color[3],color[4])
            --local rank = data_panel:add_texture('image\\排行榜\\toumingtietu.tga',150,y,37,37)
            --table.insert(panel.rank,rank)
            
            local rank = data_panel:add_text('',280,y,80,35,9,4)
            table.insert(panel.rank,rank)
            rank:set_color(color[1],color[2],color[3],color[4])

        end

        return panel
    end,
})

local panel = gold_ranking.create()

gold_ranking.on_key_down = function(code)
    -- print(code)
    if japi.GetChatState() then
        return
    end

    if code == KEY.WAVES then
        -- print('波浪线')
        gold_ranking.ui:show()
        return
    end
end

gold_ranking.on_key_up = function(code)
    if japi.GetChatState() then
        return
    end

    if code == KEY.WAVES then
        gold_ranking.ui:hide()
        return
    end
end



--处理,显示排行榜数据
--取前10名数据
local p = ac.player(1);
local t = {}
p:sp_get_rank('gold','rank',10,function(data)
    -- print_r(data)
    ac.wait(10,function()
        for i = 1, #data do
            local value = tonumber(data[i].value)
            value = ac.numerical(value)
            gold_ranking.ui.player[i]:set_text(data[i].player_name)
            gold_ranking.ui.gold[i]:set_text(value)
            gold_ranking.ui.rank[i]:set_text(data[i].rank)
        end    
    end)
end);



game.register_event(gold_ranking)
panel:hide()
gold_ranking.ui = panel
c_ui.gold_ranking = gold_ranking
return gold_ranking
