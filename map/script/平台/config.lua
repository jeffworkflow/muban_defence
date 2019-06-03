-- local Base64 = require 'ac.Base64'
local japi = require 'jass.japi'
local player = require 'ac.player'
--读取玩家的商城道具
local item = {
    {'XCB','小翅膀'}, --积分 
    {'JK','杰克','亚瑟王'}, --积分
    {'JBL','大天使加百列','鲁大师'},

    {'JBLB','金币礼包'},
    {'MCLB','木材礼包'},
    {'SCHY','天空的宝藏会员'},
    {'SBJFK','双倍积分卡'},
    {'QTDS','齐天大圣','悟空'}, --表示皮肤
    {'HY','后羿','小黑'},
    {'YG','影歌','影歌'},
    {'WZJ','王昭君','小昭君'},
    
    {'HMD','黑魔导','卜算子'},
    {'MLD','穆拉丁','山丘王'},
    {'TSZG','天使之光'}, --翅膀必须在改变模型之后 
    {'XBXDR','寻宝小达人'}, 
    {'ZYLB','金币多多'}, 
    {'ZDLB','战斗机器'}, 
    {'MLZX','魔龙之心'}, 
    {'YJCJZZ','永久超级赞助'}, 
    
    --其他服务器存档字段, CWTF 宠物天赋   房间相关: DW 段位  JF 积分 
}
ac.mall =   item 
local other_key = {
    {'CWTF','宠物天赋'}, 
    {'boshu','无尽层数'}, 
    {'jifen','积分'},
}
ac.other_key = other_key
--英雄熟练度
local hero_key = {
    ['Pa'] = 'SLPA', 
    ['亚瑟王'] = 'SLYSW', 
    ['凯撒'] = 'SLKS',
    ['卜算子'] = 'SLPSZ', 
    ['小昭君'] = 'SLXZJ', 
    ['小黑'] = 'SLXH', 
    ['山丘王'] = 'SLSQW', 
    ['影歌'] = 'SLYG', 
    ['悟空'] = 'SLWK', 
    ['扁鹊'] = 'SLBQ', 
    ['火焰领主'] = 'SLHYLZ', 
    ['牛魔王'] = 'SLNMW', 
    ['诸葛亮'] = 'SLZGL', 
    ['鲁大师'] = 'SLLDS', 
}
ac.hero_key = hero_key
local cus_key = {
    --以下自定义服务器 key value
    {'gold','福布斯排行榜'},
    {'boshu_rank','无尽层数(圣人模式)'},
}
ac.cus_server_key = cus_key

ac.server_key = {}
local function init_server_key()
    for i,v in ipairs(item) do
        v[4] = 1 --表示商城道具
        table.insert(ac.server_key,v)
    end
    for i,v in ipairs(other_key) do
        table.insert(ac.server_key,v)
    end
    for k,v in sortpairs(ac.hero_key) do
        local temp = {v,k..'熟练度'}
        table.insert(ac.server_key,temp)
    end
end;
init_server_key()

function ac.get_keyname_by_key(key)
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

local function get_mallkey_byname(name)
    local res
    for i=1,#item do
        if item[i][2] == name then 
            res = item[i][1]
            break
        end    
    end
    return res
end 
--根据商城物品名取得对应的key
ac.get_mallkey_byname = get_mallkey_byname

local function save_mall(player,name,value)  
    local key = ac.get_mallkey_byname(name)
    if key then 
        player:Map_SaveServerValue(key,tonumber(value))
        if not player.mall then 
            player.mall ={}
        end
        player.mall[name] = true    
    end 
end    
ac.save_mall = save_mall

function player.__index:clear_server()
    local player = self
    for i,v in ipairs(ac.server_key) do 
        local key = v[1]
        local is_mall= v[4]
        if key =='jifen' then 
            ac.SaveServerValue(player,'jifen',0)
        else
            if not is_mall then 
                player:Map_SaveServerValue(key,0)
            end    
        end    
    end    
end    

--网易服务器清空档案
function ac:clear_all_server()
	for i = 1, 10 do
        local player = ac.player(i)
        if player:is_player() then 
            player:clear_server()
        end   
	end
end

--加积分
function player.__index:add_jifen(value)
    player.jifen = player.jifen + tonumber(value)
    player:SetServerValue('jifen',player.jifen)
end    



--服务器存档 读取 (整合加密key、商城数据)
function ac.get_server(p,key)
    local value,key_name,is_mall
    key_name,is_mall = ac.get_keyname_by_key(key)
    
    if tonumber(is_mall) == 1 and p:Map_HasMallItem(key) then 
        value = 1
	else	
		value = p:Map_GetServerValue(key)
    end	
    return value,key_name,is_mall
end	

