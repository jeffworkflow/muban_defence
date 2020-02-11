-- 神龙
local mt = ac.skill['挑战耐瑟龙']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r耐瑟龙碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNNetherDragon.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 10 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+8    杀怪加全属性|r
|cff00ff00+10% 杀敌数加成|r
|cff00ff00+15% 分裂伤害|r

|cffff0000【所有宠物外观可更换，所有宠物属性可叠加】|r]],
need_map_level = 3,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--特效
effect = [[units\creeps\NetherDragon\NetherDragon.mdx]],
}

local mt = ac.skill['挑战冰龙']
mt{
    is_skill = 1,
    item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r冰龙',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNAzureDragon.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 50 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+28   杀怪加全属性|r
|cff00ff00+25% 金币加成|r
|cff00ff00+25% 木头加成|r
|cff00ff00+20% 吸血|r

|cffff0000【所有宠物外观可更换，所有宠物属性可叠加】|r]],

need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 50,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--特效
effect = [[units\creeps\AzureDragon\AzureDragon.mdx]]
}

local mt = ac.skill['挑战精灵龙']
mt{
    is_skill = 1,
    item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r精灵龙碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNFaerieDragon.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 250 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+68  杀怪加全属性|r
|cff00ff00+15% 金币加成|r
|cff00ff00+15% 木头加成|r
|cff00ff00+15% 杀敌数加成|r
|cff00ff00+10% 每秒回血|r

|cffff0000【所有宠物外观可更换，所有宠物属性可叠加】|r]],
need_map_level = 8,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 250,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--特效
effect = [[units\nightelf\FaerieDragon\FaerieDragon.mdx]]
}

local mt = ac.skill['挑战奇美拉']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r奇美拉碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[ReplaceableTextures\CommandButtons\BTNChimaera.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 350 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+128    杀怪加全属性|r
|cff00ff00+25%  火灵加成|r
|cff00ff00+25%  物品获取率|r
|cff00ff00-0.05  攻击间隔|r

|cffff0000【所有宠物外观可更换，所有宠物属性可叠加】|r]],

need_map_level = 13,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 350,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--特效
effect = [[units\nightelf\Chimaera\Chimaera.mdx]]
}

local mt = ac.skill['挑战魅影']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r魅影碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[meiying.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 400 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+148  杀怪加全属性|r
|cff00ff00+45   攻击减甲|r
|cff00ff00+2.5% 免伤几率|r
|cff00ff00+10%  技能伤害加深|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],

need_map_level = 15,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 500,
--特效
effect = [[Hero_Netherdrake_N1.mdx]]
}

local mt = ac.skill['挑战紫霜幽幻龙鹰']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r紫霜幽幻龙鹰碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
strong_hero = 1, --作用在人身上
--图标
art = [[zsyhly.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 500 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【宠物属性】：|r
|cff00ff00+188  杀怪加全属性|r
|cff00ff00+60   攻击减甲|r
|cff00ff00+2.5% 闪避|r
|cff00ff00+10%  技能伤害加深|r
|cff00ff00+10%  会心伤害|r

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],

need_map_level = 17,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 500,
--特效
effect = [[Hero_Phoenix_N1_purple.mdx]]
}

local mt = ac.skill['挑战Pa']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |rpa碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNHeroWarden.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 30 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【英雄天赋】：|r
|cffffff00【杀怪加全属性】+50*Lv
【暴击几率】+5%
【暴击加深】+50%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(敏捷*20+1w)*Lv

|cff00ff00【凌波微步】按D向鼠标方向飘逸500码距离|r]],
need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 30,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--特效
effect = [[Fudo.mdx]]
}

local mt = ac.skill['挑战手无寸铁的小龙女']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r手无寸铁的小龙女碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[huolinger.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 75 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【英雄天赋】：|r
|cffffff00【杀怪加全属性】+100*Lv
【触发概率加成】+25%
【技暴几率】+15%
【技暴加深】+150%

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*25+10000）*Lv

|cff00ff00【凌波微步】按D向鼠标方向飘逸500码距离|r]],
need_map_level = 5,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 75,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--特效
effect = [[xiaolongnv1.mdx]]
}

local mt = ac.skill['挑战关羽']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r关羽碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[guanyu.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 300 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【英雄天赋】：|r
|cffffff00【杀怪加全属性】+188*Lv
【杀敌数加成】+75%
【物品获取率】+75%
【木头加成】+75%
【火灵加成】+75%|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(全属性*10+1w)*Lv

|cff00ff00【凌波微步】按D向鼠标方向飘逸500码距离|r]],
need_map_level = 10,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 250,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--特效
effect = [[guanyu.mdx]]
}


local mt = ac.skill['挑战霸王莲龙锤']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r霸王莲龙锤碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[wuqi10.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 150 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【神兵属性】：|r
|cff00ff00+300 杀怪加攻击|r
|cff00ff00+20% 吸血|r
|cff00ff00+35   攻击减甲|r
|cff00ff00+25%  物理伤害加深|r

|cffff0000【所有神兵外观可更换，所有神兵属性可叠加】|r]],
need_map_level = 10,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 150,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--特效
effect = [[wuqi10.mdx]],

--boss武器
weapon_orf = 'hand',
weapon_effect = 'wuqi10.mdx',
}

local mt = ac.skill['挑战梦蝶仙翼']
mt{
is_skill = 1,
item_type ='神符',
--商店品
store_name = '|cffdf19d0挑战 |r梦蝶仙翼碎片',
content_tip = '|cffFFE799\n【任务说明】：|r\n',
--等级
level = 0,
--图标
art = [[chibang2.blp]],
--说明
tip = [[
|cff00ffff挑战Boss并获得|cff00ff00可存档的碎片（数量=游戏难度）|r |cff00ffff神龙碎片超过|cffffff00 200 |cff00ffff自动获得，已拥有碎片：|r%skin_cnt%

|cffFFE799【翅膀属性】：|r
|cff00ff00+80     杀怪加全属性|r
|cff00ff00+2000W 生命|r
|cff00ff00+2000   护甲
|cff00ff00+10%   免伤几率|r

|cffff0000【所有翅膀外观可更换，所有翅膀属性可叠加】|r]],
need_map_level = 10,
skin_cnt = function(self)
    local p = ac.player.self
    return p.cus_server[string.gsub(self.name,'挑战','')..'碎片'] or 0
end,
--所需激活碎片
need_sp_cnt = 200,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--特效
effect = [[chibang2.mdx]],
--boss武器
weapon_orf = 'hand',
weapon_effect = 'wuqi10.mdx',

}



--统一加方法
for i,name in ipairs({'挑战耐瑟龙','挑战冰龙','挑战精灵龙','挑战奇美拉','挑战魅影','挑战紫霜幽幻龙鹰','挑战Pa','挑战手无寸铁的小龙女','挑战关羽','挑战霸王莲龙锤','挑战梦蝶仙翼'}) do
    
    local mt = ac.skill[name]
    
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        if  player.sl_click_flag then 
            player:sendMsg('不可重复挑战')
            return 
        end    
        player.sl_click_flag = true
        --传送 玩家英雄
        hero = player.hero
        local point = ac.map.rects['练功房刷怪'..player.id]:get_point()
        hero:blink(point,true,false,true)
        -- local x,y=hero:get_point():get()
        -- player:setCamera(ac.point(x+(value[10] or 0),y+(value[11] or 0))) --设置镜头
        local minx, miny, maxx, maxy = ac.map.rects['练功房刷怪'..player.id]:get()
        player:setCameraBounds(minx, miny, maxx, maxy)  --镜头锁定
        
        hero:event '单位-死亡'(function()
            player:sendMsg('|cffffe799【系统消息】|r|cffff0000挑战失败|r 很遗憾未获得碎片',10)
            ac.game:event_notify('游戏-大胜利',true)
        end)
        --3秒后刷怪
        ac.wait(3*1000,function()
            local unit_name = self.name
            local real_name = string.gsub(self.name,'挑战','')
            local unit = ac.player(12):create_unit(unit_name,point,270)

            if self.weapon_orf and self.weapon_effect then 
                unit:add_effect(self.weapon_orf,self.weapon_effect)
            end   

            unit:event '单位-死亡'(function(trg,unit,killer)
                --加碎片，存档。
                local name = real_name..'碎片'
                local key = ac.server.name2key(name)
                player:Map_AddServerValue(key,ac.g_game_degree_attr) --网易服务器
                
                player:sendMsg('|cffffe799【系统消息】|r|cff00ff00挑战成功|r 获得|cff00ffff'..ac.g_game_degree_attr..'个'..name..'|r 还差|cff00ffff'..self.need_sp_cnt - player.cus_server[name]..'个碎片|r即可激活')
                -- player:sendMsg('游戏胜利!30秒之后退出游戏！',3)
                ac.game:event_notify('游戏-大胜利',true)
               
            end)
        end)

    end   
end    

