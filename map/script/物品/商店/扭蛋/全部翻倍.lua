
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['全部翻倍']
mt{
--等久
level = 1,
--图标
art = [[qbfb.blp]],
--说明
tip = [[|cffFFE799【说明】|r

|cff00ff0050%杀敌数/木头/火灵|cff00ff00翻倍|r  |cffff000050%杀敌数/木头/火灵|cffff0000归零|r
]],
has_vale = function() 
    return ac.player.self.fire_seed
end ,
auto_fresh_tip = true,
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
content_tip = '',
--物品技能
is_skill = true,
--商店名词缀
store_affix = '',
--实际概率
rate = 55 

}


function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local fire_seed = p.fire_seed 
    local wood = p.wood 
    local kill_count = p.kill_count

    local rand = math.random(100)
    if fire_seed <=10 and wood <=10  and kill_count <=10 then 
        p:sendMsg('|cffFFCC00不够资源|r')
        return 
    end    
    if rand <= self.rate then 
        hero:add_fire_seed(fire_seed)
        hero:add_wood(wood)
        hero:add_kill_count(kill_count)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:add_fire_seed(-fire_seed)
        hero:add_wood(-wood)
        hero:add_kill_count(-kill_count)
        p:sendMsg('|cffff0000凉凉|r')
    end    

    --超级彩蛋触发
    local hero = p.hero
    local rate = 7.5
    if fire_seed >= 90000 or wood >=30000 or kill_count >=10000 then 
        if math.random(10000)/100 <= rate then 
            local skl = hero:find_skill('一代幸运神',nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','一代幸运神')
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 翻倍一时爽，一直翻倍一直爽，|r 获得成就|cffff0000 "一代幸运神" |r，奖励 |cffff00005000万全属性，+100%杀敌数加成，+100%物品获取率，+100%木头加成，+100%火灵加成|r',6)
            end    
        end
    end        



end
