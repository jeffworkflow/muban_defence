local mt = ac.skill['情人节-玫瑰物语']
mt{
--等久
level = 1,
--图标
art = [[meigui.blp]],
store_name = '玫瑰物语',
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff002月13日-2月21日
|cffffe799【活动说明】|r|cff00ff00相聚有缘，相逢有期。千里姻缘一线牵，甜蜜爱意如何传达？你有|cffffff00娇艳的玫瑰|cff00ff00吗?|cffcccccc（挖宝掉落）
]],
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

消耗 |cffff0000一朵娇艳的玫瑰|r 兑换 |cff00ff00点金石|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 1,
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

消耗 |cffff0000十朵娇艳的玫瑰|r 兑换 |cff00ff00吞噬丹|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 10,
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

消耗 |cffff0000十五朵娇艳的玫瑰|r 兑换 |cff00ff00恶魔果实|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 15,
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

消耗 |cffff0000四朵娇艳的玫瑰|r 兑换 |cff00ff00恶魔果实合成材料-格里芬|r

|cffdf19d0格里芬|cff00ffff+黑暗项链+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 4,
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

消耗 |cffff0000四朵娇艳的玫瑰|r 兑换 |cff00ff00恶魔果实合成材料-黑暗项链|r

|cff00ffff格里芬+|cffdf19d0黑暗项链|cff00ffff+最强生物心脏+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 4,
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

消耗 |cffff0000四朵娇艳的玫瑰|r 兑换 |cff00ff00恶魔果实合成材料-最强生物心脏|r

|cff00ffff格里芬+黑暗项链+|cffdf19d0最强生物心脏|cff00ffff+白胡子的大刀=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 4,
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

消耗 |cffff0000四朵娇艳的玫瑰|r 兑换 |cff00ff00恶魔果实合成材料-白胡子的大刀|r

|cff00ffff格里芬+黑暗项链+最强生物心脏+|r|cffdf19d0白胡子的大刀|r|cff00ffff=恶魔果实（食用后可以获得惊人能力！)|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 4,
max_cnt = 99999,
}  

local mt = ac.skill['兑换-九亿少女的梦']
mt{
--等久
level = 1,
store_name = '兑换-九亿少女的梦',
--图标
art = [[shaonvmeng.blp]],
--说明
tip = [[

消耗 |cffff0000三十朵娇艳的玫瑰|r 兑换 |cff00ff00可存档成就-九亿少女的梦|r

|cffFFE799【成就属性】|r
|cff00ff00每秒加全属性 +88
攻击减甲    +8.8
杀敌数加成  +8.8%
会心伤害    +8.8%

|cffcccccc【要求地图等级>5】|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
content_tip = '|cffFFE799【兑换说明】：|r\n',
--物品技能
is_skill = true,
need_xqym = 30,
max_cnt = 99999,
}  



for i,name in ipairs({'兑换-格里芬','兑换-黑暗项链','兑换-最强生物心脏','兑换-白胡子的大刀','兑换-点金石','兑换-吞噬丹','兑换-恶魔果实','兑换-九亿少女的梦'}) do
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
        local first_item = self.owner:has_item('娇艳的玫瑰','all')
        local unit = (self.owner == hero and p.peon or hero )
        local second_item = unit:has_item('娇艳的玫瑰','all')

        local has_cnt = (first_item and first_item._count or 0) + (second_item and  second_item._count or 0 )

        -- if real_name =='九亿少女的梦' then 
        --     local has_mall = p.mall[real_name] or (p.cus_server and p.cus_server[real_name])
        --     --已有物品的处理
        --     if has_mall > 0 then 
        --         p:sendMsg('【系统消息】已有'..real_name)    
        --         return 
        --     end
        -- end    

        --处理兑换
        if has_cnt >= self.need_xqym  then 
            if (p.max_cnt[real_name] or 0 ) < self.max_cnt then 
                --扣除物品
                if first_item  then
                    if first_item._count>= self.need_xqym then 
                        first_item:add_item_count(-self.need_xqym)
                    else
                        local dis_cnt = self.need_xqym - first_item._count
                        first_item:add_item_count(-self._count)
                        second_item:add_item_count(-dis_cnt)
                    end    
                else
                    second_item:add_item_count(-self.need_xqym)
                end 
                --给物品
                if real_name == '九亿少女的梦' then 
                    local key = ac.server.name2key(real_name)
                    p:Map_AddServerValue(key,1) --网易服务器
                    local skl = hero:find_skill(real_name,nil,true) 
                    if not skl  then 
                        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','九亿少女的梦')
                    else 
                        skl:upgrade(1)
                        p:sendMsg('|cffff0000【可存档成就】'..real_name..'+1',6) 
                    end  
                else    
                    self.owner:add_item(real_name,true) 
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


local mt = ac.skill['巧克力']
mt{
--等久
level = 1,
--图标
art = [[qiaokeli.blp]],
--说明
tip = [[

|cff00ff00在浪漫的情人节，它是表达爱情少不了的主角。|cffffff00食用后+10%会心伤害|r

|cffcccccc情人节最佳礼物|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
cool = 0.5,
['会心伤害'] = 10,
--概率
rate = 2,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}
function mt:on_cast_start()
    local hero = self.owner 
    local p = hero:get_owner()
    local player = hero:get_owner()
    hero = p.hero
    local save_name = '纵享丝滑'
    -- print(self.rate)
    if math.random(100) <= self.rate then 
        local key = ac.server.name2key(save_name)
        -- if p:Map_GetServerValue(key) < 1 then 
        --激活成就（存档） 
        p:Map_AddServerValue(key,1) --网易服务器
        --动态插入魔法书
        local skl = hero:find_skill(save_name,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动','纵享丝滑')
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 不断地吃巧克力，惊喜获得|cffff0000【可存档成就】'..save_name..'|r |cff00ff00+88每秒加全属性|r |cff00ff00+1每秒加木头|r |cff00ff00+38减少周围护甲|r |cff00ff00+8.8%会心伤害|r',6) 
        else
            skl:upgrade(1)
            p:sendMsg('|cffff0000【可存档成就】'..save_name..'+1',6)  
        end 
        -- end    
    end    
end    

local mt = ac.skill['娇艳的玫瑰']
mt{
--等久
level = 1,
--图标
art = [[meigui.blp]],
--说明
tip = [[

|cff00ff00可前往活动使者处（基地右下角）兑换奖励

|cffcccccc情人节活动物品|r]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
no_use = true,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
no_use = true,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
}




--注册掉落事件
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_owner().id < 11 then 
        return
    end    
    if not finds(unit:get_name(),'强盗') then 
        return 
    end    
    local p = killer:get_owner()
    if not p.max_cnt then 
        p.max_cnt = {}
    end    
    local rate = 0.5
    local max_cnt = 50
    local name ='巧克力'
    -- local max_cnt = 5 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        --掉落
        if (p.max_cnt[name] or 0 ) < max_cnt then 
            ac.item.create_item(name,unit:get_point())
            p.max_cnt[name] = (p.max_cnt[name] or 0) + 1
        end    
    end  
    
end)
--注册挖图回调
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero:get_owner()
    if not p.max_cnt then 
        p.max_cnt = {}
    end  

    local rate = 10
    local max_cnt = 30
    local name ='娇艳的玫瑰'
    -- local rate = 10 --测试
    local rand = math.random(10000)/100
    if rand <= rate then 
        if (p.max_cnt[name] or 0 ) < max_cnt then 
            hero:add_item(name,true)
            p.max_cnt[name] = (p.max_cnt[name] or 0) + 1
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..p:get_name()..'|r 使用|cff00ff00藏宝图|r 惊喜获得 |cffff0000娇艳的玫瑰|r',6) 
        end    
    end  

end)
-- player:event_notify('挖图成功',hero)
