-- 顺序： 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
-- 规则：
-- 每回合刷 40 人口的怪物
-- 喽喽占 1个人口，小怪占 2个人口，头目占4人口，boss占20人口
-- 小怪、头目、boss属性是喽喽的多倍
-- 每个回合刷的 同怪物类型 的怪物都是同样。
-- 两个模式，标准和嘉年华，各自有3个难度 普通 噩梦 地狱 难度不同， 怪属性增强倍数不同
-- 标准模式就常规模式，嘉年华为 无限生怪，打完直接进入下一波，钥匙怪也会出来。
-- 根据玩家数 提高怪的总人口
--金币怪奖励
--造成X伤害获得1金币
local gold_unit_award = {
    [5] = {1000,250,20000},
    [15] = {3000,500,20000},
    [25] = {10000,1000,20000},
    [35] = {30000,1500,20000},
    [45] = {100000,2000,20000},
    [55] = {300000,2500,20000},
    [65] = {39000,1750,20000},
    [75] = {100000,2000,20000},
    [85] = {200000,2250,20000},
    [95] = {400000,2500,20000},
}
ac.special_boss = {
'挑战怪10','挑战怪20','挑战怪30','挑战怪40','挑战怪50','挑战怪60','挑战怪70','挑战怪80','挑战怪90','挑战怪100'
}

local skill_list = ac.skill_list

local all_units = {}
local all_food = 40 --总人口
ac.all_food = all_food
for k,v in pairs(ac.table.UnitData) do
    if v.type then 
        if finds(v.type,'喽喽','小怪','头目','boss') then
            if not all_units[v.type] then 
                all_units[v.type] = {}
            end
            --排除，以免刷到最终boss怪
            if not finds(k,'最终boss','挑战','金币','伏地魔','迷路的坦克') then
                table.insert(all_units[v.type],k)    
            end    
        end    
    end    
end    

for k,list in pairs(all_units) do 
    table.sort(list,function (a,b)
        return a < b 
    end)
end 

ac.all_units = all_units

local mt = ac.creep['刷怪']{    
    region = '',
    creeps_datas = '',
    max_index = 60,
    is_random = true,
    creep_player = ac.player.com[2],
    tip =""

}

--进攻怪刷新时的初始化
function mt:on_start()
    local rect = require 'types.rect'
    local region = ac.map.rects['刷怪']
    self.region = region
    self.all_units = all_units
    -- 刷怪初始化 难度、玩家影响
    if ac.g_game_degree == 1 then 
        ac.g_game_degree_attr = 1  --难度一 属性倍数1倍
    end    
    if ac.g_game_degree == 2 then 
        ac.g_game_degree_attr = 2  --难度二 属性倍数2倍
    end  
    if ac.g_game_degree == 3 then 
        ac.g_game_degree_attr = 3  --难度三 属性倍数3倍
    end  
    if ac.g_game_degree == 4 then 
        ac.g_game_degree_attr = 5  --难度三 属性倍数3倍
    end  
    --特殊回合处理。
    self.gold_index = 5
    self.challenge_index = 10
end

--查找当前波野怪数据是否已经有此类型的怪
-- 类型或是名字都可查找
function mt:has_unit(str)
    -- print('打印当前野怪',self.current_creep)
    local u
    for k,v in sortpairs(self.current_creep) do
        if v.type == str or v.name == str then 
            u = v
            break
        end    
    end   
    return u 
end   
--从野怪类型获取1-2种类型
function mt:get_temp_type()
    local type = {'喽喽','小怪','头目','boss'}
    local int = math.random(1,2)
    local temp_type ={}
    for i=1,int do 
        local random_ty  
        if i < 2  then 
            random_ty = type[math.random(1,#type)]
        else
            --如果时随机到两种怪，第二种怪不允许是boss
            random_ty = type[math.random(1,3)]
        end    
        table.insert(temp_type,random_ty) 
    end   
    return temp_type
end 
--随机生成野怪数据
function mt:random_creeps_datas(temp_type)

    local rand_type = temp_type[math.random(1,#temp_type)]

    local rand_name
    local u = self:has_unit(rand_type)
    if u then 
        rand_name = u.name
    else    
        rand_name = self.all_units[rand_type][math.random(1,#self.all_units[rand_type])]
    end    
    -- print(rand_name)
    -- print(rand_name,ac.table.UnitData[rand_name].food)
    self.used_food = self.used_food  + (ac.table.UnitData[rand_name].food or 20) --避免忘了排除特殊boss导致刷怪失败

    if self.used_food <= self.all_food then 
        local u = self:has_unit(rand_type)
        if u then
            -- print(rand_name,rand_type,self.current_creep[rand_name])
            -- print(self.current_creep[rand_name]['cnt'])
            self.current_creep[rand_name]['cnt'] = self.current_creep[rand_name]['cnt'] +1
        else 
            --保存当前生成的数据
            for k,v in sortpairs(ac.table.UnitData[rand_name]) do
                if not self.current_creep[rand_name]  then 
                    self.current_creep[rand_name] = {}
                end 
                self.current_creep[rand_name][k]=v 
                self.current_creep[rand_name]['name'] =  rand_name
                self.current_creep[rand_name]['cnt'] =  1
            end    
        end

        if self.used_food == self.all_food then 
            local result = ''
            for k,v in sortpairs(self.current_creep) do
                result = result ..v.name..'*'..tostring(v.cnt)..' '
            end   
            -- print('函数内的返回结果',result)
            -- 没搞懂return 外面没接收到值
            self.creeps_datas = result
            return result
        end    

        self:random_creeps_datas(temp_type)

    else
        self.used_food = self.used_food - ac.table.UnitData[rand_name].food 
        print('已经超出人口，需要重新筛选',self.used_food)
        self:random_creeps_datas(temp_type)
    end       

end

--每回合开始 从 ac.skill_list 随机取0-2个野怪技能
function mt:get_creep_skill()

    local rand_skill_cnt = math.random(0,2)
    local rand_skill_list = {}
    if rand_skill_cnt == 0 then 
        return 
    end  
    for i = 1,rand_skill_cnt do  
        local rand_skill_name = ac.skill_list[math.random(#ac.skill_list)]
        -- 嘉年华模式 排除掉光环怪
        if ac.skill[rand_skill_name].is_aura and ac.g_game_mode == 2 then 
        else    
            table.insert(rand_skill_list,rand_skill_name)
        end    
    end    
    return rand_skill_list

end

--每回合开始 从 ac.skill_list3 随机取1-2个野怪技能
function mt:get_boss_skill()
    local boss_skill_list = ''
    local rand_skill_cnt = math.random(1,3)
    local rand_skill_list = {}
    if rand_skill_cnt == 0 then 
        return 
    end  
    for i = 1,rand_skill_cnt do  
        local rand_skill_name = ac.skill_list3[math.random(#ac.skill_list3)]
        boss_skill_list = boss_skill_list ..rand_skill_name ..' '
        table.insert(rand_skill_list,rand_skill_name)
    end    
    print('boss 技能：',boss_skill_list)
    return rand_skill_list

end

function mt:add_boss_skill(tab,unit)
    if not tab or #tab == 0 then 
        return 
    end    
    local prtin_str =''
    for i = 1,#tab do  
        local skill_name = tab[i]
        local skill = ac.skill[skill_name]

        if not unit:find_skill(skill_name) then 
            unit:add_skill(skill_name,'英雄')    
        end    
    end
end
--给野怪添加技能 
--技能列表
--野怪单位
function mt:add_creep_skill(tab,unit)
    if not tab or #tab == 0 then 
        return 
    end    
    local prtin_str =''
    for i = 1,#tab do  
        local skill_name = tab[i]
        local skill = ac.skill[skill_name]
        --如果技能是光环
        if skill.is_aura then 
            -- 初始化时 创建一个敌对单位马甲 and ac.enemy_unit:find_skill(skill_name) 
            if not ac.enemy_unit then 
                ac.enemy_unit = ac.player.com[2]:create_dummy('e001', ac.point(0,0),0)
                ac.enemy_unit:add_restriction '无敌' 
            end
            --没找到 光环技能才添加
            if not  ac.enemy_unit:find_skill(skill_name)  then 
                ac.enemy_unit:add_skill(skill_name,'隐藏')
            end    
            -- 本回合开始时 删掉干掉光环怪
            -- 直接进入下一波的会跳过回合结束
            ac.game:event '游戏-回合开始'(function(trg,index, creep) 
                -- print('回合结束，删掉光环怪')
                ac.enemy_unit:remove()
            end)
                
        else
            if not unit:find_skill(skill_name) then 
                unit:add_skill(skill_name,'隐藏')    
            end    
        end    
        
        prtin_str = prtin_str .. i .. skill_name ..','
    end 
    -- unit:add_skill('龙破斩','英雄')    
    -- print('1111111111本回合野怪技能：',prtin_str)
end 

--发送本层怪物特性 
--@次数
--@持续时间
function mt:send_skill_message(cnt,time)
    local creep_skill_message ='|cff1FA5EE本层怪物特性：|r|cffFF9800'
    if not self.rand_skill_list  then 
        creep_skill_message = creep_skill_message ..'无|r'
    else    
        for i = 1,#self.rand_skill_list do  
            creep_skill_message = creep_skill_message .. self.rand_skill_list[i]..','
        end
    end    
    creep_skill_message = creep_skill_message ..'|r'
    for x=1,cnt do 
        for i = 1,10 do 
            ac.player(i):sendMsg(creep_skill_message,time)
        end  
    end    
end  
function mt:on_next()
    --进攻提示
    if ac.ui then ac.ui.kzt.up_jingong_title(' 第 '..self.index..' 层 ') end
    --每一波开始时，进行初始化数据
    -- self.all_food = all_food +(20 * (get_player_count() - 1))    --每多一个玩家， 多20怪物总人口,每回合开始都去检测人口数量
    self.all_food = all_food   
    self.used_food = 0 
    self.current_creep ={}
    -- self.player_damage = {}
    --金币怪
    if self.index == self.gold_index then 
        self.creeps_datas = "金币怪*1"
        self.flag_specail = true
    --挑战怪    
    elseif self.index == self.challenge_index then
        self.creeps_datas = "挑战怪"..self.challenge_index.."*1"
        self.flag_specail = true
    --普通怪    
    else 
        --获得随机 1-2 个种类的进攻怪
        local temp_type = self:get_temp_type()
        self:random_creeps_datas(temp_type)
    end 

    --每多一个玩家， 多20怪物总人口d，都是喽喽，金币或是挑战都不出来
    if not self.flag_specail then 
        local small_unit_name = self.all_units['喽喽'][math.random(1,#self.all_units['喽喽'])]
        local more_food = 20 * (get_player_count() - 1) 
        if more_food > 0 then 
            self.creeps_datas = self.creeps_datas .. ' '..small_unit_name..'*'..tostring(more_food) 
        end   
    end  
    self.flag_specail = false  

    print(self.creeps_datas) 

    --转化字符串 为真正的区域
    self:set_region()
    --转化字符串 为真正的野怪数据
    self:set_creeps_datas()

    self.rand_skill_list = self:get_creep_skill()
    self.rand_boss_skill_list = self:get_boss_skill()
    --发送本层怪物信息 3次10秒
    self:send_skill_message(3,10)
    print('当前波数 '..self.index)

    --难度相关处理
    -- if not self.game_win_timer then 
    --     self.game_win_timer = ac.loop(1*1000,function(t)
    --         if self.index > self.max_index then 
    --             t:remove()
    --             ac.game:event_notify('游戏-结束',true)
    --         end    
    --     end)
    -- end   

    --标准模式 
    -- @刷兵规则：回合结束时，创建钥匙怪，打死才能进下一波
    -- @游戏失败：回合开始时 进行倒计时，1分钟内没通过，游戏失败
    --嘉年华模式 场上的怪超过50只 游戏失败
    -- @刷兵规则：回合开始 创建钥匙怪，钥匙怪死亡或是15秒过去后钥匙怪消失且都进入下一波
    -- @游戏失败：场上怪物超过50只，游戏失败
    if ac.g_game_mode == 1 then 
        --@刷兵规则
        ac.game:event '游戏-回合结束' (function(trg,index, creep) 
            if creep.name ~= '刷怪' then
                return
            end    
            local self = creep
            local key_unit = self:creat_key_unit()
            --钥匙怪打死了马上下一波
            key_unit:event '单位-死亡' (function(_,unit,killer) 
                if self.key_unit_trg then 
                    self.key_unit_trg:remove()
                end     
                self:next()
            end)  
            return true
        end);

        --@游戏失败
        -- 每回合开始 都会先检查计时器是否还存在，存在则清空，重新计时。
        -- if self.timer_ex2 then 
        --     self.timer_ex2:remove()
        -- end    
        -- self.timer_ex2 = ac.timer_ex 
        -- {
        --     time = 60,
        --     title = "游戏失败 倒计时",
        --     func = function ()
        --         ac.game:event_notify('游戏-结束')
        --     end,
        -- }
    end    

    --嘉年华 钥匙怪死亡或是 15秒后 ,直接进入下一波
    if ac.g_game_mode == 2 then 
        --@刷兵规则
        local creep = self
        local key_unit = self:creat_key_unit()
        --钥匙怪打死了马上下一波
        key_unit:event '单位-死亡' (function(_,unit,killer) 
            if self.key_unit_trg then 
                self.key_unit_trg:remove()
            end  
            if self.timer_ex1 then 
                self.timer_ex1:remove()
            end     
            self:next()
        end)  
        --嘉年华 出怪时间 20秒
        self.timer_ex1 = ac.timer_ex 
        {
            time = 20,
            title = "距离下一波怪开始",
            func = function ()
                key_unit:remove()
                creep:next() --时间到马上下一波
            end,
        }
        ac.game:event '游戏-回合结束' (function(trg,index, creep) 
            if creep.name ~= '刷怪' then
                return
            end  
            --回合结束，阻止下一波
            return true
        end)    
        
        --@游戏失败 场上怪物超过50只
        if not self.mode_timer then 
			self.mode_timer = ac.loop(2*1000,function(t)
				local max_cnt = 50 * get_player_count()
                if self.current_count >= max_cnt * 0.5 then 
                    ac.player.self:sendMsg("【系统提示】当前怪物存活过多，还剩 |cffE51C23 "..(max_cnt - self.current_count).." 只|r 游戏结束，请及时清怪")
                end    
                if self.current_count >= max_cnt then 
                    t:remove()
                    ac.game:event_notify('游戏-结束')
                end    
            end)
        end    
    end 
    
end
--发送当前这层怪物受伤害信息
function mt:sendMsg_unit()
    local tip = '|cffffff00结算奖励：|r\n'
    for i=1,10 do 
        if self.player_damage and self.player_damage[i] and self.player_damage[i].player:is_player() then
            tip = tip ..'|cffffff00No.'..i..'、 |r|cffff0000'..self.player_damage[i].player:get_name()..'|r|cffffff00: 伤害[|cffff0000'..ac.numerical(self.player_damage[i].damage)..'|r|cffffff00]金币奖励 '..self.player_damage[i].gold..' |r'..'\n'
            self.player_damage[i].player:addGold(self.player_damage[i].gold)
        end   
    end
    ac.player.self:sendMsg(tip,10)   
end    
--改变怪物
function mt:on_change_creep(unit,lni_data)
    local name
    local flag_tianzhan 
     --金币怪
    if self.index == self.gold_index then 
        self.gold_index = self.gold_index + 10
        local gold_unit_award_base = gold_unit_award[self.index][1]
        local gold_base = gold_unit_award[self.index][2]
        local gold_max = gold_unit_award[self.index][3]
        name = "金币怪-"..self.index
        --金币怪处理
        unit:add_restriction '缴械'
        --钥匙怪逃跑路线
        self.key_unit_trg = self:move_random_way(unit)
        --倒计时30秒结束
        local time =25
        self.gold_unit_timer_ex1 = ac.timer_ex 
        {
            time = time,
            title = "金币怪消失倒计时",
            func = function ()
                --发送金币奖励
                self:sendMsg_unit()
                unit:kill() 
            end,
        }  
        ac.timer(1*1000,time,function(t)
            local cnt = time - t.cnt
            ac.on_texttag_time(cnt,unit)
        end)
        --统计伤害 
        unit:event '伤害计算完毕'(function (_,damage)
            if damage.real_damage then 
                damage.current_damage = 1 
            end    
            if not self.player_damage then 
                self.player_damage = {}
            end    
            local p = damage.source:get_owner()
            for i = 1 ,10 do 
                if not self.player_damage[i] then
                    self.player_damage[i] = {}
                    self.player_damage[i].player = ac.player(i)
                    self.player_damage[i].damage = 0
                    self.player_damage[i].gold = 0
                end    
                local v = self.player_damage[i]
                if v.player == p then 
                    v.damage = v.damage + damage.current_damage
                    -- 最大值为10000元
                    local gold = gold_base + math.ceil(v.damage /gold_unit_award_base) 
                    v.gold = (gold > gold_max ) and gold_max or gold
                end    
            end
            table.sort(self.player_damage,function (a,b)
                return a.damage > b.damage
            end)
        end)  
        --单位死亡时，清空伤害统计。   
        unit:event '单位-死亡'(function(_,unit,killer)
            for i = 1 ,10 do 
                if self.player_damage and self.player_damage[i] then
                    self.player_damage[i] = nil
                end 
            end       
        end)
        
    --挑战怪    当前数据统计 current_data_trace
    elseif self.index == self.challenge_index then
        self.challenge_index = self.challenge_index + 10
        name = "挑战怪-"..self.index
        flag_tianzhan = true 
    --普通怪    
    else 
        name = '进攻怪-'..self.index
    end   
    -- print('打印：',name,self.index)
    local data = ac.table.UnitData[name]
    data.attr_mul = lni_data.attr_mul
    data.food = lni_data.food
    --继承进攻怪lni 值
    for k,v in sortpairs(data) do 
        unit.data[k] = v
    end    
  
    if unit and data  then 
        unit.gold = data.gold
        unit.exp = data.exp
        -- print(unit.category,data.category)
        unit.category = data.category
        for k,v in sortpairs(data.attribute) do 
            unit:set(k,v)
        end
        --设置魔抗
        unit:set('魔抗',data.attribute['护甲'])
        --设置 boss 等 属性倍数
        if lni_data.attr_mul  then
            --属性
            unit:set('攻击',data.attribute['攻击'] * lni_data.attr_mul * ac.g_game_degree_attr)
            unit:set('护甲',data.attribute['护甲'] * lni_data.attr_mul * ac.g_game_degree_attr)
            unit:set('生命上限',data.attribute['生命上限'] * lni_data.attr_mul * ac.g_game_degree_attr)
            unit:set('魔法上限',data.attribute['魔法上限'] * lni_data.attr_mul * ac.g_game_degree_attr)
            unit:set('生命恢复',data.attribute['生命恢复'] * lni_data.attr_mul * ac.g_game_degree_attr)
            unit:set('魔法恢复',data.attribute['魔法恢复'] * lni_data.attr_mul * ac.g_game_degree_attr)
            --设置魔抗 
            unit:set('魔抗',data.attribute['护甲']* lni_data.attr_mul * ac.g_game_degree_attr)
        end
        --掉落概率
        unit.fall_rate = data.fall_rate * lni_data.food
        --掉落金币和经验
        unit.gold = (data.gold or 0) * lni_data.food
        unit.exp = (data.exp or 0) * lni_data.food

    end 
    --设置搜敌路径
    -- unit:set_search_range(99999)
    --随机添加怪物技能
    self:add_creep_skill(self.rand_skill_list,unit)

    if flag_tianzhan then 
        self:add_boss_skill(self.rand_boss_skill_list,unit)
    end    
    -- unit:add_skill('火焰','隐藏')
    -- unit:add_skill('神盾','隐藏')
    -- unit:add_skill('减速光环','隐藏')
    -- unit:add_skill('沉默光环','隐藏')
    
    

end
--AI逃跑路线（随机）
function mt:move_random_way(unit)
    --逃跑路线
    local hero = ac.find_hero(unit)
    local angle
    if hero then  
        angle= hero:get_point()/unit:get_point()
    else 
        angle =math.random(0,360)
    end    
    --优化钥匙怪跑路角度
    angle = angle - math.random(0,360)
    local target_point = unit:get_point() - {angle,800}
    unit:issue_order('move',target_point)

    local trg = unit:loop(2*1000,function()
        local hero = ac.find_hero(unit)
        local angle
        if hero then  
            angle= hero:get_point()/unit:get_point()
        else 
            angle =math.random(0,360)
        end    
        --优化钥匙怪跑路角度
        angle = angle - math.random(0,360)
        local target_point = unit:get_point() - {angle,800}
        unit:issue_order('move',target_point)

    end);
    return trg
end 
local function ai_move_random_way(unit)
    --逃跑路线
    local hero = ac.find_hero(unit)
    local angle
    if hero then  
        angle= hero:get_point()/unit:get_point()
    else 
        angle =math.random(0,360)
    end    
    --优化钥匙怪跑路角度
    angle = angle - math.random(0,360)
    local target_point = unit:get_point() - {angle,800}
    unit:issue_order('move',target_point)

    local trg = unit:loop(2*1000,function()
        local hero = ac.find_hero(unit)
        local angle
        if hero then  
            angle= hero:get_point()/unit:get_point()
        else 
            angle =math.random(0,360)
        end    
        --优化钥匙怪跑路角度
        angle = angle - math.random(0,360)
        local target_point = unit:get_point() - {angle,800}
        unit:issue_order('move',target_point)

    end);
    return trg
end    
ac.ai_move_random_way = ai_move_random_way

--创建钥匙怪
function mt:creat_key_unit()
    local point = self.region:get_point()
    local unit = ac.player[16]:create_unit('钥匙怪',point)
    ac.key_unit = unit
    -- unit:add_ability 'Agld' --添加金矿技能，小地图金矿标识

    local data = ac.table.UnitData['钥匙怪']
    if data.model_size then 
        unit:set_size(data.model_size)
    end   


    -- print('钥匙怪队伍：',unit:get_team())
    local name = '进攻怪-'..self.index
    local data = ac.table.UnitData[name]

    --设置属性
    unit.category = '进攻怪' --设置为进攻怪的掉落物品规则
    unit.gold = data.gold * 5 *0
    unit.exp = data.exp * 5 *0
    unit.fall_rate = data.fall_rate * 5 *0
    unit:set('移动速度',650)
    unit:set('生命上限',20)
    unit:add_high(100)
    unit:add_restriction('魔免')
    --钥匙怪逃跑路线
    self.key_unit_trg = self:move_random_way(unit)

    unit:event '受到伤害开始'(function(trg,damage)
        --不是普攻就跳出 or not damage.skill
        if not damage:is_common_attack()  then 
            return true
        end    
    end)
    return unit

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
    ac.game:event_dispatch('游戏-最终boss',self.index,self)
      
end   
--每3秒刷新一次攻击目标
function mt:attack_hero() 
    self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
        -- print('野怪区的怪数量',#mt.group)
        for _, unit in ipairs(self.group) do
            if unit:is_alive() then 
                local hero = ac.find_hero(unit)
                if hero then 
                    if unit.target_point and unit.target_point * hero:get_point() < 1000 then 
                        unit.target_point = hero:get_point()
                        unit:issue_order('attack',hero:get_point())
                    else 
                        unit.target_point = hero:get_point()
                        if unit:get_point() * hero:get_point() < 1000 then 
                            unit:issue_order('attack',hero:get_point())
                        else  
                            unit:issue_order('attack',hero:get_point())
                        end 
                    end 
                end 
            end    
        end 
    end) 
    self.attack_hero_timer:on_timer()
end    

-- 注册英雄杀怪得奖励事件
ac.game:event '单位-死亡' (function(_,unit,killer) 
    if killer.category =='进攻怪' or killer.category =='boss' or unit == killer then
		return
    end

    local player = killer:get_owner()
    local gold 
    local exp =0
    
    -- 英雄的召唤物 打死的怪，也给英雄加钱加经验
    -- 英雄召唤物享有 英雄的金币、经验加成
    if player  then 
        killer = player.hero
    end   
    -- 进攻怪杀死单位，不用加钱和经验
    if not killer or not killer:is_hero()  then  
        return
    end    
    --加钱
    if unit.gold  then 
        gold = unit.gold * ( 1 + killer:get('金币加成')/100)
    end   
    --加经验,
    if unit.exp  then
        exp = unit.exp * ( 1 + killer:get('经验加成')/100)
    end  
    --100级最高级  未测试
    -- local total_killer_xp = killer.xp + exp
    -- if total_killer_xp - killer:get_upgrade_xp(99) > 0  then 
    --     exp = killer:get_upgrade_xp(99) - killer.xp
    -- end    
    -- if killer.level >= 100 then 
    --     exp = 0
    -- end    

    local source = killer
    local target = unit
    --自己得50%，其他人平分剩余经验和钱
    local other_exp_per = 0.75
    local other_gold_per = 0.75
    --找到附近的其他英雄
    local from_p = source and source:get_owner()
    local heros = ac.hero.all_heros
    local group = {}
    for u,_ in pairs(heros) do
        if u:is_alive() and from_p ~= u:get_owner() and u:is_in_range(source, 20000) and target:is_enemy(u) then
            table.insert(group, u)
        end
    end

    local p = ac.point(0,0)
    table.sort(group,function (a,b)
        return a:get_point() * p < b:get_point() * p
    end)

    --附近没有其他英雄，金钱和经验加100%，返回。
    if #group == 0 then	
        --自己加经验
        if source:is_alive() and source:is_hero() then 
            source:addXp(exp)
        end	
        --加钱
        player:addGold(gold,unit)
        return
    end

    local len = #group
    --自己先得 25%，再得剩余人平分得75%。
    local tran_xp = exp*(1-other_exp_per)  + exp * other_exp_per / (len+1)
    local tran_gold = gold*(1-other_gold_per)  + gold * other_gold_per / (len+1)
    if source:is_alive() and source:is_hero() then 
        source:addXp( tran_xp )
    end	
    --加钱
    player:addGold(tran_gold,unit)
    
    --其他英雄平分经验
    for _, hero in ipairs(group) do
        -- print(hero)
        if exp then
            hero:addXp( exp * other_exp_per / (len+1))
        end
        if gold then
            hero:get_owner():addGold(gold * other_gold_per / (len+1),unit)
        end
    end

end);


ac.game:event '游戏-选择难度' (function (_,index)
    --难度1
    if index == 1 then 
        ac.g_game_degree = index 
        ac.player.self:sendMsg("选择了 |cffffff00【普通难度】|r ")
        require '英雄'
        require '平台'
    end
    
    --难度2
    if index == 2 then 
        ac.g_game_degree = index
        ac.player.self:sendMsg("选择了 |cffffff00【噩梦难度】（可进入无尽）|r")
        require '英雄'
        require '平台'
    end 
    --难度3
    if index == 3 then 
        ac.g_game_degree = index
        ac.player.self:sendMsg("选择了 |cffffff00【地狱难度】（可进入无尽 新手慎入）|r")
        require '英雄'
        require '平台'
    end 
    --难度4
    if index == 4 then 
        ac.g_game_degree = index
        ac.player.self:sendMsg("选择了 |cffffff00【圣人难度】（喜欢挑战的来）|r")
        require '英雄'
        require '平台'
    end 

    --每3秒提醒玩家主机在选择难度
    ac.loop(3*1000,function(t)
        if ac.g_game_degree then 
            t:remove()
        else
            ac.player.self:sendMsg("等待主机选择模式、难度")
        end
    end)
end)


--进入游戏后3秒开始刷怪
ac.wait(20,function()
    --1选择难度 2选择英雄 3游戏开始
    --全部英雄选完才会进入游戏开始.主机在选难度，所以不会有事。
    print('开始选择难度')
    local player = get_first_player()
    local list = {
        { name = "标准模式" },
        { name = "嘉年华模式（快速出怪）" },
    }
    
    local list2 = {
        { name = "普通" },
        { name = "噩梦（可进入无尽）" },
        { name = "地狱（可进入无尽 新手慎入）" },
        { name = "圣人（新欢挑战的来）" },
    }
    ac.player.self:sendMsg("正在选择 |cffffff00模式、难度|r")
    if player then 
        create_dialog(player,"选择模式",list,function (index)
            --模式1 标准模式
            if index == 1 then 
                ac.g_game_mode = index 
                ac.player.self:sendMsg("选择了 |cffffff00【标准模式】|r")
            end
            --模式2 嘉年华模式
            if index == 2 then 
                ac.g_game_mode = index 
                ac.player.self:sendMsg("选择了 |cffffff00【嘉年华模式】（快速出怪）|r")
            end

            create_dialog(player,"选择难度",list2,function (index)
                ac.game:event_notify('游戏-选择难度',index)
            end)
        end)

    end 

    ac.game:event '游戏-开始' (function()
        print('游戏开始6')
        --游戏开始后 刷怪时间
        local time = 30
        if global_test then 
            time = 1
        end    
        BJDebugMsg(time .. "秒后开始扫荡第一层怪物")
        ac.timer_ex 
        {
            time = time,
            title = "距离怪物进攻",
            func = function ()
                ac.game:event_notify('游戏-开始刷兵')
            end,
        }
        print('游戏开始7')
    end)

    ac.game:event '游戏-开始刷兵' (function ()
        --开始刷怪
        print('开始刷兵啦')
        mt:start()
        --每3秒刷新一次攻击目标
        mt:attack_hero() 
    end)    
   

end);
