local slk = require 'jass.slk'

local new_ui = class.panel:builder
{
    x = 541,--假的
    y = 123,--假的
    w = 838,
    h = 666,
    level = 5,
    is_show = false,
    normal_image = 'image\\提示框\\bj2.tga',

    create = function (self)
        local hero = ac.player.self.hero
        local panel = self
        panel:add_button('',0,0,panel.w,panel.h)
        panel:set_alpha(0.7)
        -- local title_text = panel:add_text('棋子图鉴',0,0,panel.w,100,25,'center')
        -- title_text:set_color(243,246,4,1)

        -- local line = panel:add_texture('image\\提示框\\line.tga',45,90,panel.w - 90,2)
        -- line:set_alpha(0xff*0.6)
        
        panel.hero_img = panel:add_texture('image\\hero.blp',35,25,146,173) 
        local title_background = panel:add_texture('image\\角色信息\\line.tga',213,25,586,22)
        title_background:set_alpha(0xff*0.1)

        local tf_text = '|cffFDC000装备总评分：|r'
        panel:add_text(tf_text,213,25,120,194,12,'auto_newline') 
        panel.item_pf = panel:add_text('0',333,25,100,194,12,'auto_newline')
        panel.item_pf:set_color(0xffFDC000)

        local btn_name = {'武器','衣服','头盔','手套','腰带','鞋子'}
        panel.btn_items = {}
        panel.items = {}
        --存档物品
        for i=1,6 do 
            local x = 213 + 18*(i-1) + 80*(i-1)
            local btn_it = panel:add_button('image\\PASyiji'..i..'.blp',x,85,80,80)
            panel.btn_items[btn_name[i]] = btn_it

            function btn_it:on_button_mouse_enter()  
                local info = panel.items[btn_name[i]]
                if info then 
                    local tip = string.sub(info.tip,1,-106)
                    --尾部扣字
                    self:tooltip(info.title,tip,0,400,84,10)
                end
            end   
        end 

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
            {35,211,250,30,12,'right'},
            {319,211,106,30,12,'left'},
            {428,211,111,30,12,'right'},
            {577,211,224,30,12,'left'},
        }
        local cre_height = 30
        local base_y = 0
        local ix = 1 
        panel.attrs = {}
        for i=1,28 do 
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
            if i % 14 == 0 then 
                ix = ix + 2
                base_y = cre_height *14
            end 
            
        end 

        panel:hide()

        return panel
    end,
    add_save_item = function(self,p,it)
        if not it.type1 then 
            return 
        end 
        local btn = self.btn_items[it.type1] 
        --设置图片
        -- print(it:get_art())
        btn:set_normal_image(it:get_art())
        if it.color == '暗金' then 
            btn:add_frame(38,-42,1.24,{1,1.38,1},true)
        else   
            btn:add_frame(38,-42,1.24,{1,1.38,1})
        end    

        local iit = {}
        iit.title = it.color_name or it.title
        iit.tip = it:get_tip()
        iit.pf = it.pf

        --设置hover tip 
        self.items[it.type1] =iit

        --设置装备总评分
        local all_pf = 0 
        for key,item in pairs(self.items) do 
            all_pf = all_pf + item.pf
        end    
        p.pf = all_pf
        self.item_pf:set_text(('%.f'):format(all_pf))
    end,    
    fresh = function(self)
        local hero = ac.player.self.hero
        if not hero then return end

        if hero.tab_art and not self.img_flag then 
            self.img_flag = true
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
                    if name == '攻击速度' then 
                        new_value = string.format("%.f",hero:get(name)-50)
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

local panel = new_ui:create()
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

local function add_sub_skl(skill)
    local self = skill
    -- print(self,self.name)
    --如果有特性技能
    if self.sub_skl then 
        --调整基本数据
        for key,val in pairs(ac.table.ItemData[self.name]) do 
            local  new_val = val
            if type(val) == 'table' then 
                new_val = table_copy(val)
            end
            self[key] = new_val
        end
        --调整属性数据
        for key,val in sortpairs(self.attr) do 
            if ac.skill[self.sub_skl].attr_mul then 
                self.attr[key] = val * (1 + ac.skill[self.sub_skl].attr_mul/100)
            end
        end
        --调整特性 tip 
        self.sub_skl_tip = ac.skill[self.sub_skl]:get_tip()
        local need_map_level = self.need_map_level - (ac.skill[self.sub_skl].reduce_level or 0)
        self:set('need_map_level',need_map_level)
        -- self:fresh_tip()
        -- print('测试tip：',self.name,need_map_level,ac.skill[self.sub_skl].reduce_level,self.sub_skl_tip,self.sub_skl,ac.skill[self.sub_skl]:get_tip())
    end
end
function ac.unit.__index:add_save_item(it)
    local p = self.owner 
    if type(it) =='string'  then 	
		--不创建特效
		it = ac.item.create_item(it,nil,true)
		it:hide()
        it.recycle = true
        it.owner = self
        --删除物品
        ac.wait(0,function()
            if it.owner then 
                it:item_remove()  
            end    
        end)
    end	
    add_sub_skl(it)
    --地图等级限制
    if p:Map_GetMapLevel() < it.need_map_level then 
        p:sendMsg('|cffebb608【系统】|cffff0000地图等级不够,装备属性不生效',5)
    end  

    if not p.save_item_list then 
        p.save_item_list = {}
    end  
    --该部位已经装备则先减少属性，再填添加给英雄
    local old_item = p.save_item_list[it.type1]
    if old_item then 
        --减属性
        if p:Map_GetMapLevel() >= old_item.need_map_level  then
            for key,val in sortpairs(old_item.attr) do 
                -- print('减属性',key,-val)
                p.hero:add(key,-val)
            end
        end    
        --移除技能
        if old_item.sub_skl then 
            p.hero:remove_skill(old_item.sub_skl)
        end 
        --等待0秒后给物品
        ac.wait(0,function()
            self:add_item(old_item.name)
        end)
    end    
    p.save_item_list[it.type1] = it
    if it.sub_skl then 
        --添加技能
        p.hero:add_skill(it.sub_skl,'隐藏')
    end

    --增加属性
    if it.attr and p:Map_GetMapLevel() >= it.need_map_level then 
        for key,val in sortpairs(it.attr) do 
            -- print('加属性',key,-val)
            p.hero:add(key,val)
        end
    end     
    --刷新到ui 显示和界面。
    if p:is_self() then 
        panel:add_save_item(p,it)
    end  
    --保存到网易服务器
    local key = ac.server.name2key('存档'..it.type1)
    p:Map_SaveServerValue(key,it.s_id) 

    p:sendMsg('|cffebb608【系统】|cff00ff00穿戴成功，可按TAB进行查看效果',5)
    return it
end 
--统一增加所有的存档物品方法
ac.wait(100,function()
    local save_item ={}
    local all_save_item ={}
    for name,data in pairs(ac.table.ItemData) do 
        local color = data.color 
        if color and data.category == '存档' then 
            if not save_item[data.lv] then 
                save_item[data.lv] = {}
            end    
            if not save_item[data.lv][color] then 
                save_item[data.lv][color]  = {}
            end
            table.insert(save_item[data.lv][color],name)

            if all_save_item[tonumber(data.s_id)] then 
                print('重复存档物品id',data.s_id,data.name)
            else    
                all_save_item[tonumber(data.s_id)] = name
            end    
            
        end    
    end 
    --排序
    for lv,data in pairs(save_item) do 
        for color,list in pairs(data) do 
            table.sort(list,function (a,b)
                return a < b
            end)
        end    
    end 
    ac.save_item = save_item
    ac.all_save_item = all_save_item
    -- for i=#all_save_item,1,-1 do
    --     local name = all_save_item[i]
    --     if finds(name,'血骷髅') then 
    --         print(i,name)
    --     end

    -- end
    -- print_r(all_save_item)
    for i=1,table.maxnum(all_save_item) do 
        local name = all_save_item[i]
        if name then 
            local mt = ac.skill[name]
            mt{
                item_type_tip = '', 
                content_tip = '',
                skill_type = '存档物品',
                tip = ac.table.ItemData[name].tip,
                art = ac.table.ItemData[name].art,
                color_name = '|cff'..ac.color_code[ac.table.ItemData[name].color or '白']..ac.table.ItemData[name].title..'|r',
                need_map_level = ac.table.ItemData[name].need_map_level,
                sub_skl = ac.table.ItemData[name].sub_skl,
                map_level_tip = function(self)
                    local level_tip = ac.table.ItemData[name].need_map_level
                    -- if ac.table.ItemData[name].reduce_level then 
                    --     level_tip = level_tip ..'(-'..ac.table.ItemData[name].reduce_level..')'
                    -- end
                    if not self.owner then 
                        return '|cffffe799需求地图等级: |cff'..ac.color_code['绿']..''..level_tip .. '|r'
                    end  

                    local p=self.owner.owner 
                    if p:Map_GetMapLevel() >= level_tip then
                    -- local color  =  p:Map_GetMapLevel() > level_tip and '绿' or '红'
                        return '|cffffe799需求地图等级: |cff'..ac.color_code['绿']..''..level_tip .. '|r'
                    else 
                        return '|cff'..ac.color_code['红']..'需求地图等级: '..level_tip .. '|r|cffffff00（可提前穿戴保存）|r'
                    end
                end
            }
            --添加特性相关的 属性
            add_sub_skl(ac.skill[name])

            function mt:on_cast_start()
                local hero = self.owner 
                local p = self.owner 
                -- print(self.attr)
                local ok = hero:add_save_item(self)
                -- if not ok then 
                --     return true
                -- end    
            end  
        end
    end     
    
    
    --处理存档物品
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then   
            player:event '玩家-注册英雄' (function(_,p,hero)
                for i,data in ipairs(ac.cus_server_key) do 
                    if finds(data[2] ,'存档') then 
                        local name = player.cus_server[data[2]] and ac.all_save_item[player.cus_server[data[2]]]
                        print(data[2],name,player.cus_server[data[2]])
                        if name then
                            hero:add_save_item(name)
                        end    
                    end    
                end
            end)
        end
    end
end)

