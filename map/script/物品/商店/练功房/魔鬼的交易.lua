
local rect = require 'types.rect'


-- 传送 快速达到 兑换 交易
local devil_deal ={
    --商品名（map.table.单位.商店）,是否激活 属性名，数值，耗费币种，数值，图标,说明
    [1] = {
{'无所不在lv1',false,'分裂伤害',5,'金币',1000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv1|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]
},

{'无所不在lv2',false,'分裂伤害',5,'金币',5000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv2|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv3',false,'分裂伤害',5,'金币',10000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv3|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv4',false,'分裂伤害',5,'金币',25000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv4|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv5',false,'分裂伤害',5,'金币',50000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv5|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv6',false,'攻击速度',5,'金币',70000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv6|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv7',false,'攻击速度',5,'金币',80000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv7|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv8',false,'攻击速度',5,'金币',90000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv8|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lv9',false,'攻击速度',5,'金币',100000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv9|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

{'无所不在lvmax',false,'攻击速度',5,'金币',200000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lvmax|r

|cffFFE799【奖励】|r|cff00ff00+5%攻速|r

]]},

} ,

    [2] = {
{'无所不知lv1',false,'攻击',500000,'木头',20,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+50w攻击|r
    ]]},

{'无所不知lv2',false,'每秒加攻击',300,'木头',40,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv3',false,'杀怪加攻击',30,'木头',60,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv4',false,'每秒加攻击',300,'木头',80,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv5',false,'杀怪加攻击',30,'木头',100,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv6',false,'攻击',500000,'木头',120,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+50w攻击|r
    ]]},

 {'无所不知lv7',false,'每秒加攻击',300,'木头',140,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lv8',false,'杀怪加攻击',30,'木头',160,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
    ]]},

{'无所不知lv9',false,'每秒加攻击',300,'木头',180,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加攻击|r
    ]]},

{'无所不知lvmax',false,'杀怪加攻击',30,'木头',200,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加攻击|r
   ]]},
},

[3] = {
{'无所不贪lv1',false,'杀怪加全属性',25,'全属性',100000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+25杀怪加全属性|r
    ]]},

{'无所不贪lv2',false,'攻击加全属性',125,'全属性',200000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+125攻击加全属性|r
    ]]},

{'无所不贪lv3',false,'每秒加全属性',250,'全属性',300000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+250每秒加全属性|r
    ]]},

{'无所不贪lv4',false,'杀怪加全属性',50,'全属性',400000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+50杀怪加全属性|r
    ]]},

{'无所不贪lv5',false,'攻击加全属性',250,'全属性',500000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+250攻击加全属性|r
    ]]},

{'无所不贪lv6',false,'每秒加全属性',500,'全属性',600000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+500每秒加全属性|r
    ]]},

 {'无所不贪lv7',false,'杀怪加全属性',750,'全属性',700000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+75杀怪加全属性|r
    ]]},

{'无所不贪lv8',false,'攻击加全属性',375,'全属性',800000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+375攻击加全属性|r
    ]]},

{'无所不贪lv9',false,'每秒加全属性',750,'全属性',900000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+750每秒加全属性|r
    ]]},

{'无所不贪lvmax',false,'全伤加深',2.5,'全属性',1000000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%全伤加深|r
   ]]},
},

[4] = {
{'无所不能lv1',false,'吸血',10,'火种',1000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+10%吸血|r
    ]]},

{'无所不能lv2',false,'攻击减甲',10,'火种',2000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+10攻击减甲|r
    ]]},

{'无所不能lv3',false,'触发概率加成',5,'火种',3000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+5%触发概率加成|r
    ]]},

{'无所不能lv4',false,'技能冷却',5,'火种',4000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00-5%技能冷却|r
    ]]},

{'无所不能lv5',false,'每秒回血',5,'火种',5000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+5%每秒回血|r
    ]]},

{'无所不能lv6',false,'暴击几率',2.5,'火种',6000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%暴击几率|r
    ]]},

 {'无所不能lv7',false,'暴击加深',25,'火种',7000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+25%暴击加深|r
    ]]},

{'无所不能lv8',false,'技暴几率',2.5,'火种',8000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%技暴几率|r
    ]]},

{'无所不能lv9',false,'技暴加深',25,'火种',9000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+25%技暴加深|r
    ]]},

{'无所不能lvmax',false,'全伤加深',2.5,'火种',10000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%全伤加深|r
   ]]},
},

[5] = {
{'脚踩祥云lv1',false,'护甲',1000,'木头',2000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+1000护甲|r
    ]]},

{'脚踩祥云lv2',false,'护甲',2000,'木头',4000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+2000护甲|r
    ]]},

{'脚踩祥云lv3',false,'护甲',3000,'木头',6000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+3000护甲|r
    ]]},

{'脚踩祥云lv4',false,'杀怪加全属性',100,'木头',8000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+100杀怪加全属性|r
    ]]},

{'脚踩祥云lv5',false,'攻击加全属性',500,'木头',10000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+500攻击加全属性|r
    ]]},

{'脚踩祥云lv6',false,'每秒加全属性',1000,'木头',12000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+1000每秒加全属性|r
    ]]},

 {'脚踩祥云lv7',false,'杀怪加攻击',300,'木头',14000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+300杀怪加攻击|r
    ]]},

{'脚踩祥云lv8',false,'每秒加攻击',3000,'木头',16000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+3000每秒加攻击|r
    ]]},

{'脚踩祥云lv9',false,'物品获取率',15,'木头',18000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+15%物品获取率|r
    ]]},

{'脚踩祥云lvmax',false,'火种加成',15,'木头',20000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+15%火种加成|r
   ]]},
},

[6] = {
{'头顶乾坤lv1',false,'免伤',2.5,'火种',3000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%免伤|r
    ]]},

{'头顶乾坤lv2',false,'每秒回血',5,'火种',6000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+5%每秒回血|r
    ]]},

{'头顶乾坤lv3',false,'闪避',2.5,'火种',9000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%闪避|r
    ]]},

{'头顶乾坤lv4',false,'触发概率加成',5,'火种',12000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+5%触发概率加成|r
    ]]},

{'头顶乾坤lv5',false,'免伤几率',2.5,'火种',15000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%免伤几率|r
    ]]},

{'头顶乾坤lv6',false,'暴击几率',2.5,'火种',18000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%暴击几率|r
    ]]},

 {'头顶乾坤lv7',false,'暴击加深',25,'火种',21000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+25%暴击加深|r
    ]]},

{'头顶乾坤lv8',false,'技暴几率',2.5,'火种',24000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%技暴几率|r
    ]]},

{'头顶乾坤lv9',false,'技暴加深',25,'火种',27000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+25%技暴加深|r
    ]]},

{'头顶乾坤lvmax',false,'对boss额外伤害',5,'火种',30000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+5%对boss额外伤害|r
   ]]},
},
}
ac.devil_deal = devil_deal
--根据重数 给商店添加10技能，并让第一技能为可点击状态
--单位，重数
local function add_skill_by_lv(shop,lv)
    if not devil_deal[lv] then 
        return 
    end    
    for num,value in ipairs(devil_deal[lv]) do    
        if num <= 4 then 
            -- print(value[1])
            shop:add_skill(value[1],'英雄',num + 8 )
        elseif num <= 8 then 
            shop:add_skill(value[1],'英雄',num)
        else
            shop:add_skill(value[1],'英雄',num - 8)
        end   
        if num ==1 then 
            local skl = shop:find_skill(value[1],'英雄',true)
            skl:set_level(1)
        end 
    end   
end   

local mt = ac.skill['魔鬼的交易']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[mgdjy.blp]],
    title = name,
    tip = '\n查看 |cff00ff00魔鬼的交易\n|r',
}
for _,tab in ipairs(devil_deal) do 
    if not mt.skills then 
        mt.skills ={}
    end    
    local name = string.sub(tab[_][1],1,12)
    --每重魔法书
    table.insert(mt.skills,name)

    print('魔鬼的交易',name)
    local mt2 = ac.skill[name]
    mt2{
        is_spellbook = 1,
        is_order = 2,
        art = tab[_][7],
        title = name,
        tip = '\n查看 |cff00ff00'.. name ..'\n|r',
    }
    if not mt2.skills then 
        mt2.skills ={}
    end    
    for num,value in ipairs(tab) do 
        --插入到魔法书
        table.insert(mt2.skills,value[1])
        --物品名称
        local mt = ac.skill[value[1]]
        mt{
        --等久
        level = 0,
        --图标
        art = value[7],
        --说明
        tip = value[8],
        ---- 属性名
        -- attr_name = value[3],
        -- --属性值
        -- attr_val = value[4],
        [value[3]] = value[4],
        --物品类型
        item_type = '神符',
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        --施法动作
        cast_animation = '',
        --冷却
        cool = 0,
        show_tip = function(self)
            local str = ''
            if self.gold then 
                str = '' .. self.gold .. '金币'
            end   
            if self.kill_count then 
                str = '消耗杀敌数' .. self.kill_count 
            end   
            if self.wood then 
                str = '' .. self.wood .. '木头'
            end    
            if self.cost_allattr then 
                str = '' .. self.cost_allattr .. '全属性'
            end    
            if self.fire_seed then 
                str = '' .. self.fire_seed .. '火种'
            end    
            return str
        end,
        content_tip = '',
        is_skill = true,
        }
        
        if value[5]=='金币' then
            mt.gold = tonumber(value[6])
        end
        if value[5]=='杀敌数' then
            mt.kill_count = tonumber(value[6])
        end
        if value[5]=='木头' then
            mt.wood = tonumber(value[6])
        end   
        if value[5]=='全属性' then
            mt.cost_allattr = tonumber(value[6])
        end   
        if value[5]=='火种' then
            mt.fire_seed = tonumber(value[6])
        end   

        --模拟商店点击
        function mt:on_cast_shot()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.owner
            hero = p.hero
            local name = self.name 

            --如果所有者就是英雄，则返回
            if hero == self.owner then 
                --停止继续执行   
                self:stop()
                return 
            end
            
            -- print(owner_value,self.cost_allattr)
            if self.cost_allattr then 
                local owner_value = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
                -- print(owner_value,self.cost_allattr)
                --有足够的全属性
                if owner_value > self.cost_allattr  then 
                    self.seller = seller
                    --扣除全属性
                    hero:add('全属性',-self.cost_allattr)
                    --给与奖励
                    self:on_cast_finish()
                else
                    p:sendMsg('全属性不足',10) 
                end  
                --停止继续执行   
                self:stop()
                return  
            end

            local item = setmetatable(self,ac.item)
            item.name = name
            hero:event_notify('单位-点击商店物品',seller,hero,item)
            self.owner = seller
            --停止继续执行
            self:stop()
        end
        --商品实际被点击时的执行效果
        function mt:on_cast_finish()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.seller
            hero = p.hero
            -- print('施法结束啦')
            --增加属性
            -- print(self.attr_name,self.attr_val)
            -- hero:add(self.attr_name,self.attr_val)
            --处理下一个
            --local next = self.position + 1 
            -- self:remove()
            -- print(seller,hero,self.name)
            seller:remove_skill(self.name)
            local skl_name = ''
            if num == #tab then 
                add_skill_by_lv(seller,_+1)
            else
                skl_name = tab[num +1][1] --下一个技能名
            end   
            -- 激活下商店下一个属性 
            local skl = seller:find_skill(skl_name,'英雄',true)
            if skl then 
                skl:set_level(1)
            end    
            --激活人身上的技能及属性
            local skl = hero:find_skill(self.name,nil,true)
            if skl then 
                skl:set_level(1)
                skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
                -- skl:fresh_tip()
            end    

            

        end
    end    

end     

ac.game:event '单位-创建商店'(function(trg,shop)
    -- print('单位-创建商店',shop)
    local hero 
    if not ac.flag_test_1  then 
        hero = ac.player(1).hero
        ac.flag_test_1  =true 
    end   
    --测试
    -- local shop = ac.player(1):create_unit('魔鬼的交易',ac.point(1000,0)) 
    -- shop:add_restriction('无敌')
    -- 添加第一重 1+8  
    -- 9 10 11 12
    -- 5 6  7  8
    -- 1 2  3  4
    add_skill_by_lv(shop,1)

end)



