

--按照装备品阶 筛选出 lni 装备。
--quality_item={'白' = {'新手剑','新手戒指'},'蓝' = {..}}
-- local quality_item ={}
-- local all_item = {}
-- for name,data in pairs(ac.table.ItemData) do 
--     local color = data.color 
--     if color then 
--         if data.item_type == '装备' or data.item_type == '消耗品'   then
--             if not quality_item[color] then 
--                 quality_item[color] = {}
--             end    
--             table.insert(quality_item[color],name)
--             --打印 可合成或是掉落的物品 
--             -- print(name,color)
--             table.insert(all_item,name)
--         end    
--     end 
-- end

-- for k,v in pairs(quality_item) do 
--     table.sort(v,function (strA,strB)
--         return strA < strB
--     end)
-- end    
-- table.sort(ac.all_item,function (strA,strB)
--     return strA<strB
-- end)

--英雄技能，钥匙怪掉落表
ac.skill_list2 = ac.skill_list2

local function item_self_skill(item,unit,time)
    local timer = ac.wait((time or 100) * 1000,function (timer)
        -- print(123333,item.owner)
        if item.owner == nil then 
            item:item_remove()
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
        ['橙'] = { r = 255, g = 204, b = 0,},
        ['棕'] = { r = 166, g = 125, b = 61,},
        ['粉'] = { r = 188, g = 143, b = 143,},
        ['白'] = { r = 255, g = 255, b = 255,},
        ['黑'] = { r = 136, g = 58, b = 0,},
        ['金'] = { r = 255, g = 255, b = 0,},
        ['灰'] = { r = 204, g = 204, b = 204,},
        ['神'] = { r = 223, g = 25, b = 208,},
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

ac.on_texttag =  on_texttag

--先列出所有奖励 再按概率抽取
local reward = {
    ['符文'] = function (player,hero,unit,level)
        local list = {'力量符文','敏捷符文','智力符文','血质符文','魔力符文','生命符文','魔法符文'}
        local name = list[math.random(#list)] .. level 
        local x,y = unit:get_point():get() 
        local item = hero:add_item(name)
    end,

    ['随机白装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['白']
        if list == nil then 
            print('没有白色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            --宠物打死的也掉人身上
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end    
    end,
    ['随机蓝装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['蓝']
        if list == nil then 
            print('没有蓝色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,


    ['随机金装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['金']
        if list == nil then 
            print('没有金色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,

    ['随机红装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['红']
        if list == nil then 
            print('没有红色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
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
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_skill_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            ac.item.add_skill_item(name,hero)
        end 
    end,
    ['吞噬丹'] = function (player,hero,unit,is_on_hero)
        local name = '吞噬丹'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['点金石'] = function (player,hero,unit,is_on_hero)
        local name = '点金石'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['召唤boss'] = function (player,hero,unit,is_on_hero)
        local name = '召唤boss'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['召唤练功怪'] = function (player,hero,unit,is_on_hero)
        local name = '召唤练功怪'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,


}
ac.reward = reward


local unit_reward = {
    ['武器boss1'] = {{rand =100,name = '凝脂剑'}},
    ['武器boss2'] = {{rand =100,name = '元烟剑'}},
    ['武器boss3'] = {{rand =100,name = '暗影'}},
    ['武器boss4'] = {{rand =100,name = '青涛魔剑'}},
    ['武器boss5'] = {{rand =100,name = '青虹紫霄剑'}},
    ['武器boss6'] = {{rand =100,name = '熔炉炎刀'}},
    ['武器boss7'] = {{rand =100,name = '紫炎光剑'}},
    ['武器boss8'] = {{rand =100,name = '封神冰心剑'}},
    ['武器boss9'] = {{rand =100,name = '冰莲穿山剑'}},
    ['武器boss10'] = {{rand =100,name = '十绝冰火剑'}},
    ['武器boss11'] = {{rand =100,name = '九幽白蛇剑'}},

    ['防具boss1'] = {{rand =100,name = '芙蓉甲'}},
    ['防具boss2'] = {{rand =100,name = '鱼鳞甲'}},
    ['防具boss3'] = {{rand =100,name = '碧云甲'}},
    ['防具boss4'] = {{rand =100,name = '青霞甲'}},
    ['防具boss5'] = {{rand =100,name = '飞霜辉铜甲'}},
    ['防具boss6'] = {{rand =100,name = '天魔苍雷甲'}},
    ['防具boss7'] = {{rand =100,name = '金刚断脉甲'}},
    ['防具boss8'] = {{rand =100,name = '丹霞真元甲'}},
    ['防具boss9'] = {{rand =100,name = '血焰赤阳甲'}},
    ['防具boss10'] = {{rand =100,name = '神魔蚀日甲'}},
    ['防具boss11'] = {{rand =100,name = '皇龙阴阳甲'}},

    ['技能BOSS1'] = {{rand =100,name = '技能升级书Lv1'}},
    ['技能BOSS2'] = {{rand =100,name = '技能升级书Lv2'}},
    ['技能BOSS3'] = {{rand =100,name = '技能升级书Lv3'}},
    ['技能BOSS4'] = {{rand =100,name = '技能升级书Lv4'}},

    ['洗练石boss1'] = {{rand =100,name = '一号洗练石'}},
    ['洗练石boss2'] = {{rand =100,name = '二号洗练石'}},
    ['洗练石boss3'] = {{rand =100,name = '三号洗练石'}},
    ['洗练石boss4'] = {{rand =100,name = '四号洗练石'}},

    ['肉山'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['梦魇'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['戈登的激情'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['焰皇'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['毁灭者'] =  {{ rand = 25,      name = '吞噬丹'}},

    ['奶牛'] = {
        {rand =0.3,name = '初级扭蛋券(十连抽)'},
        {rand =0.3,name = '初级扭蛋券(百连抽)'},
        {rand =0.3,name = '高级扭蛋券'},
        {rand =0.3,name = '高级扭蛋券(十连抽)'},
        {rand =0.3,name = '高级扭蛋券(百连抽)'},
    },

    
    ['进攻怪'] =  {
        -- { rand = 97.5,         name = '无'},
        { rand = 2.5,      name = {
                { rand = 75, name = '随机白装'},
                { rand = 20, name = '随机蓝装'},
                { rand = 4, name = '随机金装'},
                { rand = 1, name = '随机红装'},
            }
        },
        { rand = 0.01,      name = '吞噬丹'},
        { rand = 0.04,      name = '点金石'},
        { rand = 0.01,      name = '随机技能'}
    },
    ['随机物品'] =  {
        { rand = 100,      name = {
                { rand = 80, name = '随机白装'},
                { rand = 16, name = '随机蓝装'},
                { rand = 3.3, name = '随机金装'},
                { rand = 0.7, name = '随机红装'},
            }
        }
    },
    ['钥匙怪'] =  {
        {    rand = 30, name = '金币30' },
        {    rand = 30, name = '经验30',},
        {    rand = 5, name = '召唤boss',},
        {    rand = 1, name = '吞噬丹',},
        {    rand = 5, name = '杀怪加全属性5',},
        {    rand = 5, name = '全属性1000',},
        {    rand = 1, name = '全属性10000',},
        {    rand = 8, name = '护甲加50',},
        {    rand = 5, name = '杀怪加力量10',},
        {    rand = 5, name = '杀怪加敏捷10',},
        {    rand = 5, name = '杀怪加智力10',},
    },

    ['商店随机技能'] =  {
        { rand = 100,      name = '随机技能'}
    },
    ['商店随机物品'] =  {
        { rand = 100,      name = {
                { rand = 80, name = '白'},
                { rand = 16, name = '蓝'},
                { rand = 3.3, name = '金'},
                { rand = 0.7, name = '红'},
            }
        }
    },
    ['随机神符'] =  {
        {    rand = 11, name = '无敌' },
        {    rand = 11, name = '治疗',},
        {    rand = 11, name = '暴击',},
        {    rand = 11, name = '攻击',},
        {    rand = 11, name = '法术',},
        {    rand = 11, name = '减甲',},
        {    rand = 11, name = '中毒',},
        {    rand = 11, name = '沉默',},
        {    rand = 12, name = '定身',},
    },
    ['藏宝图'] =  {
        -- 75	什么事情都没有发生，挖宝经验（可存档）+1，当前挖宝经验XX		
        -- 10	随机物品，全随机，不分品质		
        -- 10	随机技能		
        -- 0.75	杀怪加力量+5	攻击加力量+15	每秒加力量+25
        -- 0.75	杀怪加敏捷+5	攻击加敏捷+15	每秒加敏捷+25
        -- 0.75	杀怪加智力+5	攻击加智力+15	每秒加智力+52
        -- 0.75	杀怪加攻击+5	每秒加攻击+50	
        -- 0.75	每秒加护甲0.25		
        -- 0.5	宠物经验书（小）		
        -- 0.5	宠物经验书（大）		
        -- 0.25	挖宝达人：500万全属性，物品获取率+50%		

        {    rand = 51, name = '无' },
        {    rand = 10, name = '随机物品',},
        {    rand = 15, name = '随机技能',},
        {    rand = 1.5, name = '杀怪加力量+400 攻击加力量+1200 每秒加力量+2000' },
        {    rand = 1.5, name = '杀怪加敏捷+400 攻击加敏捷+1200 每秒加敏捷+2000',},
        {    rand = 1.5, name = '杀怪加智力+400 攻击加智力+1200 每秒加智力+2000',},
        {    rand = 1.5, name = '杀怪加全属性+200 攻击加全属性+600 每秒加全属性+1000',},
        {    rand = 1.5, name = '杀怪加攻击+600 每秒加攻击+3000',},
        {    rand = 1.5, name = '每秒加护甲+5',},
        {    rand = 1.5, name = '攻击减甲+30',},
        {    rand = 1, name = '宠物经验书（小）',},
        {    rand = 1, name = '宠物经验书（大）',},
        {    rand = 2, name = '火灵',},
        {    rand = 2, name = '木头',},
        {    rand = 1.5, name = '挖宝达人',}, --500万全属性，物品获取率+50%	
        {    rand = 0.5, name = '格里芬',}, --lv1
        {    rand = 0.5, name = '黑暗项链',}, --lv2
        {    rand = 0.5, name = '最强生物心脏',}, --lv1
        {    rand = 0.5, name = '白胡子的大刀',}, --lv2
        {    rand = 1, name = '碎片幼儿园',}, --lv2
        {    rand = 1, name = 'ONE_PIECE',}, --lv2
        {    rand = 1, name = '法老的遗产',}, --lv2

        {    rand = 1, name = '家里有矿',}, --超级彩蛋
        
    },
    ['抽奖券'] =  {
        {    rand = 70,  name ={
                { rand = 0.5, name = '欧皇达人'},
                { rand = 99.5, name = '无'}, 
            }
        },
        {    rand = 5, name = '金币' },
        {    rand = 5, name = '经验',},
        {    rand = 10, name = '随机物品',},
        {    rand = 4, name = '随机技能',},
        {    rand = 1, name = '召唤boss',},
        {    rand = 1, name = '召唤练功怪',},
        {    rand = 1, name = '吞噬丹',},
        {    rand = 1, name = '宠物经验书',},
        {    rand = 2, name = '随机恶魔果实',},
    },
    ['初级扭蛋'] = {
        {    rand = 31.341, name = '空蛋' },

        {    rand = 4, name = '火灵',},
        {    rand = 4, name = '木头',},

        {    rand = 4, name = '力量+17500' },
        {    rand = 4, name = '敏捷+17500',},
        {    rand = 4, name = '智力+17500',},
        {    rand = 4, name = '杀怪加力量+2',},
        {    rand = 4, name = '杀怪加敏捷+2',},
        {    rand = 4, name = '杀怪加智力+2',},
        {    rand = 4, name = '攻击加力量+6',},
        {    rand = 4, name = '攻击加敏捷+6',},
        {    rand = 4, name = '攻击加智力+6',},
        {    rand = 4, name = '每秒加力量+10',},
        {    rand = 4, name = '每秒加敏捷+10',},
        {    rand = 4, name = '每秒加智力+10',},

        {    rand = 0.07, name = '力量+350000' },
        {    rand = 0.07, name = '敏捷+350000',},
        {    rand = 0.07, name = '智力+350000',},
        {    rand = 0.07, name = '杀怪加力量+20',},
        {    rand = 0.07, name = '杀怪加敏捷+20',},
        {    rand = 0.07, name = '杀怪加智力+20',},
        {    rand = 0.07, name = '攻击加力量+60',},
        {    rand = 0.07, name = '攻击加敏捷+60',},
        {    rand = 0.07, name = '攻击加智力+60',},
        {    rand = 0.07, name = '每秒加力量+100',},
        {    rand = 0.07, name = '每秒加敏捷+100',},
        {    rand = 0.07, name = '每秒加智力+100',},

        {    rand = 0.007, name = '力量+3500000' },
        {    rand = 0.007, name = '敏捷+3500000',},
        {    rand = 0.007, name = '智力+3500000',},
        {    rand = 0.007, name = '杀怪加力量+200',},
        {    rand = 0.007, name = '杀怪加敏捷+200',},
        {    rand = 0.007, name = '杀怪加智力+200',},
        {    rand = 0.007, name = '攻击加力量+600',},
        {    rand = 0.007, name = '攻击加敏捷+600',},
        {    rand = 0.007, name = '攻击加智力+600',},
        {    rand = 0.007, name = '每秒加力量+1000',},
        {    rand = 0.007, name = '每秒加敏捷+1000',},
        {    rand = 0.007, name = '每秒加智力+1000',},

        {    rand = 1.4, name = '攻击+400000',},
        {    rand = 1.4, name = '杀怪加攻击+10',},
        {    rand = 1.4, name = '每秒加攻击+40',},
        {    rand = 0.07, name = '攻击+2000000',},
        {    rand = 0.07, name = '杀怪加攻击+40',},
        {    rand = 0.07, name = '每秒加攻击+200',},
        {    rand = 0.007, name = '攻击+20000000',},
        {    rand = 0.007, name = '杀怪加攻击+400',},
        {    rand = 0.007, name = '每秒加攻击+2000',},

        {    rand = 1.4, name = '护甲+50',},
        {    rand = 1.4, name = '每秒加护甲+0.1',},
        {    rand = 0.07, name = '护甲+200',},
        {    rand = 0.07, name = '每秒加护甲+0.2',},
        {    rand = 0.007, name = '护甲+2000',},
        {    rand = 0.007, name = '每秒加护甲+2',},

        {    rand = 1, name = '宠物经验书(小)',},
        -- {    rand = 0.01, name = '吞噬丹',},
        {    rand = 0.01, name = '随机技能',},
        {    rand = 0.8, name = '随机物品',}, --和商店一样 '凝脂剑','元烟剑','暗影','青涛魔剑','青虹紫霄剑'
        {    rand = 0.1, name = '神兵',},--lv1-lv5
        {    rand = 0.1, name = '神甲',},--lv1-lv5
        {    rand = 0.15, name = '技能升级书Lv1',}, --lv1
        {    rand = 0.15, name = '技能升级书Lv2',}, --lv2
        {    rand = 0.02, name = '一号洗练石',},
        {    rand = 0.02, name = '二号洗练石',},

        {    rand = 0.12, name = '红色小水滴',},--红色小水滴 吸血+10% 攻击回血+500000
        {    rand = 0.12, name = '黄金罗盘',},--暴击几率+2.5%，暴击加深+35%
        {    rand = 0.12, name = '发光的草药',},--免伤几率+5%，每秒回血+5%
        {    rand = 0.12, name = '奇美拉的头颅',},--分裂伤害+50%，攻击速度+50%

        {    rand = 0.02, name = '倒霉蛋',},--木头+5555，火灵+5555，杀敌数+5555
        {    rand = 0.1, name = '矮人的火枪',},--木头+5555，火灵+5555，杀敌数+5555
    },
    ['高级扭蛋'] = {
        {    rand = 29.481, name = '空蛋' },

        {    rand = 2.5, name = '火灵',},
        {    rand = 2.5, name = '木头',},

        {    rand = 4, name = '力量+250000' },
        {    rand = 4, name = '敏捷+250000',},
        {    rand = 4, name = '智力+250000',},
        {    rand = 4, name = '杀怪加力量+30',},
        {    rand = 4, name = '杀怪加敏捷+30',},
        {    rand = 4, name = '杀怪加智力+30',},
        {    rand = 4, name = '攻击加力量+90',},
        {    rand = 4, name = '攻击加敏捷+90',},
        {    rand = 4, name = '攻击加智力+90',},
        {    rand = 4, name = '每秒加力量+150',},
        {    rand = 4, name = '每秒加敏捷+150',},
        {    rand = 4, name = '每秒加智力+150',},

        {    rand = 0.07, name = '力量+5000000' },
        {    rand = 0.07, name = '敏捷+5000000',},
        {    rand = 0.07, name = '智力+5000000',},
        {    rand = 0.07, name = '杀怪加力量+500',},
        {    rand = 0.07, name = '杀怪加敏捷+500',},
        {    rand = 0.07, name = '杀怪加智力+500',},
        {    rand = 0.07, name = '攻击加力量+1500',},
        {    rand = 0.07, name = '攻击加敏捷+1500',},
        {    rand = 0.07, name = '攻击加智力+1500',},
        {    rand = 0.07, name = '每秒加力量+2500',},
        {    rand = 0.07, name = '每秒加敏捷+2500',},
        {    rand = 0.07, name = '每秒加智力+2500',},

        {    rand = 0.007, name = '力量+30000000' },
        {    rand = 0.007, name = '敏捷+30000000',},
        {    rand = 0.007, name = '智力+30000000',},
        {    rand = 0.007, name = '杀怪加力量+5000',},
        {    rand = 0.007, name = '杀怪加敏捷+5000',},
        {    rand = 0.007, name = '杀怪加智力+5000',},
        {    rand = 0.007, name = '攻击加力量+15000',},
        {    rand = 0.007, name = '攻击加敏捷+15000',},
        {    rand = 0.007, name = '攻击加智力+15000',},
        {    rand = 0.007, name = '每秒加力量+25000',},
        {    rand = 0.007, name = '每秒加敏捷+25000',},
        {    rand = 0.007, name = '每秒加智力+25000',},

        {    rand = 2, name = '攻击+2500000',},
        {    rand = 2, name = '杀怪加攻击+200',},
        {    rand = 2, name = '每秒加攻击+1000',},
        {    rand = 0.07, name = '攻击+25000000',},
        {    rand = 0.07, name = '杀怪加攻击+2000',},
        {    rand = 0.07, name = '每秒加攻击+10000',},
        {    rand = 0.007, name = '攻击+200000000',},
        {    rand = 0.007, name = '杀怪加攻击+20000',},
        {    rand = 0.007, name = '每秒加攻击+100000',},

        {    rand = 2, name = '护甲+300',},
        {    rand = 2, name = '每秒加护甲+0.6',},
        {    rand = 0.07, name = '护甲+3000',},
        {    rand = 0.07, name = '每秒加护甲+6',},
        {    rand = 0.007, name = '护甲+30000',},
        {    rand = 0.007, name = '每秒加护甲+60',},

        {    rand = 0.5, name = '宠物经验书(大)',},
        {    rand = 0.05, name = '吞噬丹',},
        {    rand = 0.2, name = '随机技能',},
        {    rand = 2, name = '随机物品',}, --和商店一样 '凝脂剑','元烟剑','暗影','青涛魔剑','青虹紫霄剑'
        {    rand = 0.1, name = '神兵',},--lv6-lv10
        {    rand = 0.1, name = '神甲',},--lv6-lv10
        {    rand = 0.15, name = '技能升级书Lv3',}, --lv1
        {    rand = 0.15, name = '技能升级书Lv4',}, --lv2
        {    rand = 0.02, name = '三号洗练石',},
        {    rand = 0.02, name = '四号洗练石',},

        {    rand = 0.5, name = '格里芬',}, --lv1
        {    rand = 0.5, name = '黑暗项链',}, --lv2
        {    rand = 0.5, name = '最强生物心脏',}, --lv1
        {    rand = 0.5, name = '白胡子的大刀',}, --lv2


        {    rand = 0.12, name = '玻璃大炮',},--红色小水滴 吸血+10% 攻击回血+500000
        {    rand = 0.12, name = '发光的蓝色灰烬',},--暴击几率+2.5%，暴击伤害+25%
        {    rand = 0.12, name = '诸界的毁灭者',},--免伤几率+5%，每秒回血+5%
        {    rand = 0.12, name = '末日的钟摆',},--分裂伤害+50%，攻击速度+50%

        {    rand = 0.02, name = '游戏王',},--木头+5555，火灵+5555，杀敌数+5555
        {    rand = 0.1, name = '龙族血统',},--木头+5555，火灵+5555，杀敌数+5555
    },

    ['炼化异火'] =  {
        {    rand = 20, name = '凡' },
        {    rand = 45, name = '玄' },
        {    rand = 20, name = '地',},
        {    rand = 15, name = '天',},
    },    

    ['星星之火守卫'] = {{rand =11,name = '星星之火碎片'}},
    ['陨落心炎守卫'] = {{rand =10,name = '陨落心炎碎片'}},
    ['三千焱炎火守卫'] = {{rand =9,name = '三千焱炎火碎片'}},
    ['虚无吞炎守卫'] = {{rand =8,name = '虚无吞炎碎片'}},

    ['星星之火boss'] = {
        {rand =50,name = '星星之火碎片*4'},
        {rand =50,name = '星星之火碎片*8'},
    },
    ['陨落心炎boss'] = {
        {rand =50,name = '陨落心炎碎片*4'},
        {rand =50,name = '陨落心炎碎片*8'}
    },
    ['三千焱炎火boss'] = {
        {rand =50,name = '三千焱炎火碎片*4'},
        {rand =50,name = '三千焱炎火碎片*8'},
    },
    ['虚无吞炎boss'] = {
        {rand =50,name = '虚无吞炎碎片*4'},
        {rand =50,name = '虚无吞炎碎片*8'},
    },
    ['陀舍古帝守卫'] = {
        {rand =50,name = '陀舍古帝碎片*4'},
        {rand =50,name = '陀舍古帝碎片*8'},
    },
    ['无尽火域守卫'] = {
        {rand =50,name = '无尽火域碎片*4'},
        {rand =50,name = '无尽火域碎片*8'},
    },

    ['强盗领主'] = {{rand =100,name = '藏宝图'}},
    ['强盗'] = {{rand =3,name = '藏宝图'}},
    
    ['红发'] = {{rand =100,name = '格里芬'}},
    ['黑胡子'] = {{rand =100,name = '黑暗项链'}},
    ['百兽'] = {{rand =100,name = '最强生物心脏'}},
    ['白胡子'] = {{rand =100,name = '白胡子的大刀'}},

    ['鸡'] = {
        {rand =0.2,name = '完美的鸡汤'},
        {rand =0.2,name = '完美的鸡头'},
        {rand =0.2,name = '完美的鸡翅'},
        {rand =0.2,name = '完美的鸡腿'},
        {rand =0.2,name = '完美的鸡蛋'},
    },
    
    ['井底之蛙'] =  {
        { rand = 5, name = '金'},
        { rand = 5, name = '红'},
        { rand = 5, name = '随机技能书'},
        { rand = 5, name = '点金石'},
        { rand = 5, name = '恶魔果实'},
        { rand = 5, name = '吞噬丹'},
        { rand = 5, name = '格里芬'},
        { rand = 5, name = '黑暗项链'},
        { rand = 5, name = '最强生物心脏'},
        { rand = 5, name = '白胡子的大刀'},
        { rand = 10, name = '井底之蛙'},
        { rand = 40, name = '无'},
    },

   
}
ac.unit_reward = unit_reward

--递归匹配唯一奖励
local function get_reward_name(tbl)
    local rand = math.random(1,100000) / 1000
    local num = 0
    for index,info in ipairs(tbl) do 
        num = num + info.rand 
        -- print("打印装备掉落概率",info.rand)
        if rand <= num then 
            if type(info.name) == 'string' then 
                return info.name,info.rand 
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
    local rand = math.random(1,100000) / 1000

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
    --吞噬丹几率过高
    change_unit_reward[1].rand = fall_rate
    -- for index,info in ipairs(change_unit_reward) do 
    --     change_unit_reward[1].rand = fall_rate
    -- end    
    local name = get_reward_name(change_unit_reward)
    if name then 
        -- print('掉落物品类型',name)
        local func = reward[name]
        if func then 
            -- print('掉落',name)
            func(player,hero,unit,is_on_hero)
        end 
    end 
    return name 
end 
ac.hero_kill_unit = hero_kill_unit

--死亡掉落
ac.game:event '单位-死亡' (function (_,unit,killer)  
    if unit:is_hero() then 
        return 
    end 
    --无尽后，死亡不掉落任何东西
    if ac.creep['刷怪-无尽1'].index >= 1 then 
        return 
    end
    local player = killer:get_owner()
    local dummy_unit = player.hero or ac.dummy
    -- 进攻怪 和 boss 掉落 日常掉落物品
    if unit.category and unit.category =='进攻怪' or unit.category =='boss'  then
        local fall_rate = unit.fall_rate *( 1 + dummy_unit:get('物品获取率')/100 )
        -- print('装备掉落概率：',fall_rate,unit.fall_rate)
        hero_kill_unit(player,killer,unit,fall_rate)
    end

    --boss 额外掉落物品
    local tab = unit_reward[unit:get_name()]
    if not tab then 
        return 
    end    
    --藏宝图概率提升
    if unit:get_name() == '强盗' then 
        tab[1].rand  = 2 * (1 + (player.up_fall_wabao or 0)/100)
    end    
    local name = get_reward_name(tab) 
    if name then 
        if finds(name,'*') then 
            local _, _, it_name, cnt = string.find(name,"(%S+)%*(%d+)")
            --进行多个处理
            for i=1,tonumber(cnt) do 
                ac.item.create_item(it_name,unit:get_point()) 
            end    
        else
            ac.item.create_item(name,unit:get_point())     
        end    
    end    


end)

--物品掉落，主动发起掉落而不是单位死亡时掉落 。
-- 应用：张全蛋技能 妙手空空
ac.game:event '物品-偷窃' (function (_,unit,killer)
    if unit.category ~='进攻怪' or (unit.data and unit.data.type =='boss' ) then
		return
    end
    ac.game['偷窃'] = true
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

    if unit.category ~='进攻怪' then
		return
    end

    ac.game['偷窃'] = true
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

--自动优化内存，1小时后自动开启，物品3分钟后清理
-- local time = 30
-- local auto_clean_time = 30
-- ac.wait(time*1000,function() 
--     ac.flag_auto_item_recycle = true
--     --设置多面板数据
--     ac.game.multiboard:set_auto_tip()
--     --3分钟后，清理一次物品
--     ac.wait(auto_clean_time*1000,function()
--         ac.game:clear_item()
--     end)    
-- end)


ac.game:event '物品-创建'  (function (_,item)
    if not item then return end 
    if ac.flag_auto_item_recycle then 
        --练功房的物品除外
        if not ac.game:is_in_room(item) then 
            item.time_removed = auto_clean_time
        end    
    end    
    if item.time_removed then 
        item_self_skill(item,nil,item.time_removed)
    end    
end)
ac.game:event '单位-获得物品后' (function (_,unit,item)
    local timer = item._self_skill_timer 
    if timer then 
        timer:remove()
        item._self_skill_timer = nil 
    end 
end)

-- ac.game:event '单位-丢弃物品后' (function (_,unit,item)
--     if not item then return end 
--     if ac.flag_auto_item_recycle then 
--         --练功房的物品除外
--         -- print(item.name)
--         if not ac.game:is_in_room(item) then 
--             item.time_removed = auto_clean_time
--         end    
--     end    
--     if item.time_removed then 
--         item_self_skill(item,nil,item.time_removed)
--     end       
-- end)




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