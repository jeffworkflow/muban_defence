local player = require 'ac.player'
local hero = require 'types.hero'
local ranking = require 'ui.client.ranking'


--已刷新的BOSS数量
ac.boss_count = 0

--初始化一下玩家的变量名
for i=1,10 do
    local player = ac.player[i]
    --杀敌数
    player.total_kill_count = 0
    player.kill_count = 0
    --死亡数
    player.death = 0
    --金币数
    player.gold_count = 0
    --承受伤害
    player.take_damage_count = 0
    --造成伤害
    player.damage_count = 0
    --参团率
    player.ctl = 0
    --熟练度
    player.sld = ''
    --kda
    player.kda = 0
    player.boshu = player.boshu or 0
    --段位为1-7 青铜 白银 黄金 白金 钻石 大师 王者
    if player.boshu <= 10 then
        player.rank = 1
    elseif player.boshu <=20 then
        player.rank = 2
    elseif player.boshu <=30 then
        player.rank = 3
    elseif player.boshu <=40 then
        player.rank = 4
    elseif player.boshu <=50 then
        player.rank = 5
    elseif player.boshu <=70 then
        player.rank = 6
    elseif player.boshu <= 100 then
        player.rank = 7
    elseif player.boshu >= 101 then
        player.rank = 8
    end
end


--数值转换
local function bignum2string(value)
    if value < 10000 then
        return ('%.0f'):format(value)
    elseif value < 100000000 then
        return ('%.1f'):format(value/10000)..'万'
    else
        return ('%.1f'):format(value/100000000)..'亿'
    end
end
ac.bignum2string = bignum2string

--段位贴图
local rank_art = {
    'image\\排行榜\\qt.tga',
    'image\\排行榜\\by.tga',
    'image\\排行榜\\hj.tga',
    'image\\排行榜\\bj.tga',
    'image\\排行榜\\zs.tga',
    'image\\排行榜\\ds.tga',
    'image\\排行榜\\wz.tga',
}

local rank_art = {'黑铁','黄铜','白银','黄金','铂金','钻石','大师','王者'}
ac.player_list = get_player_list()
--计算KDA
local function get_kda()
    --杀敌数
    local total_kill_count = 0
    --金币
    local gold_count = 0
    --承受伤害
    local take_damage_count = 0
    --造成伤害
    local damage_count = 0
    --死亡数
    local death = 0

    --计算出总值
    for i=1,10 do
        local p = ac.player[i]
        total_kill_count = total_kill_count + p.total_kill_count
        gold_count = gold_count + p.gold_count
        take_damage_count = take_damage_count + p.take_damage_count
        damage_count = damage_count + p.damage_count
        death = death + p.death
    end

    local t = {}
    local list = ac.player_list
    for i,p in ipairs(list) do
        local a = 0
        local b = 0
        local c = 0
        local d = 0
        local e = 0
        local f = 0
        if total_kill_count > 0 then
            a = p.total_kill_count / total_kill_count * 20
        end

        if gold_count > 0 then
            b = p.gold_count / gold_count * 10
        end

        if take_damage_count > 0 then
            c = p.take_damage_count / take_damage_count * 20
        end

        if damage_count > 0 then
            d = p.damage_count / damage_count * 30
        end

        if ac.boss_count > 0 then
            e = p.ctl / ac.boss_count * 10
        end

        if death > 0 then
            f = p.death / death * 10
        end

        p.kda = a+b+c+d+e-f
        table.insert(t,{id = p:get(),kda = p.kda})
    end

    --排序
    table.sort(t,function(a,b) return a.kda>b.kda end)

    for i = 1, #t do
        local id = t[i].id
        local p = ac.player[id]
        --玩家名
        local p_name = p:get_name()..(p.is_show_nickname  or '' )..' '
        ranking.ui.player[i]:set_text(p_name)
        --段位
        ranking.ui.rank[i]:set_text(rank_art[p.rank])
        --ranking.ui.rank[i]:set_normal_image(rank_art[p.rank])
        --熟练度
        ranking.ui.sld[i]:set_text(p.sld)
        --杀敌数
        ranking.ui.kill_count[i]:set_text(p.total_kill_count)
        --死亡数
        ranking.ui.death_count[i]:set_text(p.death)
        --获得金币
        ranking.ui.gold_count[i]:set_text(bignum2string(p.gold_count))
        --累计伤害
        ranking.ui.damage_count[i]:set_text(bignum2string(p.damage_count))
        --魔兽自带多面板统计
        ac.game.multiboard.damage_init(p,bignum2string(p.damage_count))
        --受到伤害
        ranking.ui.take_damage[i]:set_text(bignum2string(p.take_damage_count))
        --kda
        ranking.ui.kda[i]:set_text(bignum2string(p.kda))
        if p:is_self() then
            local y = (i-1) * 40 + 37
            ranking.ui.lk:set_position(20,y)
            ranking.ui.lk:show()
        end

    end
end

ac.game:event '单位-创建' (function(_,unit)
    local data = ac.table.UnitData[unit:get_name()]
    if not data then 
        return
    end    
    if data.type == 'boss' then
        ac.boss_count = ac.boss_count + 1

        unit:event '受到伤害效果' (function (_,damage)
            local hero = damage.source
            local player = hero:get_owner()
            if not unit.damage_source_mark then 
                unit.damage_source_mark ={}
            end    
            --每个boss 记录下是否被玩家打过。打过记录数+1.下次不在增加
            if not unit.damage_source_mark[player] then 
                unit.damage_source_mark[player] = true
                player.ctl = player.ctl + 1
            end    

        end)
    end
end)

ac.game:event '游戏-开始' (function()
    
    local list = {}
    for hero,_ in pairs(ac.hero.all_heros) do
        table.insert(list,hero)
    end 
    table.sort(list,function (a,b)
        return a:get_name() < b:get_name()
    end)
    --注册事件
    for _,hero in ipairs(list) do
        local p = hero:get_owner()
        if not p:is_player() then 
            return
        end    
        hero:event '单位-死亡'(function()
            p.death = p.death + 1
        end)

        ac.game:event '造成伤害结束'(function(_,self)
            local hero = self.source
            local p = hero:get_owner()
            local hero = p.hero
            if not p:is_player() then return end
            --总伤害
            p.damage_count = p.damage_count + self.current_damage

            --记录每波伤害
            if not p.each_index_damage then 
                p.each_index_damage={}
            end  
            local index = 1
            if ac.creep['刷怪1'].index>=1 then
                index = ac.creep['刷怪1'].index 
            end	
            if not p.each_index_damage[index] then 
                p.each_index_damage[index] =0
            end    
            p.each_index_damage[index] = p.each_index_damage[index] + self.current_damage

        end)

        hero:event '受到伤害结束'(function(_,self)
            p.take_damage_count = p.take_damage_count + self.damage
            if hero:get '生命' / hero:get '生命上限' < 0.12 then
                local fl = hero:get_owner():cinematic_filter
                {   
                    file = 'xueliangguodi.blp',
                    start = {100, 100, 100, 100},
                    finish = {100, 100, 100, 0},
                    time = 5,
                }
            end
        end)
        p:event '玩家-即将获得金钱'(function(_,data)
            local p = data.player
            local gold = data.gold
            p.gold_count = p.gold_count + gold
        end)
        
    end
    
    ac.game:event '单位-杀死单位'(function(trg, killer, target)
        local hero = killer
        local p = killer:get_owner()
        local hero = p.hero
        if not p:is_player() then return end
        --使用杀敌数后，减少杀敌数
        p.kill_count = p.kill_count + 1
        --统计用，使用杀敌数后，不减少
        p.total_kill_count = p.total_kill_count + 1
        local jf_mul = 0.5
        -- if ac.creep['刷怪-无尽'].index and ac.creep['刷怪-无尽'].index >=1 then
        --     jf_mul = 1
        -- end    
        p.putong_jifen = (p.putong_jifen or 0) + jf_mul
        ac.total_putong_jifen = (ac.total_putong_jifen or 0) + jf_mul
        --魔兽自带的多面板统计
        ac.game.multiboard.player_kill_count(p,p.kill_count) 
    end)

    --刷新排行榜信息
    ac.loop(2000,function()
        get_kda()
    end)
end)    


--游戏时间 2个小时
local shijian = 1*60*60
-- local shijian = 1*60 --测试
ac.g_game_time = shijian 
local total_time = shijian 

local ti = ac.loop(1000,function(t)
    --modify by jeff 
    total_time = total_time - 1
    local str = os.date("!%H:%M:%S", total_time)
    ranking.ui.date:set_text('游戏剩余时间:'..str)
    ac.game.multiboard.set_time(str)

    if total_time == 0  then
        ac.game:event_notify('游戏-结束','游戏胜利')
        t:remove()
    end

end)

local kzt = require 'ui.client.kzt'
ac.game:event '游戏-回合开始'(function(_,index,creep)
    if not finds(creep.name,'刷怪','刷怪-无尽') then
        return 
    end
    local tip =''
    -- if creep.name == '刷怪-无尽' then 
    --     tip = '(无尽)'
    -- end    
    local degree 
    if ac.g_game_degree == 1 then 
        degree = '普通'
    elseif ac.g_game_degree == 2 then 
        degree = '噩梦'
    elseif ac.g_game_degree == 3 then  
        degree = '地狱'
    else 
        degree = '圣人'
    end    
    local name 
    if ac.g_game_mode == 1 then 
        name = '标准'..tip
    else 
        name = '嘉年华'..tip
    end 
    print('回合开始6')              
    ranking.ui.two_title:set_text(name..'-第'..index..'波('..degree..')')
end)

ac.game:event '游戏-结束' (function(trg,flag)
	ac.wait(2*1000,function()
		c_ui.ranking.ui:show()
        -- if flag then
        --     ranking.ui.title:set_text('排行榜-游戏胜利')
        -- else
        --     ranking.ui.title:set_text('排行榜-游戏失败')
        -- end        
	end);
end)	
--魔兽自带的多面板 暂时有问题

