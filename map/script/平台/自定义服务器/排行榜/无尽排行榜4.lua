local slk = require 'jass.slk'

class.today_dpwj_panel = extends(class.panel){
    create = function()
        --创建底层面板 x,y,width,height
        local panel = class.panel.create('image\\提示框\\bj2.tga',170+400+400+400+30+30+30,200,400,620)
        panel.__index = class.today_dpwj_panel 
        
        --头部
        local top_panel = panel:add_panel('',0,20,400,100)
        --标题 (title,0,0,width,height,font_size,4)
        local title = top_panel:add_text('无尽排行榜(今日)',0,0,400,100,16,4)
        title:set_color(243,246,4,1)
        panel.title = title
        --小标题 显示难度
        local two_title = top_panel:add_text('(修罗模式)',0,0,400,25,10,4)
        two_title:set_color(200,202,8,1)
        panel.two_title = two_title

        -- --时间
        -- local time = top_panel:add_text('17:59',750,top_panel.h-53,200,25,8,4)
        -- time:set_color(120,120,120,1)
        --日期
        local date = top_panel:add_text('|cff7878781小时刷新一次|r|cffff0000(有奖)|r',210,top_panel.h-35,200,25,8,4)
        -- date:set_color(120,120,120,1)
        panel.date = date

        --画一条线 (image_path,x,y,width,height)
        local line = panel:add_texture('image\\角色信息\\line.tga',30,top_panel.y+top_panel.h,335,1)
        line:set_alpha(0xff*0.6)

        --数据面板
        local data_panel = panel:add_panel('',30,line.h+line.y+20,360,400)

        --篮框 用于显示自己的位置
        local lk = data_panel:add_texture('image\\排行榜\\phb_zj.tga',10,77,440,20)
        panel.lk = lk
        lk:hide()
        --玩家
        local p = data_panel:add_text('玩家',0,0,110,20,10,1)
        p:set_color(120,120,120,1)

        --段位
        local gold = data_panel:add_text('无尽波数',150,0,80,20,10,1)
        gold:set_color(120,120,120,1)

        --排名
        local rank = data_panel:add_text('排名',270,0,80,20,10,1)
        rank:set_color(120,120,120,1)

        panel.player = {}
        panel.boshu = {}
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

            local p = data_panel:add_text('',0,y,110,35,9,4)
            table.insert(panel.player,p)
            p:set_color(color[1],color[2],color[3],color[4])
            
            local gold = data_panel:add_text('',150,y,80,35,9,4)
            table.insert(panel.boshu,gold)
            gold:set_color(color[1],color[2],color[3],color[4])
            --local rank = data_panel:add_texture('image\\排行榜\\toumingtietu.tga',150,y,37,37)
            --table.insert(panel.rank,rank)
            
            local rank = data_panel:add_text('',270,y,80,35,9,4)
            table.insert(panel.rank,rank)
            rank:set_color(color[1],color[2],color[3],color[4])

        end
        --关闭按钮
        panel.close_button = panel:add_button('image\\操作栏\\cross.blp',panel.w - 32-5,5,32,32,true)
        panel:hide()
        return panel
    end,
    

    on_button_clicked = function (self,button)
        -- print(123)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    
}

local panel

ac.wait(10,function ()
    panel = class.today_dpwj_panel.get_instance()
end)

local game_event = {}
game_event.on_key_down = function (code)
    -- if code == KEY.F5 then 
    --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
    -- end
    if code == KEY.F67 then 
        if panel == nil then return end 
        if panel.is_show then 
            panel:hide()
        else 
            panel:show()
        end 
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 

game.register_event(game_event)



local rank = {
    {'today_wjxlms','今日修罗模式无尽'},
}
--处理,显示排行榜数据
--取前10名数据
ac.wait(3*1000,function() 
    for i,content in ipairs(rank) do
        local p = ac.player(1);
        p:sp_get_rank(content[1],'rank',10,function(data)
            -- print_r(data)
            ac.wait(10,function()
                for i = 1, #data do
                    panel.player[i]:set_text(data[i].player_name)
                    panel.boshu[i]:set_text(data[i].value)
                    panel.rank[i]:set_text(data[i].rank)
                end    
            end)
        end);
    end    
end)


