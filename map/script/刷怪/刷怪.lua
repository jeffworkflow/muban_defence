-- 顺序： 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
-- 规则：
-- 3分钟一波，25波=75分钟，10分钟可以减3分钟，一局最多75+21=96分钟
-- 每5波一只挑战boss，额外出。
-- ac.special_boss = {
-- '挑战怪10','挑战怪20','挑战怪30','挑战怪40','挑战怪50','挑战怪60','挑战怪70','挑战怪80','挑战怪90','挑战怪100'
-- }
ac.attack_unit = {
    '民兵','甲虫','镰刀手','剪刀手','狗头人','步兵','长牙兽','骷髅战士','巨魔','食人鬼战士','骑士',
    '牛头人','混沌骑士','屠夫','德鲁伊','娜迦暴徒','龙卵领主','潮汐','血恶魔','火凤凰','九头怪','黑龙',
    '蜥蜴领主','地狱火','末日'
}
ac.attack_boss = {
    '肉山','梦魇','戈登的激情','焰皇','毁灭者'
}  
local force_cool = 3*60
if global_test then 
    force_cool = 180
end    
local skill_list = ac.skill_list
for i =1,3 do 
    local mt = ac.creep['刷怪'..i]{    
        region = 'cg'..i,
        creeps_datas = '',
        force_cool = force_cool,
        max_index = 25,
        creep_player = ac.player.com[2],
        create_unit_cool = 0.5,
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
        local rect = require 'types.rect'
        if i == 1 then 
            self.timer_ex_title ='距离 第'..(self.index+2)..'波 怪物进攻'
         end   
    end

    function mt:on_next()
        if i == 1 then 
           self.timer_ex_title ='距离 第'..(self.index+2)..'波 怪物进攻'
        end   
        --进攻提示
        if self.name =='刷怪1' then
            local panel = class.screen_animation.get_instance()
            if panel then panel:up_jingong_title(' 第 '..self.index..' 波 ') end
        end    
        --小地图ping
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        -- if ac.ui then ac.ui.kzt.up_jingong_title(' 第 '..self.index..' 波 ') end

        ac.player.self:sendMsg("|cffff0000 第"..self.index.."波 怪物开始进攻！！！|r",5)
        local index = self.index
        self.creeps_datas = ac.attack_unit[index]..'*20'
        self:set_creeps_datas()

    end

    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(1000)
        local point = ac.map.rects['主城']:get_point()
        unit:issue_order('attack',point)

    end
    --每3秒刷新一次攻击目标 原地不动才发起攻击
    function mt:attack_hero() 
        self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
            -- print('野怪区的怪数量',#mt.group)
            local point = ac.map.rects['主城']:get_point()
            for _, unit in ipairs(self.group) do
                if unit:is_alive() then 
                    if unit.last_point then 
                        local distance =  unit.last_point * unit:get_point()
                        local hero = ac.find_hero(unit)
                        local hero_distance = 0
                        if hero then 
                            hero_distance = hero:get_point() * unit:get_point()
                        end    
                        if hero_distance <= 10 then
                            --1500码内，优先攻击英雄，英雄死亡则攻向基地点
                            unit:issue_order('attack',point)
                        elseif hero_distance <= 1500  then
                            unit:issue_order('attack',hero)
                        else    
                            unit:issue_order('attack',point)
                        end      
                    end  
                    unit.last_point = unit:get_point()
                end   
            end 
        end) 
        self.attack_hero_timer:on_timer()
    end    

    --刷怪结束
    function mt:on_finish()  
        if self.key_unit_trg then 
            self.key_unit_trg:remove()
        end    
        if self.mode_timer then 
            self.mode_timer:remove()
        end    
        if self.attack_hero_timer then 
            self.attack_hero_timer:remove()
        end  
        -- ac.game:event_dispatch('游戏-最终boss',self.index,self)
    end   
end    
--注册boss进攻事件
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪1' then
        return
    end    
    --取余数,为0 得给物品
    local value = ac.creep['刷怪1'].index % 5
    local ix = math.ceil(ac.creep['刷怪1'].index / 5)
    if value == 0 then 
        local point = ac.map.rects['进攻点']:get_point()
        --最后一波时，发布最终波数
        if ix == #ac.attack_boss then
            ac.game:event_dispatch('游戏-最终boss')
        else
            local boss = ac.player.com[2]:create_unit(ac.attack_boss[ix],point)
            -- table.insert(ac.creep['刷怪1'].group,boss)
            boss:add_buff '攻击英雄' {}
            boss:add_skill('无敌','英雄')
            boss:add_skill('撕裂大地','英雄')

            boss:add('免伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
            boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
            
        end    

    end    
end)    



-- 注册难度事件

-- 注册英雄杀怪得奖励事件
ac.game:event '单位-死亡' (function(_,unit,killer) 
    if killer.category =='进攻怪' or killer.category =='boss' or unit == killer then
		return
    end

    local player = killer:get_owner()
    local gold 
    local exp =0 
    local wood  =0
    local fire_seed =0
    
    -- 英雄的召唤物 打死的怪，也给英雄加钱加经验
    -- 英雄召唤物享有 英雄的金币、经验加成
    if player  then 
        killer = player.hero
    end   
    -- 进攻怪杀死单位，不用加钱和经验
    if not killer or not killer:is_hero()  then  
        return
    end    
    -- print(unit,)
    --加钱
    if unit.gold  then 
        gold = unit.gold * ( 1 + killer:get('金币加成')/100)
    end   
    --加经验,
    if unit.exp  then
        exp = unit.exp * ( 1 + killer:get('经验加成')/100)
    end  
    --加木头 加火灵
    if unit.wood then 
        wood = unit.wood * ( 1 + killer:get('木头加成')/100)
    end    
    if unit.fire_seed then 
        fire_seed = unit.fire_seed * ( 1 + killer:get('火灵加成')/100)
    end   
    --杀敌数加成
    local kill_cnt = 1 + killer:get('杀敌数加成')/100 + killer:get('额外杀敌数')

    local source = killer
    local target = unit
    --自己加经验
    if source:is_alive() and source:is_hero() then 
        source:addXp(exp)
    end	
    --加资源
    player:addGold(gold,unit)
    player:add_wood(wood,unit)
    player:add_fire_seed(fire_seed,unit)
    player:add_kill_count(kill_cnt)
    

end);

--进入游戏后3秒开始刷怪
ac.wait(20,function()
    --1选择难度 2选择英雄 3游戏开始
    --全部英雄选完才会进入游戏开始.主机在选难度，所以不会有事。
    ac.choose_degree = choose_degree
    local function choose_degree()
        local p = ac.player.self
		local minx, miny, maxx, maxy = ac.map.rects['选人区域']:get()
		p:setCameraBounds(minx+900, miny+900, maxx-900, maxy-900)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
		p:setCamera(ac.map.rects['选人区域'])
		--禁止框选
        p:disableDragSelect()

        local function create_choose_dialog()
            local player = get_first_player()
            local list = {
                { name = "普通模式" },
                { name = "修罗模式(无尽)" },
                { name = "斗破苍穹(无尽)" },
                { name = "无上之境(无尽)" },
                { name = "无限乱斗(快速)" },
                { name = "深渊乱斗(快速)" },
                { name = "武林大会(可PK)" },
            }
            local list2 = {
                { name = "青铜" },
                { name = "白银" },
                { name = "黄金" },
                { name = "铂金" },
                { name = "钻石" },
                { name = "星耀" },
                { name = "王者" },
                { name = "最强王者" },
                { name = "荣耀王者" },
                { name = "巅峰王者" },
            }
            ac.g_game_degree_list = {} 
            for i = #list ,1 ,-1 do 
                -- print(list[i].name)
                local name = list[i].name
                if finds(name,'修罗模式') then 
                    name = "修罗模式"
                end    
                if finds(name,'可PK') then 
                    name = "武林大会"
                end    
                if finds(name,'斗破苍穹') then 
                    name = "斗破苍穹"
                end 
                if finds(name,'无上之境') then 
                    name = "无上之境"
                end 
                if finds(name,'无限乱斗') then 
                    name = "无限乱斗"
                end 
                if finds(name,'深渊乱斗') then 
                    name = "深渊乱斗"
                end
                if not finds(name,'普通模式','武林大会','无限乱斗','深渊乱斗') then 
                    table.insert(ac.g_game_degree_list,name)
                end    
            end  
            for i = #list2 ,1 ,-1 do 
                local name = list2[i].name  
                table.insert(ac.g_game_degree_list,name)
            end     
            
            ac.player.self:sendMsg("正在选择 |cffffff00难度|r")
            if player then 
                ac.flag_choose_dialog = create_dialog(player,"选择难度",list,function (index)  
                    -- print(index)
                    ac.flag_choose_dialog = false
                    if index == 2 then 
                        ac.g_game_degree = 11
                        ac.g_game_degree_attr = 11  
                        ac.g_game_degree_name = "修罗模式"
                    elseif index == 3 then 
                        ac.g_game_degree = 12
                        ac.g_game_degree_attr = 12  
                        ac.g_game_degree_name = "斗破苍穹"
                    elseif index == 4 then 
                        ac.g_game_degree = 13
                        ac.g_game_degree_attr = 13 
                        ac.g_game_degree_name = "无上之境"  
                    elseif index == 5 then 
                        ac.g_game_degree = 14
                        ac.g_game_degree_attr = 14  
                        ac.g_game_degree_name = "无限乱斗"  
                    elseif index == 6 then 
                        ac.g_game_degree = 15
                        ac.g_game_degree_attr = 15  
                        ac.g_game_degree_name = "深渊乱斗"  
                    elseif index == 7 then 
                        ac.g_game_degree = 16
                        ac.g_game_degree_attr = 2  
                        ac.g_game_degree_name = "武林大会"  
                    end    

                    ac.player.self:sendMsg("选择了 |cffffff00"..list[index].name.."|r")
                    if index == 1 then
                        --进入普通模式的选择
                        create_dialog(player,"选择难度",list2,function (index)  
                            ac.g_game_degree = index
                            ac.g_game_degree_attr = index
                            ac.g_game_degree_name = list2[index].name  
                            --创建预设英雄
                            ac.choose_hero()
                            --游戏-开始
                            ac.wait(30*1000,function()
                                ac.game:event_notify('游戏-开始')
                            end)
                            ac.player.self:sendMsg("选择了 |cffffff00"..list2[index].name.."|r")
                            ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree)
                        end)
                    elseif  index < #list  then 
                        --创建预设英雄
                        ac.choose_hero()
                        --游戏-开始
                        ac.wait(30*1000,function()
                            ac.game:event_notify('游戏-开始')
                        end)
                        ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree)
                    else
                        --发起投票
                        ac.game.start_vote()
                        ac.game:event '投票结束'(function(_,flag)
                            --创建预设英雄
                            ac.choose_hero()
                            --游戏-开始
                            ac.wait(30*1000,function()
                                ac.game:event_notify('游戏-开始')
                            end)
                            ac.game:event_notify('选择难度',ac.g_game_degree_name,ac.g_game_degree)
                        end)
                    end    
                end)

            end 
        end  
        create_choose_dialog()  

        --每3秒提醒玩家主机在选择难度
        ac.loop(3*1000,function(t)
            if ac.g_game_degree then 
                t:remove()
            else
                -- if not ac.flag_choose_dialog then 
                --     create_choose_dialog()  
                -- end    
                ac.player.self:sendMsg("等待主机选择模式、难度")
            end
        end)
    end    
    choose_degree()
    ac.game:event '游戏-开始' (function()
        --游戏开始后 刷怪时间
        local time = 180
        if global_test then 
            time = 180
        end    
        time = force_cool
        BJDebugMsg(time .. "秒后开始第一波怪物进攻",10)
        ac.timer_ex 
        {
            time = time,
            title = "距离第一波怪物进攻",
            func = function ()
                ac.game:event_notify('游戏-开始刷兵')
            end,
        }
    end)

    ac.game:event '游戏-开始刷兵' (function ()
        --开始刷怪
        print('开始刷兵啦')
        for i=1 ,3 do 
            local creep = ac.creep['刷怪'..i] 
            creep:start()
            creep:attack_hero() 
        end    
    end)    
   
end);
