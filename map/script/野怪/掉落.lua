

--按照装备品阶 筛选出 lni 装备。
--quality_item={'白' = {'新手剑','新手戒指'},'蓝' = {..}}
local quality_item ={}
for name,data in pairs(ac.table.ItemData) do 
    local color = data.color 
    if color then 
        local list = quality_item[color] or {}
        table.insert(list,name)
        quality_item[color] = list 
    end 
end 
ac.quality_item = quality_item
--英雄技能，钥匙怪掉落表
ac.skill_list2 = ac.skill_list2

local function item_self_skill(item,unit)
    local timer = ac.wait(100 * 1000,function (timer)
        if item.owner == nil then 
            item:remove()
        end 
    end)
    item._self_skill_timer = timer 

    --处理偷窃完的物品位置
    if ac.game['偷窃'] then 
        if unit then 
            item:setPoint(unit:get_point())
        end    
    end
end 
--统一漂浮文字显示
local function on_texttag(string,color,hero)
    local color = color or '白'
    --颜色代码
    local color_rgb = {
        ['红'] = { r = 255, g = 0, b = 0,},
        ['绿'] = { r = 0, g = 255, b = 0,},
        ['蓝'] = { r = 0, g = 189, b = 236,},
        ['黄'] = { r = 255, g = 255, b = 0,},
        ['青'] = { r = 0, g = 255, b = 255,},
        ['紫'] = { r = 223, g = 25, b = 208,},
        ['橙'] = { r = 255, g = 128, b = 0,},
        ['棕'] = { r = 166, g = 125, b = 61,},
        ['粉'] = { r = 188, g = 143, b = 143,},
        ['白'] = { r = 255, g = 255, b = 255,},
        ['黑'] = { r = 0, g = 0, b = 0,},
        ['金'] = { r = 255, g = 255, b = 0,},
        ['灰'] = { r = 204, g = 204, b = 204,},
    }

    local target = hero
    local x, y = target:get_point():get()
    local z = target:get_point():getZ()
    local tag = ac.texttag
    {
        string = string,
        size = 10,
        position = ac.point(x-200 , y+50, z + 30),
        red = color_rgb[color].r,
        green = color_rgb[color].g,
        blue = color_rgb[color].b,
        fade = 0.5,
        speed = 150,
        angle = 160,
        life = 2,
        time = ac.clock(),
    }
    return tag
end

--先列出所有奖励 再按概率抽取
local reward = {
    ['符文'] = function (player,hero,unit,level)
    
        local list = {'力量符文','敏捷符文','智力符文','血质符文','魔力符文','生命符文','魔法符文'}
        
        if level == nil then 
            if g_game_min < 10 then 
                level = 1 
            elseif g_game_min < 20 then 
                level = 2 
            else 
                level = 3
            end 
        end 

        local name = list[math.random(#list)] .. level 
        local x,y = unit:get_point():get() 
        local item = hero:add_item(name)
    end,

    ['随机白装'] = function (player,hero,unit,is_on_hero)
        local list = quality_item['白']
        if list == nil then 
            print('没有蓝色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        if not is_on_hero then 
            local item = ac.item.create_item(name,unit:get_point())
            item_self_skill(item,hero)
        else
            --宠物打死的也掉人身上
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end    
    end,
    ['随机蓝装'] = function (player,hero,unit,is_on_hero)
        local list = quality_item['蓝']
        if list == nil then 
            print('没有蓝色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        if not is_on_hero then 
            local item = ac.item.create_item(name,unit:get_point())
            item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,


    ['随机金装'] = function (player,hero,unit,is_on_hero)
        local list = quality_item['金']
        if list == nil then 
            print('没有橙色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        if not is_on_hero then 
            local item = ac.item.create_item(name,unit:get_point())
            item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,

    ['随机红装'] = function (player,hero,unit,is_on_hero)
        local list = quality_item['红']
        if list == nil then 
            print('没有紫色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        if not is_on_hero then 
            local item = ac.item.create_item(name,unit:get_point())
            item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['随机技能'] = function (player,hero,unit,is_on_hero)
        local list = ac.skill_list2
        if list == nil then 
            print('没有任何技能')
            return 
        end 
        local name = list[math.random(#list)]
        if not is_on_hero then 
            local item = ac.item.create_skill_item(name,unit:get_point())
            item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            ac.item.add_skill_item(name,hero)
        end 
    end,

}
ac.reward = reward


local unit_reward = {
    ['进攻怪'] =  {
        -- { rand = 97.5,         name = '无'},
        { rand = 2.5,      name = {
                { rand = 60, name = '随机白装'},
                { rand = 25, name = '随机蓝装'},
                { rand = 10, name = '随机金装'},
                { rand = 5, name = '随机红装'},
            }
        }
    },
    ['随机物品'] =  {
        { rand = 100,      name = {
                { rand = 60, name = '随机白装'},
                { rand = 25, name = '随机蓝装'},
                { rand = 10, name = '随机金装'},
                { rand = 5, name = '随机红装'},
            }
        }
    },
    ['钥匙怪'] =  {
        { rand = 20,      name = '随机技能'}
    },
    ['商店随机技能'] =  {
        { rand = 100,      name = '随机技能'}
    },
    ['商店随机物品'] =  {
        { rand = 100,      name = {
                { rand = 60, name = '白'},
                { rand = 25, name = '蓝'},
                { rand = 10, name = '金'},
                { rand = 5, name = '红'},
            }
        }
    },
   
}
ac.unit_reward = unit_reward

--递归匹配唯一奖励
local function get_reward_name(tbl)
    local rand = math.random(1,10000) / 100
    local num = 0
    for index,info in ipairs(tbl) do 
        num = num + info.rand 
        -- print("打印装备掉落概率",info.rand)
        if rand <= num then 
            if type(info.name) == 'string' then 
                return info.name 
            elseif type(info.name) == 'table' then 
                return  get_reward_name(info.name)
            end 
            break 
        end 
    end 
end 

ac.get_reward_name = get_reward_name

--递归匹配多个奖励
local function get_reward_name_list(tbl,list,level)
    local level = level or 0
    local rand = math.random(1,10000) / 100

    local num = 0
    for index,info in ipairs(tbl) do 
        num = num + info.rand 
        if rand <= num then 
            if type(info.name) == 'string' then 
                table.insert(list,info.name)
            elseif type(info.name) == 'table' then 
                get_reward_name_list(info.name,list,level + 1)
            end 
            if level > 0 then 
                break 
            end
        end 
    end 
end
ac.get_reward_name_list = get_reward_name_list


local function hero_kill_unit(player,hero,unit,fall_rate,is_on_hero)

    local change_unit_reward = unit_reward['进攻怪']
    
    for index,info in ipairs(change_unit_reward) do 
        change_unit_reward[index].rand = fall_rate
    end    
    local name = get_reward_name(change_unit_reward)
    if name then 
        local func = reward[name]
        if func then 
            -- print('掉落',name)
            func(player,hero,unit,is_on_hero)
        end 
    end 
    return name 
end 
ac.hero_kill_unit = hero_kill_unit

--如果死亡的是野怪的话
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit.category ~='进攻怪' then
		return
    end
    local player = killer:get_owner()
    local dummy_unit = player.hero or ac.dummy
    local fall_rate = unit.fall_rate *( 1 + dummy_unit:get('物品获取率')/100 )
    -- print('装备掉落概率：',fall_rate,unit.fall_rate)
    hero_kill_unit(player,killer,unit,fall_rate)
end)

--如果死亡的是钥匙怪的话
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_name() ~='钥匙怪' then
		return
    end
    local name = get_reward_name(unit_reward['钥匙怪'])
    if name then 
        local func = reward[name]
        local player = killer:get_owner()
        if func then 
            func(player,killer,unit)
        end  
    end    
end)


--物品掉落，主动发起掉落而不是单位死亡时掉落 。
-- 应用：张全蛋技能 妙手空空
ac.game:event '物品-偷窃' (function (_,unit,killer)

    ac.game['偷窃'] = true

    if unit.category ~='进攻怪' then
		return
    end
    -- print('触发 物品-偷窃')
    local player = killer:get_owner()
    local dummy_unit = player.hero or ac.dummy
    local fall_rate = unit.fall_rate *( 1 + dummy_unit:get('物品获取率')/100 )
    -- print('装备掉落概率：',killer,fall_rate,unit.fall_rate)
    -- 最后一个参数，直接掉人身上
    local name = hero_kill_unit(player,killer,unit,fall_rate,true)
    if not name  then 
        on_texttag('未获得','红',killer)
    end
    ac.game['偷窃'] = false

end)

--物品掉落，直接获得随机装备
-- 应用： 摔破罐子
ac.game:event '物品-随机装备' (function (_,unit,killer)

    ac.game['偷窃'] = true

    if unit.category ~='进攻怪' then
		return
    end
    -- print('触发 物品-偷窃')
    local player = killer:get_owner()

    local name = get_reward_name(unit_reward['随机物品'])
    if name then 
        local func = reward[name]
        if func then 
            -- print('掉落',name)
            func(player,killer,unit,true)
        end 
    else
        on_texttag('未获得','红',killer)    
    end 

    ac.game['偷窃'] = false

end)


ac.game:event '单位-即将获得物品' (function (_,unit,item)
    on_texttag('获得 '..item.name,item.color,unit)
end )   

ac.game:event '单位-获得物品后' (function (_,unit,item)
    local timer = item._self_skill_timer 
    if timer then 
        timer:remove()
        item._self_skill_timer = nil 
    end 
end)




--[[

--概率计算测试输出
for a = 1 , 5 do 

    local map = {}
    local count = 0
    for i = 0,1600 do 
        
        local name = get_reward_name(unit_reward['进攻怪'])
        if name then 
            local num = map[name] or 0
            num = num + 1
            map[name] = num
        end
       
    end 
    for name,num in pairs(map) do 
        print(name,num)
    end 

    print('------------------------')

    local map = {}
    local count = 0
    for i = 0,1600 do 
        local rand = math.random(100)
        if rand <= 2 then 
            local list = {}
            get_reward_name_list(unit_reward['复生野怪'],list,0)
            for index,name in ipairs(list) do 
                local num = map[name] or 0
                num = num + 1
                map[name] = num 
            end 
            count = count + 1
        end
    end 
    print("数量为",count)
    for name,num in pairs(map) do 
        print(name,num)
    end 

    print("============================")
end 
]]