local slk = require 'jass.slk'

class.player_info_panel = extends(class.panel){
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\提示框\\BJ.tga',541,123,838,666)
        panel.__index = class.player_info_panel 

        panel:add_button('',0,0,panel.w,panel.h)
        -- local title_text = panel:add_text('棋子图鉴',0,0,panel.w,100,25,'center')
        -- title_text:set_color(243,246,4,1)

        -- local line = panel:add_texture('image\\提示框\\line.tga',45,90,panel.w - 90,2)
        -- line:set_alpha(0xff*0.6)
        
        panel.hero_img = panel:add_texture('image\\hero.blp',35,25,158,194) 
        local title_background = panel:add_texture('image\\角色信息\\line.tga',213,25,586,22)
        title_background:set_alpha(0xff*0.1)

        local skl = hero and hero:find_skill(hero:get_name()..'天赋') 
        local tip = skl and skl:get_tip() or ''
        local tf_text = '|cffcccccc'.. (hero and hero:get_name()..'天赋' or '')..'|r'
        panel.hero_tf = panel:add_text(tf_text,213,25,586,194,12,'auto_newline')
        panel.hero_tip = panel:add_text(tip,213,55,586,170,10,'auto_newline')
        --属性加背景
        for i=1,7 do 
            local y = 241 + 30*(i*2-1) -30
            local title_background = panel:add_texture('image\\角色信息\\line.tga',35,y,767,30)
            title_background:set_alpha(0xff*0.1)
        end    
        -- panel.close_button = panel:add_button('image\\操作栏\\cross.blp',panel.w - 32-5,5,32,32,true)
        panel.titles = {
            '地图等级',
            '巅峰王者','荣耀王者','最强王者','王者','星耀','钻石','铂金','黄金','白银','青铜',

            '宠物等级','挖宝积分',
            
            '耐瑟龙碎片','Pa碎片','冰龙碎片','小龙女碎片','霸王莲龙锤碎片','梦蝶仙翼碎片','关羽碎片','精灵龙碎片', '奇美拉碎片',

            '勇士徽章',
            '杀猴次数',
            '神奇的五分钟',
        }
        --属性列数
        local col ={
            --x,y,w,h,字体大小，对齐方式
            {35,241,250,30,12,'right'},
            {319,241,106,30,12,'left'},
            {428,241,111,30,12,'right'},
            {577,241,224,30,12,'left'},
        }
        local cre_height = 30
        local base_y = 0
        local ix = 1 
        panel.attrs = {}
        for i=1,#panel.titles do 
            local name = panel.titles[i]
            if not name then break end
            --颜色相关
            local show_name = ''
            if i <=1 then 
                show_name = '|cffF2F200'..name..'|r'
            elseif i<=5 then 
                show_name = '|cffF30101'..name..'|r'
            elseif i<=9 then 
                show_name = '|cff00ABE9'..name..'|r' 
            elseif i<=11 then 
                show_name = '|cff00ff00'..name..'|r'
            elseif i<=13 then 
                show_name = '|cffF2F200'..name..'|r'
            elseif i<=22 then 
                show_name = '|cffFFC100'..name..'|r'
            else
                show_name = '|cffF30101'..name..'|r'
            end        
            local value = 0

            local x1,y1,w1,h1,line_height1,align1 = table.unpack(col[ix])
            local x2,y2,w2,h2,line_height2,align2 = table.unpack(col[ix+1])
            y1 = y1 + (i-1)*cre_height - base_y
            y2 = y2 + (i-1)*cre_height - base_y

            local attr_name = panel:add_text(show_name,x1,y1,w1,h1,line_height1,align1)
            local attr_value = panel:add_text(value,x2,y2,w2,h2,line_height2,align2)
            table.insert(panel.attrs,{attr_name,attr_value}) 
            if i % 13 == 0 then 
                ix = ix + 2
                base_y = cre_height *13
            end 
            
        end 

        panel:hide()

        return panel
    end,

    fresh = function(self)
        local player = ac.player.self
        local hero = ac.player.self.hero
        local peon = ac.player.self.peon
        if not hero then return end
        if not peon then return end

        local skl = hero and hero:find_skill(hero:get_name()..'天赋') 
        if skl then
            local tip = skl and skl:get_tip() or ''
            self.hero_tf:set_text('|cffcccccc'..skl.name..'|r')
            self.hero_tip:set_text(tip)
        end    
        if hero.tab_art then 
            self.hero_img:set_normal_image(hero.tab_art)
        end    

        for i,data in ipairs(self.attrs) do
            local name_text,value_text = table.unpack(data)
            local name = clean_color(name_text:get_text()) --去除颜色代码
            local new_value = 0
            if name =='地图等级' then 
                new_value = player:Map_GetMapLevel()
            elseif name =='宠物等级' then
                new_value = peon.peon_lv
            elseif name =='小龙女碎片' then
                name = '手无寸铁的小龙女碎片' 
                new_value = string.format("%.f",player.cus_server[name] or 0)  
            elseif finds(name,'最强王者','王者','星耀','钻石','铂金','黄金','白银','青铜') then
                new_value = string.format("%.f",player.cus_server[name] or 0)
                new_value = new_value..' 星'
            elseif name =='杀猴次数' then
                name = '杀鸡儆猴' 
                new_value = string.format("%.f",player.cus_server[name] or 0)  
            elseif name =='神奇的五分钟' then
                name = '攻击减甲' 
                new_value = string.format("%.f",player.cus_server[name] or 0)  
            else
                new_value = string.format("%.f",player.cus_server[name] or 0)
            end    
            value_text:set_text(new_value)
        end    

    end,
    set_chess_list = function (self,list)
        for index,unit in ipairs(self.list) do 
            local name = list[index]
            if name then 
                unit:set_name(name)
            else 
                unit:hide()
            end 
        end 
    end,


    on_button_clicked = function (self,button)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    on_button_mouse_enter = function (self,button)
        if button == self.close_button then 
            button:tooltip("关闭","暂时关闭棋子图鉴,按F3可以再次打开",-1,nil,64)
        end 
    end,
    
}

local panel

ac.wait(1000,function ()
    panel = class.player_info_panel.get_instance()
end)
game.loop(2*1000,function() 
    panel:fresh()
end)



local game_event = {}
game_event.on_key_down = function (code)

    if code == KEY.F4 then 
        if panel == nil then return end 
        panel:show()
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 
game_event.on_key_up = function (code)

    if code == KEY.F4 then 
        if panel == nil then return end 
        panel:hide()
    end 
end 

game.register_event(game_event)