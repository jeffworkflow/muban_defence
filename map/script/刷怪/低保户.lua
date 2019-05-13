--低保户
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪' then
        return
    end    
    print('回合开始1')
    --取上回合
    local index = creep.index -1 
    if index < 1 then 
        return
    end    

    local t = {}
    --上回合伤害 排序
    for i=1,6 do
        local player = ac.player[i]
        local hero = player.hero
        local damage = 0
        if player:is_player() and player.each_index_damage then
            damage = player.each_index_damage[index] or 0
            table.insert(t,{id = player:get(),damage = damage})
        end    
    end
    --排序
    table.sort(t,function(a,b) return a.damage<b.damage end)

    --奖励倍数 
    local reward_mul = math.floor( get_player_count()/2 )
    if reward_mul == 0 then 
        return
    end    
    local life = 1000 * index * reward_mul
    local defence = 1 * index * reward_mul
    local gold = 50 * index * reward_mul

    --随机取英雄奖励
    local id = t[math.random(1,reward_mul)].id
    local player = ac.player(id)
    local hero = player.hero

    hero:addGold(gold)
    hero:add('生命上限',life)
    hero:add('护甲',defence)

    --发送消息
    local tip = '|cffffff00【系统消息】|r玩家 |cffff0000'..player:get_name()..'|r|cffffff00实在弱，获得低保奖励：|cffff0000金币+'..gold..'，护甲+'..defence..'，生命上限+'..life..'\n'
    ac.player.self:sendMsg(tip,10)
end)
