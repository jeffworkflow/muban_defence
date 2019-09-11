local slk = require 'jass.slk'

class.hero_info_panel = extends(class.panel){
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\提示框\\BJ.tga',541,123,838,666)
        panel.__index = class.hero_info_panel 

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
            '移动速度','攻击间隔','攻击速度','攻击减甲','减少周围护甲',

            '分裂伤害','吸血','多重射','对BOSS额外伤害',
            '免伤','闪避','免伤几率','每秒回血',
            

            '全伤加深','暴击几率','暴击加深','技暴几率','技暴加深','会心几率','会心伤害','物理伤害加深','技能伤害加深',
            '木头加成','杀敌数加成','火灵加成','物品获取率',
        }
        panel.titles2 = {
            '杀怪加攻击','杀怪加全属性','杀怪加力量','杀怪加敏捷','杀怪加智力',
            '攻击加全属性','攻击加力量','攻击加敏捷','攻击加智力',
            '每秒加全属性','每秒加力量','每秒加敏捷','每秒加智力','每秒加攻击',
            '每秒加金币','每秒加木头','每秒加火灵','每秒加护甲','额外杀敌数',
            
            '攻击距离',
            '技能冷却','触发概率加成',
            
            
        }
        panel.page = 1 
        local next_button = panel:add_button('image\\right.blp',773,371,64,64)
        function next_button:on_button_clicked()
            if panel.page == 1  then 
                panel.page = 2
                self:set_normal_image('image\\left.blp')
            else
                panel.page = 1
                self:set_normal_image('image\\right.blp')
            end    
            panel:fresh()
        end    
        --right.blp
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
        for i=1,26 do 
            local name = panel.titles[i]
            if not name then break end
            --颜色相关   
            local value = 0
            if hero then
                value = hero:get(name)
            end 

            local x1,y1,w1,h1,line_height1,align1 = table.unpack(col[ix])
            local x2,y2,w2,h2,line_height2,align2 = table.unpack(col[ix+1])
            y1 = y1 + (i-1)*cre_height - base_y
            y2 = y2 + (i-1)*cre_height - base_y

            local attr_name = panel:add_text(name,x1,y1,w1,h1,line_height1,align1)
            if i <=5 then 
                attr_name:set_color(0xffF2F200)
            elseif i<=9 then 
                attr_name:set_color(0xff00ABE9)
            elseif i<=13 then 
                attr_name:set_color(0xff00B04F)
            elseif i<=18 then 
                attr_name:set_color(0xffF30101)
            elseif i<=22 then 
                attr_name:set_color(0xffFFC100)
            else
                attr_name:set_color(0xffF2F200)
            end   
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
        local hero = ac.player.self.hero
        if not hero then return end

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
            local name

            local function set_all(name)
                if name then 
                    local new_value = string.format("%.f",hero:get(name))
                    if name == '攻击间隔' then 
                        new_value = string.format("%.2f",hero:get(name))
                    end    
                    new_value = bignum2string(new_value)
                    if not finds(ac.base_attr,name) then 
                        new_value = new_value..'%'
                    end    
                    name_text:set_text(name) 
                    value_text:set_text(new_value)
                else 
                    name_text:set_text('')  
                    value_text:set_text('')
                end    
            end    
            if self.page == 1 then 
                name = self.titles[i] 
            else
                name = self.titles2[i] 
            end    
            set_all(name)
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
    panel = class.hero_info_panel.get_instance()
end)
game.loop(2*1000,function() 
    panel:fresh()
end)



local game_event = {}
game_event.on_key_down = function (code)

    if code == KEY.TAB then 
        if panel == nil then return end 
        panel:show()
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 
game_event.on_key_up = function (code)

    if code == KEY.TAB then 
        if panel == nil then return end 
        panel:hide()
    end 
end 

game.register_event(game_event)