local mt = ac.skill['堆雪人同祝福']
mt{
--等久
level = 1,
--图标
art = [[xueren.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff0012月19日-12月31日
|cffffe799【活动说明】|r|cff00ff00又逢圣诞佳节，在这元旦前夕，让我们在这个温暖、温馨、欢乐的日子里，向家人、向朋友、向全世界献上我们的祝福吧！|cffffff00祝大家圣诞节快乐！

|cff00ffff少侠既然也是有心之人，还请帮忙收集点|cffffff00雪糕|r|cffcccccc（挖宝掉落）]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
-- store_name = '|cffdf19d0挑战 |r',
--物品详细介绍的title
content_tip = ''
}



local mt = ac.skill['兑换-点金石']
mt{
--等久
level = 1,
store_name = '兑换-点金石',
--图标
art = [[item\shou204.blp]],
--说明
tip = [[

消耗 |cffff0000两根雪糕|r 兑换 |cff00ff00点金石|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 2,
max_cnt = 99999,
}   

local mt = ac.skill['兑换-吞噬丹']
mt{
--等久
level = 1,
store_name = '兑换-吞噬丹',
--图标
art = [[icon\tunshi.blp]],
--说明
tip = [[

消耗 |cffff0000十五根雪糕|r 兑换 |cff00ff00吞噬丹|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 15,
max_cnt = 99999,
}  
local mt = ac.skill['兑换-恶魔果实']
mt{
--等久
level = 1,
store_name = '兑换-恶魔果实',
--图标
art = [[guoshi.blp]],
--说明
tip = [[

消耗 |cffff0000二十根雪糕|r 兑换 |cff00ff00恶魔果实|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 20,
max_cnt = 99999,
}  
local mt = ac.skill['兑换-格里芬']
mt{
--等久
level = 1,
store_name = '兑换-格里芬',
--图标
art = [[gelifen.blp]],
--说明
tip = [[

消耗 |cffff0000五根雪糕|r 兑换 |cff00ff00恶魔果实合成材料-格里芬|r

|cffdf19d0格里芬|cff00ffff+黑暗项链+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-黑暗项链']
mt{
--等久
level = 1,
store_name = '兑换-黑暗项链',
--图标
art = [[heianxianglian.blp]],
--说明
tip = [[

消耗 |cffff0000五根雪糕|r 兑换 |cff00ff00恶魔果实合成材料-黑暗项链|r

|cff00ffff格里芬+|cffdf19d0黑暗项链|cff00ffff+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-最强生物心脏']
mt{
--等久
level = 1,
store_name = '兑换-最强生物心脏',
--图标
art = [[zqswxz.blp]],
--说明
tip = [[

消耗 |cffff0000五根雪糕|r 兑换 |cff00ff00恶魔果实合成材料-最强生物心脏|r

|cff00ffff格里芬+黑暗项链+|cffdf19d0最强生物心脏|cff00ffff+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-白胡子的大刀']
mt{
--等久
level = 1,
store_name = '兑换-白胡子的大刀',
--图标
art = [[zhidao.blp]],
--说明
tip = [[

消耗 |cffff0000五根雪糕|r 兑换 |cff00ff00恶魔果实合成材料-白胡子的大刀|r

|cff00ffff格里芬+黑暗项链+最强生物心脏+|r|cffdf19d0白胡子的大刀|r|cff00ffff=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 5,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-冰雪奇缘']
mt{
--等久
level = 1,
store_name = '兑换-冰雪奇缘',
--图标
art = [[bingxueqiyuan.blp]],
--说明
tip = [[

消耗 |cffff0000四十五根雪糕|r 兑换 |cff00ff00可存档成就-冰雪奇缘|r |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】|r
|cff00ff00杀怪加全属性 +8.8*Lv
攻击减甲 +8.8*Lv
木头加成 +8.8%*Lv
会心伤害 +8.8%*Lv

|cffcccccc【要求地图等级>5】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need = 45,
max_cnt = 99999,
}  



for i,name in ipairs({'兑换-格里芬','兑换-黑暗项链','兑换-最强生物心脏','兑换-白胡子的大刀','兑换-点金石','兑换-吞噬丹','兑换-恶魔果实','兑换-冰雪奇缘'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        if not p.max_cnt then 
            p.max_cnt = {} 
        end    

        local real_name = string.gsub(self.name,'兑换%-','')

        --先扣当前消费者的勋章数，不足的话扣除单位下的另一个人的勋章
        local first_item = self.owner:has_item('雪糕','all')
        local unit = (self.owner == hero and p.peon or hero )
        local second_item = unit:has_item('雪糕','all')

        local has_cnt = (first_item and first_item._count or 0) + (second_item and  second_item._count or 0 )

        -- if real_name =='冰雪奇缘' then 
        --     local has_mall = p.mall[real_name] or (p.cus_server and p.cus_server[real_name])
        --     --已有物品的处理
        --     if has_mall > 0 then 
        --         p:sendMsg('【系统消息】已有'..real_name)    
        --         return 
        --     end
        -- end    

        --处理兑换
        if has_cnt >= self.need  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --给物品
                if real_name == '冰雪奇缘' then 
                    local key = ac.server.name2key(real_name)
                    --动态插入魔法书
                    local skl = hero:find_skill(real_name,nil,true) 
                    if not skl  then 
                        --激活成就（存档） 
                        p:Map_AddServerValue(key,1) --网易服务器
                        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
                        ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r |cff00ff00不知道从哪里弄来了这么多的雪糕，在活动使者处兑换了|cffffff00【可存档成就】'..real_name..'|r',6) 
                    elseif skl.level<skl.max_level then
                        --激活成就（存档） 
                        p:Map_AddServerValue(key,1) --网易服务器
                        skl:upgrade(1)
                        p:sendMsg('|cffff0000【可存档成就】'..real_name..'+1',6)  
                    else    
                        p:sendMsg('|cffff0000已达最高等级'..real_name..'',6)  
                        return
                    end 
                else    
                    self.owner:add_item(real_name,true) 
                end    

                --扣除物品
                if first_item  then
                    if first_item._count>= self.need then 
                        first_item:add_item_count(-self.need)
                    else
                        local dis_cnt = self.need - first_item._count
                        first_item:add_item_count(-self._count)
                        second_item:add_item_count(-dis_cnt)
                    end    
                else
                    second_item:add_item_count(-self.need)
                end 

                p.max_cnt[real_name] = (p.max_cnt[real_name] or 0) + 1
                p:sendMsg('|cffff0000兑换'..real_name..'成功|r')   
            else
                p:sendMsg('本局已达兑换上限')    
            end    
        else
            p:sendMsg('|cffffe799【系统消息】|r|cff00ff00材料不足|r')    
        end    
    end    
end    


local mt = ac.skill['雪糕']
mt{
--等久
level = 1,
--图标
art = [[xuegao.blp]],
--说明
tip = [[

|cff00ff00看起来很美味的样子，可前往|cffffff00活动使者处（基地右下角）|cff00ff00兑换奖励！|cff00ffff点击可食用，食用后攻击速度+10%|r

|cffcccccc圣诞活动物品|r]],
--品质

--，系统提示，这么冷的天还吃雪糕，怕是疯了吧。

color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.2,
specail_model = [[AZ_AAChristmas_C1_Snowman.mdx]],
model_size = 0.3,
size = 0.3,

['攻击速度'] = 10,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--几率
rate =3,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}

function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    hero = p.hero
    local save_name = '傻子的春天'
    p:sendMsg('|cffffe799【系统消息】|cff00ff00食用|r|cffffff00雪糕|cff00ff00成功|r',6)  
    -- print(self.rate)
    if math.random(100) <= self.rate then 
        local key = ac.server.name2key(save_name)
        -- if p:Map_GetServerValue(key) < 1 then 
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        --动态插入魔法书
        local skl = hero:find_skill(save_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','傻子的春天')
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r |cff00ff00这么冷的天还在吃雪糕，怕是疯了吧。惊喜获得|cffff0000【可存档成就】'..save_name..'|r |cff00ff00成就属性可在巅峰神域-精彩活动中查看',6) 
        else
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6)  
        end 
        -- end    
    end    


end    

--注册掉落事件 雪糕获得方式1：每隔5分钟，在基地随机地方掉落（1+玩家人数/2）个雪糕，模型AZ_AAChristmas_C1_Snowman.mdx，模型大小0.2左右；右键直接捡起来。（大概一局可以获得15个；）

ac.game:event '游戏-开始'(function()
    -- 注册材料获得事件
    local time = 60 * 5 
    -- local time = 5
    ac.loop(time*1000,function()
        local max_cnt = math.floor(get_player_count()/2) + 1
        for i=1,max_cnt do 
            local point = ac.map.rects['藏宝区']:get_random_point()
            ac.item.create_item('雪糕',point)
        end    
    end)
end)
--注册挖图回调
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero:get_owner()
    if not p.max_cnt then 
        p.max_cnt = {}
    end  

    local rate = 12
    local max_cnt = 30
    local name ='雪糕'
    -- local rate = 10 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        if (p.max_cnt[name] or 0 ) < max_cnt then 
            hero:add_item(name,true)
            p.max_cnt[name] = (p.max_cnt[name] or 0) + 1
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..p:get_name()..'|r 使用|cff00ff00藏宝图|r 惊喜获得 |cffff0000雪糕|r',6) 
        end    
    end  

end)
-- player:event_notify('挖图成功',hero)
