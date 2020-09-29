
local rect = require 'types.rect'


-- 传送 快速达到 兑换 交易
local devil_deal ={
    --商品名（map.table.单位.商店）,是否激活 属性名，数值，耗费币种，数值，图标,说明
    [1] = {
{'无所不在lv1',false,'全属性',2500,'金币',1000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv1|r

|cffFFE799【奖励】|r|cff00ff00+2500全属性|r

]]
},

{'无所不在lv2',false,'分裂伤害',5,'金币',5000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv2|r

|cffFFE799【奖励】|r|cff00ff00+5%分裂伤害|r

]]},

{'无所不在lv3',false,'全属性',5000,'金币',10000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv3|r

|cffFFE799【奖励】|r|cff00ff00+5000全属性|r

]]},

{'无所不在lv4',false,'分裂伤害',10,'金币',25000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv4|r

|cffFFE799【奖励】|r|cff00ff00+10%分裂伤害|r

]]},

{'无所不在lv5',false,'全属性',10000,'金币',50000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv5|r

|cffFFE799【奖励】|r|cff00ff00+10000全属性|r

]]},

{'无所不在lv6',false,'分裂伤害',15,'金币',70000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv6|r

|cffFFE799【奖励】|r|cff00ff00+15%分裂伤害|r

]]},

{'无所不在lv7',false,'全属性',20000,'金币',80000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv7|r

|cffFFE799【奖励】|r|cff00ff00+20000全属性|r

]]},

{'无所不在lv8',false,'攻击速度',10,'金币',90000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv8|r

|cffFFE799【奖励】|r|cff00ff00+10%攻速|r

]]},

{'无所不在lv9',false,'全属性',40000,'金币',100000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lv9|r

|cffFFE799【奖励】|r|cff00ff00+40000全属性|r

]]},

{'无所不在lvmax',false,'攻击速度',15,'金币',150000,[[xiaoheiwu.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不在Lvmax|r

|cffFFE799【奖励】|r|cff00ff00+15%攻速|r

]]},

} ,

    [2] = {
{'无所不知lv1',false,'攻击',200000,'木头',20,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+20w攻击|r
    ]]},

{'无所不知lv2',false,'每秒加攻击',125,'木头',30,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+125每秒加攻击|r
    ]]},

{'无所不知lv3',false,'杀怪加攻击',20,'木头',40,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+20杀怪加攻击|r
    ]]},

{'无所不知lv4',false,'攻击',400000,'木头',50,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+40w攻击|r
    ]]},

{'无所不知lv5',false,'每秒加攻击',250,'木头',60,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+250每秒加攻击|r
    ]]},

{'无所不知lv6',false,'杀怪加攻击',40,'木头',70,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+40杀怪加攻击|r
    ]]},

 {'无所不知lv7',false,'攻击',600000,'木头',80,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+60w攻击|r
    ]]},

{'无所不知lv8',false,'每秒加攻击',375,'木头',90,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+375每秒加攻击|r
    ]]},

{'无所不知lv9',false,'杀怪加攻击',60,'木头',100,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+60杀怪加攻击|r
    ]]},

{'无所不知lvmax',false,'攻击',1000000,'木头',150,[[minjie.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不知Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+100w攻击|r
   ]]},
},

[3] = {
{'无所不为lv1',false,'全属性',80000,'木头',30,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+8w全属性|r
    ]]},

{'无所不为lv2',false,'攻击',300000,'木头',60,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+30w攻击|r
    ]]},

{'无所不为lv3',false,'护甲',100,'木头',90,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+100护甲|r
    ]]},

{'无所不为lv4',false,'全属性',300000,'木头',120,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+30w全属性|r
    ]]},

{'无所不为lv5',false,'攻击',500000,'木头',150,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+50w攻击|r
    ]]},

{'无所不为lv6',false,'护甲',200,'木头',180,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+200护甲|r
    ]]},

 {'无所不为lv7',false,'全属性',500000,'木头',210,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+50w全属性|r
    ]]},

{'无所不为lv8',false,'攻击',1000000,'木头',240,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+100w攻击|r
    ]]},

{'无所不为lv9',false,'护甲',350,'木头',270,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+350护甲|r
    ]]},

{'无所不为lvmax',false,'攻击间隔',-0.05,'木头',300,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不为Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00-0.05攻击间隔|r
   ]]},
},

[4] = {
{'无所不贪lv1',false,'杀怪加全属性',30,'全属性',100000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+30杀怪加全属性|r
    ]]},

{'无所不贪lv2',false,'攻击加全属性',150,'全属性',200000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+150攻击加全属性|r
    ]]},

{'无所不贪lv3',false,'每秒加全属性',300,'全属性',300000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+300每秒加全属性|r
    ]]},

{'无所不贪lv4',false,'杀怪加全属性',60,'全属性',400000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+60杀怪加全属性|r
    ]]},

{'无所不贪lv5',false,'攻击加全属性',300,'全属性',500000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+300攻击加全属性|r
    ]]},

{'无所不贪lv6',false,'每秒加全属性',600,'全属性',600000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+600每秒加全属性|r
    ]]},

 {'无所不贪lv7',false,'杀怪加全属性',90,'全属性',700000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+90杀怪加全属性|r
    ]]},

{'无所不贪lv8',false,'攻击加全属性',450,'全属性',800000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+450攻击加全属性|r
    ]]},

{'无所不贪lv9',false,'每秒加全属性',900,'全属性',900000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+900每秒加全属性|r
    ]]},

{'无所不贪lvmax',false,'全伤加深',5,'全属性',1000000,[[zhili.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不贪Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+5%全伤加深|r
   ]]},
},

[5] = {
{'无所不能lv1',false,'吸血',10,'木头',350,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+10%吸血|r
    ]]},

{'无所不能lv2',false,'攻击减甲',10,'木头',700,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+10攻击减甲|r
    ]]},

{'无所不能lv3',false,'全属性',600000,'木头',1050,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+60w全属性|r
    ]]},

{'无所不能lv4',false,'触发概率加成',5,'木头',1400,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+5%触发概率加成|r
    ]]},

{'无所不能lv5',false,'每秒回血',10,'木头',1750,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+10%每秒回血|r
    ]]},

{'无所不能lv6',false,'减少周围护甲',200,'木头',2100,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+200减少周围护甲|r
    ]]},

 {'无所不能lv7',false,'全属性',1400000,'木头',2450,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+140w全属性|r
    ]]},

{'无所不能lv8',false,'技暴几率',2.5,'木头',2800,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%技暴几率|r
    ]]},

{'无所不能lv9',false,'全属性',2000000,'木头',3150,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+200w全属性|r
    ]]},

{'无所不能lvmax',false,'全伤加深',2.5,'木头',3500,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00无所不能Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%全伤加深|r
   ]]},
},

[6] = {
 {'身披圣衣lv1',false,'护甲',300,'火灵',2500,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv1|r
        
|cffFFE799【奖励】|r|cff00ff00+300护甲|r
        ]]},
    
    {'身披圣衣lv2',false,'全属性',1500000,'火灵',5000,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv2|r
        
|cffFFE799【奖励】|r|cff00ff00+150w全属性|r
        ]]},
    
    {'身披圣衣lv3',false,'护甲',500,'火灵',7500,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv3|r
        
|cffFFE799【奖励】|r|cff00ff00+500护甲|r
        ]]},
    
    {'身披圣衣lv4',false,'杀怪加全属性',200,'火灵',10000,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv4|r
        
|cffFFE799【奖励】|r|cff00ff00+200杀怪加全属性|r
        ]]},
    
    {'身披圣衣lv5',false,'攻击加全属性',1000,'火灵',12500,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv5|r
        
|cffFFE799【奖励】|r|cff00ff00+1000攻击加全属性|r
        ]]},
    
    {'身披圣衣lv6',false,'全属性',2000000,'火灵',15000,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv6|r
        
|cffFFE799【奖励】|r|cff00ff00+200w全属性|r
        ]]},
    
     {'身披圣衣lv7',false,'杀怪加攻击',800,'火灵',17500,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv7|r
        
|cffFFE799【奖励】|r|cff00ff00+800杀怪加攻击|r
        ]]},
    
    {'身披圣衣lv8',false,'每秒加攻击',8000,'火灵',20000,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv8|r
        
|cffFFE799【奖励】|r|cff00ff00+8000每秒加攻击|r
        ]]},
    
    {'身披圣衣lv9',false,'全属性',3000000,'火灵',22500,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lv9|r
        
|cffFFE799【奖励】|r|cff00ff00+300w全属性|r
        ]]},
    
    {'身披圣衣lvmax',false,'攻击速度',50,'火灵',25000,[[liliang.blp]],[[
    
|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00身披圣衣Lvmax|r
        
|cffFFE799【奖励】|r|cff00ff00+50%攻击速度|r
       ]]},
    },


[7] = {
{'脚踩祥云lv1',false,'免伤',2.5,'木头',2000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%免伤|r
    ]]},

{'脚踩祥云lv2',false,'每秒回血',10,'木头',4000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+10%每秒回血|r
    ]]},

{'脚踩祥云lv3',false,'全属性',4000000,'木头',6000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+400w全属性|r
    ]]},

{'脚踩祥云lv4',false,'触发概率加成',5,'木头',8000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+5%触发概率加成|r
    ]]},

{'脚踩祥云lv5',false,'免伤几率',2.5,'木头',10000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%免伤几率|r
    ]]},

{'脚踩祥云lv6',false,'攻击减甲',15,'木头',12000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+15攻击减甲|r
    ]]},

 {'脚踩祥云lv7',false,'全属性',6000000,'木头',14000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+600w全属性|r
    ]]},

{'脚踩祥云lv8',false,'技暴几率',2.5,'木头',16000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+2.5%技暴几率|r
    ]]},

{'脚踩祥云lv9',false,'技暴加深',50,'木头',18000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+50%技暴加深|r
    ]]},

{'脚踩祥云lvmax',false,'全伤加深',5,'木头',20000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00脚踩祥云Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+5%全伤加深|r
   ]]},
},

[8] = {
{'头顶乾坤lv1',false,'触发概率加成',5,'火灵',10000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv1|r
    
|cffFFE799【奖励】|r|cff00ff00+5%触发概率加成|r
    ]]},

{'头顶乾坤lv2',false,'物理伤害加深',25,'火灵',25000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv2|r
    
|cffFFE799【奖励】|r|cff00ff00+25%物理伤害加深|r
    ]]},

{'头顶乾坤lv3',false,'全属性',4000000,'火灵',40000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv3|r
    
|cffFFE799【奖励】|r|cff00ff00+400w全属性|r
    ]]},

{'头顶乾坤lv4',false,'攻击减甲',20,'火灵',55000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv4|r
    
|cffFFE799【奖励】|r|cff00ff00+20攻击减甲|r
    ]]},

{'头顶乾坤lv5',false,'技暴加深',50,'火灵',70000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv5|r
    
|cffFFE799【奖励】|r|cff00ff00+50%技暴加深|r
    ]]},

{'头顶乾坤lv6',false,'全属性',8000000,'火灵',85000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv6|r
    
|cffFFE799【奖励】|r|cff00ff00+800w全属性|r
    ]]},

 {'头顶乾坤lv7',false,'暴击加深',150,'火灵',100000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv7|r
    
|cffFFE799【奖励】|r|cff00ff00+150%暴击加深|r
    ]]},

{'头顶乾坤lv8',false,'技暴加深',150,'火灵',125000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv8|r
    
|cffFFE799【奖励】|r|cff00ff00+150%技暴加深|r
    ]]},

{'头顶乾坤lv9',false,'全属性',10000000,'火灵',150000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lv9|r
    
|cffFFE799【奖励】|r|cff00ff00+1000w全属性|r
    ]]},

{'头顶乾坤lvmax',false,'对BOSS额外伤害',5,'火灵',200000,[[liliang.blp]],[[

|cffFFE799【要求】|r消耗 |cffff0000%show_tip%|r 激活 |cff00ff00头顶乾坤Lvmax|r
    
|cffFFE799【奖励】|r|cff00ff00+5%对BOSS额外伤害|r
   ]]},


},
}
ac.devil_deal = devil_deal
--根据重数 给商店添加10技能，并让第一技能为可点击状态
--单位，重数
local function add_skill_by_lv(shop,lv,flag)
    --最后一重时，增加魔鬼的交易
    if lv > #devil_deal then 
        shop:add_sell_item('真魔鬼的交易',1)
        shop:add_sell_item('魔鬼的合成',4)
        
        -- local x,y = shop:get_point():get()
        -- shop:remove()
        -- ac.shop.create('真魔鬼的交易',x,y,0,nil)
    end    
    if not devil_deal[lv] then 
        return 
    end    
    for num,value in ipairs(devil_deal[lv]) do    
        flag = flag and 300*num  
        ac.wait(flag or 0,function()
            if num <= 4 then 
                -- print(value[1])
                shop:add_skill(value[1],'英雄',num + 8 )
            elseif num <= 8 then 
                shop:add_skill(value[1],'英雄',num)
            else
                shop:add_skill(value[1],'英雄',num - 8)
            end   
            -- shop:add_skill(value[1],'英雄')
            if num ==1 then 
                local skl = shop:find_skill(value[1],'英雄',true)
                skl:set_level(1)
            end 
        end)
    end   
end   

local mt = ac.skill['魔鬼的交易']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[mgdjy.blp]],
    title = name,
    tip = '\n点击查看 |cff00ff00魔鬼的交易\n|r',
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
                str = '杀敌数' .. self.kill_count 
            end   
            if self.wood then 
                str = '' .. self.wood .. '木头'
            end    
            if self.cost_allattr then 
                str = '' .. self.cost_allattr .. '全属性'
            end    
            if self.fire_seed then 
                str = '' .. self.fire_seed .. '火灵'
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
        if value[5]=='火灵' then
            mt.fire_seed = tonumber(value[6])
        end   

        local function add_next_skill(skill,seller,hero)
            local self = skill
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
            if hero:is_alive() then 
                hero:event_notify('单位-点击商店物品',seller,hero,item)
            else
                local flag = hero:event_dispatch('单位-点击商店物品',seller,hero,item)
                if flag then 
                    add_next_skill(self,seller,hero) --增加属性，删除技能
                    
                end    
            end    
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
            add_next_skill(self,seller,hero)
            

        end
    end    

end     

ac.game:event '单位-创建商店'(function(trg,shop)
    -- print('单位-创建商店',shop)
    --测试
    -- local shop = ac.player(1):create_unit('魔鬼的交易',ac.point(1000,0)) 
    -- shop:add_restriction('无敌')
    -- 添加第一重 1+8  
    -- 9 10 11 12
    -- 5 6  7  8
    -- 1 2  3  4
    add_skill_by_lv(shop,1,true)

    ac.wait(30*1000,function()
        local p = shop.owner 
        if p and p:Map_GetMapLevel() >=3 then 
            local skl = shop:find_skill('一键修炼',nil,true)
            if not skl then 
                shop:add_skill('一键修炼','英雄',4)
            end
        end
    end)
    ac.mgdjy_unit = shop
end)



