-- local Base64 = require 'ac.Base64'
local japi = require 'jass.japi'
local player = require 'ac.player'
ac.server ={}
--读取玩家的商城道具
local item = {
    {'JBLB','金币礼包'},
    {'MCLB','木材礼包'},
    {'YJZZ','永久赞助'},
    {'YJCJZZ','永久超级赞助'},
    {'HDJ','皇帝剑'},
    {'HDD','皇帝刀'},
    {'JSYYY','绝世阳炎翼'},
    {'LHHMY','轮迴幻魔翼'},
    {'XLSF','限量首发'},

    {'GL','骨龙'},
    {'XWK','小悟空'},

    {'YXZZB','至尊宝'},
    {'YXGL','鬼厉'},
    {'YXJX','剑仙'},
    
    --key,key_name,地图等级要求
    {'WXHP','五星好评礼包',3},
    {'XHB','夏侯霸',5},
    {'YJ','虞姬',15},
    {'TJXM','太极熊猫',25},
    {'DRJ','狄仁杰',35},
    {'YND','伊利丹',45},
    

}
ac.mall = item 

--@设计 从网易读取并保存到map_test 只有商城、地图等级。
--  字段需要
--  1.段位记录对应通关次数:  cnt_qt  cnt_bj .. 8个段位; 后续有对应的排名， 排名可能有对应的奖励
--  2.永久性的物品:
--     a.武器：霸王莲龙锤 惊虹奔雷剑 幻海雪饮剑
--     b.翅膀：... 
--     c.称号：...
--  3.挖宝积分，神龙碎片
--  4.宠物皮肤 
local cus_key = {
    --以下自定义服务器 key value
    {'cnt_qt','青铜'},
    {'cnt_by','白银'},
    {'cnt_hj','黄金'},
    {'cnt_bj','铂金'},
    {'cnt_zs','钻石'},
    {'cnt_xy','星耀'},
    {'cnt_wz','王者'},
    {'cnt_zqwz','最强王者'},

    {'bwllc','霸王莲龙锤'},
    {'jhblj','惊虹奔雷剑'},
    {'hhxyj','幻海雪饮剑'},

    {'mdxy','梦蝶仙翼'},
    {'xyxyy','玄羽绣云翼'},
    {'tgcyy','天罡苍羽翼'},

    {'lhcq','炉火纯青'},
    {'sbkd','势不可挡'},
    {'htmd','毁天灭地'},
    {'dfty','巅峰天域'},
    {'jltx','君临天下'},
    {'jstj','九世天尊'},
    {'sd','神帝'},
    {'wzgl','王者归来'},

    {'nsl','耐瑟龙'},
    {'bl','冰龙'},
    {'jll','精灵龙'},
    {'qml','奇美拉'},

    {'spnsl','耐瑟龙碎片'},
    {'spbl','冰龙碎片'},
    {'spjll','精灵龙碎片'},
    {'spqml','奇美拉碎片'},

    {'zzl','赵子龙'},
    {'pa','Pa'},
    {'xln','手无寸铁的小龙女'},
    {'gy','关羽'},

    {'sppa','Pa碎片'},
    {'spxln','手无寸铁的小龙女碎片'},
    {'spgy','关羽碎片'},

    {'spbwllc','霸王莲龙锤碎片'},
    {'spmdxy','梦蝶仙翼碎片'},

    {'wbjf','挖宝积分'},
    {'cwtf','宠物天赋'},
    {'yshz','勇士徽章'},

}
ac.cus_server_key = cus_key

ac.server_key = {}
local function init_server_key()
    for i,v in ipairs(item) do
        v[4] = 1 --表示商城道具
        table.insert(ac.server_key,v)
    end
end;
init_server_key()

--通过key取 name 和 是否商城道具
function ac.server.key2name(key)
    local res
    local is_mall
    --取网易key,value
    for i,v in ipairs(ac.server_key) do
        if v[1] == key then 
            res = v[2]
            is_mall = v[4]
            break
        end    
    end 
    --取自定义key,value
    for i,v in ipairs(ac.cus_server_key) do 
        if v[1] == key then 
            res = v[2]
            is_mall = v[4]
            break
        end
    end  
    is_mall = is_mall or 0   
    return  res,is_mall
end  
--通过 name 取 key
function ac.server.name2key(name) 
    local res
    local is_mall
    --取网易key,value
    for i,v in ipairs(ac.server_key) do
        if v[2] == name then 
            res = v[1]
            is_mall = v[4]
            break
        end    
    end 
    --取自定义key,value
    for i,v in ipairs(ac.cus_server_key) do 
        if v[2] == name then 
            res = v[1]
            is_mall = v[4]
            break
        end
    end  
    is_mall = is_mall or 0   
    return  res,is_mall
end
--加积分
function player.__index:add_jifen(value)
    player.jifen = player.jifen + tonumber(value)
    player:SetServerValue('jifen',player.jifen)
end    

--网易服务器存档读取
function ac.get_server(p,key)
    local value,key_name,is_mall
    key_name,is_mall = ac.server.key2name(key)
    if tonumber(is_mall) == 1 and p:Map_HasMallItem(key) then 
        value = 1
	else	
		value = p:Map_GetServerValue(key)
    end	
    return value,key_name,is_mall
end	

