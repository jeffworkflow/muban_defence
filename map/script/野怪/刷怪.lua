-- 每回合刷 25 人口的怪物
-- 喽喽占 1个人口，小怪占 2个人口，头目占4人口，boss占20人口
-- 小怪、头目、boss属性是喽喽的多倍
-- 每个回合刷的 同怪物类型 的怪物都是同样。
-- 两个模式，标准和嘉年华，各自有3个难度 普通 噩梦 地狱 难度不同， 怪属性增强倍数不同
-- 标准模式就常规模式，嘉年华为 无限生怪，打完直接进入下一波，钥匙怪也会出来。
-- 根据玩家数 提高怪的总人口

--boss 光环列表
local buff_list = {
}
--技能列表
ac.skill_list = {
    '肥胖','强壮','钱多多','经验多多','物品多多',
    '神盾','闪避+','闪避++','眩晕','生命回复',
    '重生','死亡一指','灵丹妙药','刺猬','怀孕',
    '抗魔','魔免','火焰','净化','远程攻击',
    '幽灵','腐烂','流血','善恶有报',
    '沉默光环','减速光环'
}

local skill_list = ac.skill_list

local all_creep = {}
local all_food 
for k,v in pairs(ac.table.UnitData) do
    if v.type then 
        if finds(v.type,'喽喽','小怪','头目','boss') then
            if not all_creep[v.type] then 
                all_creep[v.type] = {}
            end
            table.insert(all_creep[v.type],k)    
            -- print(k,v.type) 
        end    
    end    
    if v.category =='进攻怪' then
        all_food = v.all_food
    end    
end    

--每回合开始 从 ac.skill_list 随机取0-2个野怪技能
local function get_creep_skill()

    local rand_skill_cnt = math.random(0,2)
    local rand_skill_list = {}
    if rand_skill_cnt == 0 then 
        return 
    end  
    for i = 1,rand_skill_cnt do  
        local rand_skill_name = ac.skill_list[math.random(#ac.skill_list)]
        table.insert(rand_skill_list,rand_skill_name)
    end    
    return rand_skill_list

end
--给野怪添加技能 
--技能列表
--野怪单位
local function add_creep_skill(tab,unit)
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
            -- 本回合结束时 删掉干掉光环怪
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
    -- unit:add_skill('火焰','隐藏')    
    print('1111111111本回合野怪技能：',prtin_str)
end    


local mt = ac.creep['刷怪']{    
    region = '',
    creeps_datas = '',
    max_index = 100,
    is_random = true,
    creep_player = ac.player.com[2],
    tip ="郊区野怪刷新啦，请速速打怪升级，赢取白富美"

}
function mt:on_start()
    local rect = require 'types.rect'
    local region = rect.create('-2000','-2000','2000','2000')
    self.region = region
    -- 刷怪初始化 难度、玩家影响
    if ac.g_game_degree == 1 then 
        self.game_degree_attr_mul = 1  --难度一 属性倍数1倍
    end    
    if ac.g_game_degree == 2 then 
        self.game_degree_attr_mul = 2  --难度二 属性倍数2倍
    end  
    if ac.g_game_degree == 3 then 
        self.game_degree_attr_mul = 3  --难度三 属性倍数3倍
    end  

end
function mt:on_next()
    --每一波开始时，进行初始化数据
    self.all_food = all_food * get_player_count()   --每多一个玩家， 多1倍的怪物总人口,每回合开始都去检测人口数量
    self.used_food = 0 
    self.current_creep ={}
    
    --查找当前波野怪数据是否已经有此类型的怪
    -- 类型或是名字都可查找
    local function has_unit(str)
        -- print('打印当前野怪',self.current_creep)
        local u
        for k,v in pairs(self.current_creep) do
            if v.type == str or v.name == str then 
                u = v
                break
            end    
        end   
        return u 
    end    
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
        -- if temp_type[1] and temp_type[1] == random_ty then 
        --     i = 1
        -- else
            table.insert(temp_type,random_ty) 
        -- end    
        
    end    
    -- print('本回合怪物种类：'..int)
    --随机生成野怪数据
    local function random_creeps_datas()

        local rand_type = temp_type[math.random(1,#temp_type)]

        local rand_name
        local u = has_unit(rand_type)
        if u then 
            rand_name = u.name
        else    
            rand_name = all_creep[rand_type][math.random(1,#all_creep[rand_type])]
        end    

        self.used_food = self.used_food  + ac.table.UnitData[rand_name].food

        if self.used_food <= self.all_food then 
            local u = has_unit(rand_type)
            if u then
                self.current_creep[rand_name]['cnt'] = self.current_creep[rand_name]['cnt'] +1
            else 
                --保存当前生成的数据
                for k,v in pairs(ac.table.UnitData[rand_name]) do
                    if not self.current_creep[rand_name]  then 
                        self.current_creep[rand_name] = {}
                    end 
                    self.current_creep[rand_name]['name'] =  rand_name
                    self.current_creep[rand_name]['cnt'] =  1
                    self.current_creep[rand_name][k]=v 
                end    
            end

            if self.used_food == self.all_food then 
                local result = ''
                for k,v in pairs(self.current_creep) do
                    result = result ..v.name..'*'..tostring(v.cnt)..' '
                end   
                -- print('函数内的返回结果',result)
                -- 没搞懂return 外面没接收到值
                self.creeps_datas = result
                return result
            end    

            random_creeps_datas()

        else
            self.used_food = self.used_food - ac.table.UnitData[rand_name].food 
            print('已经超出人口，需要重新筛选',self.used_food)
            random_creeps_datas()
        end       

    end

    random_creeps_datas()

    print(self.creeps_datas)

    --转化字符串 为真正的区域
    self:set_region()
    --转化字符串 为真正的野怪数据
    self:set_creeps_datas()

    self.rand_skill_list = get_creep_skill()

    --发送本层怪物特性 
    --@次数
    --@持续时间
    local function send_skill_message(cnt,time)
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
    --发送本层怪物信息 3次10秒
    send_skill_message(3,10)
    print('当前波数 '..self.index)



    --标准模式 
    -- @刷兵规则：回合结束时，创建钥匙怪，打死才能进下一波
    -- @游戏失败：回合开始时 进行倒计时，1分钟内没通过，游戏失败
    --嘉年华模式 场上的怪超过50只 游戏失败
    -- @刷兵规则：回合开始 创建钥匙怪，钥匙怪死亡或是15秒过去后钥匙怪消失且都进入下一波
    -- @游戏失败：场上怪物超过50只，游戏失败
    if ac.g_game_mode == 1 then 
        --@刷兵规则
        ac.game:event '游戏-回合结束' (function(trg,index, creep) 
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
        if self.timer_ex2 then 
            self.timer_ex2:remove()
        end    
        self.timer_ex2 = ac.timer_ex 
        {
            time = 60,
            title = "游戏失败 倒计时",
            func = function ()
                ac.game:event_notify('游戏-结束')
            end,
        }
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
        self.timer_ex1 = ac.timer_ex 
        {
            time = 15,
            title = "距离下一波怪开始",
            func = function ()
                key_unit:remove()
                creep:next() --时间到马上下一波
            end,
        }
        ac.game:event '游戏-回合结束' (function(trg,index, creep) 
            --回合结束，阻止下一波
            return true
        end)    
        
        --@游戏失败 场上怪物超过50只
        if not self.mode_timer then 
            self.mode_timer = ac.loop(1*1000,function(t)
                if self.current_count >= 40 then 
                    ac.player.self:sendMsg("【系统提示】当前怪物已达|cffE51C23 "..self.current_count.." |r，请及时清怪")
                    ac.player.self:sendMsg("【系统提示】当前怪物已达|cffE51C23 "..self.current_count.." |r，请及时清怪")
                end    
                if self.current_count >= 5000 then 
                    t:remove()
                    ac.game:event_notify('游戏-结束')
                end    
            end)
        end    
    end 
    
end
--改变怪物
function mt:on_change_creep(unit,lni_data)
  
    local name = '进攻怪-'..self.index
    local data = ac.table.UnitData[name]
    data.attr_mul = lni_data.attr_mul
    data.food = lni_data.food
    --继承进攻怪lni 值
    for k,v in pairs(data) do 
        unit.data[k] = v
    end    
  
    if unit and data  then 
        unit.gold = data.gold
        unit.exp = data.exp
        unit.category = data.category
        for k,v in pairs(data.attribute) do 
            unit:set(k,v)
        end
        --设置 boss 等 属性倍数
        if lni_data.attr_mul  then
            --属性
            unit:set('攻击',data.attribute['攻击'] * lni_data.attr_mul)
            unit:set('护甲',data.attribute['护甲'] * lni_data.attr_mul)
            unit:set('生命上限',data.attribute['生命上限'] * lni_data.attr_mul)
            unit:set('魔法上限',data.attribute['魔法上限'] * lni_data.attr_mul)
            unit:set('生命恢复',data.attribute['生命恢复'] * lni_data.attr_mul)
            unit:set('魔法恢复',data.attribute['魔法恢复'] * lni_data.attr_mul)
        end  

        --掉落概率
        unit.fall_rate = data.fall_rate * lni_data.food
        --掉落金币和经验
        unit.gold = data.gold * lni_data.food
        unit.exp = data.exp * lni_data.food

    end 
    --设置搜敌路径
    -- unit:set_search_range(99999)
    --随机添加怪物技能
    add_creep_skill(self.rand_skill_list,unit)
    --unit:add_skill('怀孕','隐藏')
    -- unit:add_skill('霜冻新星','隐藏')
    -- unit:add_skill('肥胖','隐藏')
    -- unit:add_skill('强壮','隐藏')
    -- unit:add_skill('有钱','隐藏')
    -- unit:add_skill('学习','隐藏')
    -- unit:add_skill('收藏','隐藏')
    -- unit:add_skill('神盾','隐藏')
    -- unit:add_skill('躲猫猫','隐藏')
    -- unit:add_skill('我晕','隐藏')
    -- unit:add_skill('泡温泉','隐藏')
    -- unit:add_skill('重生','隐藏')
    -- unit:add_skill('死亡一指','隐藏')
    -- unit:add_skill('学霸','隐藏')
    -- unit:add_skill('刺猬','隐藏')
    -- unit:add_skill('怀孕','隐藏')
    -- unit:add_skill('抗魔','隐藏')
    -- unit:add_skill('魔免','隐藏')
    -- unit:add_skill('火焰','隐藏')
    -- unit:add_skill('净化','隐藏')
    -- unit:add_skill('远程攻击','隐藏')
    -- unit:add_skill('幽灵','隐藏')
    -- unit:add_skill('腐烂','隐藏')
    -- unit:add_skill('流血','隐藏')
    -- unit:add_skill('善恶有报','隐藏')
    -- unit:add_skill('闪避++','隐藏')
    

end
--创建钥匙怪
function mt:creat_key_unit()
    local unit = ac.player[16]:create_unit('钥匙怪',ac.point(0,0))
    ac.key_unit = unit
    -- print('钥匙怪队伍：',unit:get_team())
    local name = '进攻怪-'..self.index
    local data = ac.table.UnitData[name]

    --设置属性
    unit.category = '进攻怪' --设置为进攻怪的掉落物品规则
    unit.gold = data.gold * 5 
    unit.exp = data.exp * 5
    unit.fall_rate = data.fall_rate * 5
    unit:set('移动速度',650)

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

    self.key_unit_trg = unit:loop(2*1000,function()
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
end    

-- 注册英雄杀怪得奖励事件
ac.game:event '单位-死亡' (function(_,unit,killer) 
    if killer.category =='进攻怪' then
		return
    end

    local player = killer:get_owner()
    local gold 
    local exp 
    
    -- 英雄的召唤物 打死的怪，也给英雄加钱加经验
    -- 英雄召唤物享有 英雄的金币、经验加成
    if player  then 
        killer = player.hero
    end   
    -- 进攻怪杀死单位，不用加钱和经验
    if not killer:is_hero() then  
        return
    end    
    --加钱
    if unit.gold  then 
        gold = unit.gold * ( 1 + killer:get('金币加成')/100)
        player:addGold(gold,unit,true)
    end   
     
    --加经验,100级最高级
    if unit.exp  and killer.level <100 then
        exp = unit.exp * ( 1 + killer:get('经验加成')/100)
        killer:addXp(exp)
    end

end);


ac.game:event '游戏-选择难度' (function (_,index)
    --难度1
    if index == 1 then 
        ac.g_game_degree = index 
        ac.player.self:sendMsg("【普通】是男人就上 100 层 ")
    end
    
    --难度2
    if index == 2 then 
        ac.g_game_degree = index
        ac.player.self:sendMsg("【噩梦】100 层后，进入无尽模式")
    end 
    --难度3
    if index == 3 then 
        ac.g_game_degree = index
        ac.player.self:sendMsg("【地狱】100 层后，进入无尽模式")
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
ac.wait(0,function()
    --1选择难度 2选择英雄 3游戏开始
    --全部英雄选完才会进入游戏开始.主机在选难度，所以不会有事。
    local player = get_first_player()
    local list = {
        { name = "标准模式" },
        { name = "嘉年华模式" },
    }
    
    local list2 = {
        { name = "普通" },
        { name = "噩梦" },
        { name = "地狱" },
    }
    --可能会掉线
    ac.player.self:sendMsg("正在选择 模式、难度")
    if player then 
        create_dialog(player,"选择模式",list,function (index)
            --模式1 标准模式
            if index == 1 then 
                ac.g_game_mode = index 
                ac.player.self:sendMsg("【标准模式】")
            end
            --模式2 嘉年华模式
            if index == 2 then 
                ac.g_game_mode = index 
                ac.player.self:sendMsg("【嘉年华模式】 ")
            end

            create_dialog(player,"选择难度",list2,function (index)
                ac.game:event_notify('游戏-选择难度',index)
            end)
        end)

    end 

    ac.game:event '游戏-开始' (function()
        local time = 5
        if ac.test == true then
            time = 0
        end
        BJDebugMsg(time .. "秒后开始刷新进攻怪")
        ac.timer_ex 
        {
            time = time,
            title = "距离怪物进攻",
            func = function ()
                ac.game:event_notify('游戏-开始刷兵')
            end,
        }
    end)

    ac.game:event '游戏-开始刷兵' (function ()
        --开始刷怪
        mt:start()
        --每3秒刷新一次攻击目标
        ac.loop(3 * 1000 ,function ()
            -- print('野怪区的怪数量',#mt.group)
            for _, unit in ipairs(mt.group) do
                if unit:is_alive() then 
                    local hero = ac.find_hero(unit)
                    if hero then 
                        if unit.target_point and unit.target_point * hero:get_point() < 1000 then 
                            unit.target_point = hero:get_point()
                            unit:issue_order('attack',hero:get_point())
                        else 
                            unit.target_point = hero:get_point()
                            if unit:get_point() * hero:get_point() < 1000 then 
                                unit:issue_order('attack',hero)
                            else  
                                unit:issue_order('attack',hero:get_point())
                            end 
                        end 
                    end 
                end    
            end 
        end)
    end)    
   

end);
