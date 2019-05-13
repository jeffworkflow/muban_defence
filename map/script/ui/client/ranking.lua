
local ranking = {}

ranking = extends( panel_class,{
    create = function()
        --创建底层面板
        local panel = panel_class.create('image\\提示框\\bj2.tga',485,270,950,540)
        --panel:set_alpha(0xff*0.9)
        --继承
        extends(ranking,panel)
        
        --头部
        local top_panel = panel:add_panel('',0,20,950,100)
        --标题
        local title = top_panel:add_text('排行榜',0,0,950,100,19,4)
        title:set_color(243,246,4,1)
        panel.title = title
        --小标题 显示难度
        local two_title = top_panel:add_text('等待游戏开始',0,0,950,25,10,4)
        two_title:set_color(200,202,8,1)
        panel.two_title = two_title

        --积分
        local integral = top_panel:add_text('本局累计获得积分(需击败最终boss)：0',40,top_panel.h-35,200,25,8,3)
        integral:set_color(120,120,120,1)
        panel.integral = integral
        -- --时间
        -- local time = top_panel:add_text('17:59',750,top_panel.h-53,200,25,8,4)
        -- time:set_color(120,120,120,1)
        --日期
        local date = top_panel:add_text('00.00.00',750,top_panel.h-35,200,25,8,4)
        date:set_color(120,120,120,1)
        panel.date = date

        --画一条线
        local line = panel:add_texture('image\\角色信息\\line.tga',45,top_panel.y+top_panel.h,855,1)
        line:set_alpha(0xff*0.6)

        --数据面板
        local data_panel = panel:add_panel('',40,line.h+line.y+20,770,400)

        --篮框 用于显示自己的位置
        local lk = data_panel:add_texture('image\\排行榜\\phb_zj.tga',10,77,825,20)
        panel.lk = lk
        lk:hide()
        --玩家
        local p = data_panel:add_text('玩家',0,0,120,20,10,1)
        p:set_color(120,120,120,1)

        --段位
        local rank = data_panel:add_text('段位',130,0,80,20,10,1)
        rank:set_color(120,120,120,1)

        --熟练度
        local sld = data_panel:add_text('熟练度',220,0,80,20,10,1)
        sld:set_color(120,120,120,1)

        --杀敌数
        local sds = data_panel:add_text('杀敌数',300,0,80,20,10,1)
        sds:set_color(120,120,120,1)

        --死亡次数
        local death = data_panel:add_text('死亡次数',400,0,80,20,10,1)
        death:set_color(120,120,120,1)
        --金币数
        local gold = data_panel:add_text('获得金币数',490,0,80,20,10,1)
        gold:set_color(120,120,120,1)
        --伤害量
        local damage = data_panel:add_text('累计伤害',590,0,100,20,10,1)
        damage:set_color(120,120,120,1)

        --承受伤害
        local take_damage = data_panel:add_text('承受伤害',680,0,100,20,10,1)
        take_damage:set_color(120,120,120,1)
        --kda
        local kda = data_panel:add_text('KDA',750,0,80,20,10,1)
        kda:set_color(120,120,120,1)

        panel.player = {}
        panel.rank = {}
        panel.kill_count = {}
        panel.death_count = {}
        panel.gold_count = {}
        panel.damage_count = {}
        panel.take_damage = {}
        panel.sld = {}
        panel.kda = {}
        local color = {}
        --玩家
        for i = 0,7 do
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
            
            local rank = data_panel:add_text('',130,y,80,35,9,4)
            table.insert(panel.rank,rank)
            rank:set_color(color[1],color[2],color[3],color[4])
            --local rank = data_panel:add_texture('image\\排行榜\\toumingtietu.tga',150,y,37,37)
            --table.insert(panel.rank,rank)
            
            local sld = data_panel:add_text('',220,y,80,35,9,4)
            table.insert(panel.sld,sld)
            sld:set_color(color[1],color[2],color[3],color[4])

            local kill_count = data_panel:add_text('',300,y,80,35,9,4)
            table.insert(panel.kill_count,kill_count)
            kill_count:set_color(color[1],color[2],color[3],color[4])

            local death_count = data_panel:add_text('',400,y,80,35,9,4)
            table.insert(panel.death_count,death_count)
            death_count:set_color(color[1],color[2],color[3],color[4])
            
            local gold_count = data_panel:add_text('',490,y,80,35,9,4)
            table.insert(panel.gold_count,gold_count)
            gold_count:set_color(color[1],color[2],color[3],color[4])

            local damage_count = data_panel:add_text('',590,y,100,35,9,4)
            table.insert(panel.damage_count,damage_count)
            damage_count:set_color(color[1],color[2],color[3],color[4])

            local take_damage = data_panel:add_text('',680,y,100,35,9,4)
            table.insert(panel.take_damage,take_damage)
            take_damage:set_color(color[1],color[2],color[3],color[4])


            local kda = data_panel:add_text('',750,y,80,35,9,4)
            table.insert(panel.kda,kda)          
            kda:set_color(color[1],color[2],color[3],color[4])


        end

        return panel
    end,
})

local panel = ranking.create()

ranking.on_key_down = function(code)
    -- print(code)
    if japi.GetChatState() then
        return
    end

    if code == KEY.TAB then
        -- print('波浪线')
        ranking.ui:show()
        return
    end
end

ranking.on_key_up = function(code)
    if japi.GetChatState() then
        return
    end

    if code == KEY.TAB then
        ranking.ui:hide()
        return
    end
end



game.register_event(ranking)
panel:hide()
ranking.ui = panel
c_ui.ranking = ranking
return ranking