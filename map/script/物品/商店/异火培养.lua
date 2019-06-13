--异火升级
local fire = {
    --技能名 = 商店名，火灵基本价格，留空,培养，图标,tip
    ['星星之火'] = {'培养星星之火',2500,'',[[huo1.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['陨落心炎'] = {'培养陨落心炎',2500,'',[[huo2.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['三千焱炎火'] = {'培养陨落心炎',2500,'',[[huo3.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['虚无吞炎'] = {'培养陨落心炎',2500,'',[[huo4.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]}, 
}

for key,val in pairs(fire) do 
    local mt = ac.skill['培养'..key]
    mt{
    --等久
    level = 1,
    --正出售商品名
    store_name = val[1],
    --图标
    art = val[4],
    --说明
    tip =val[5],
    content_tip = '|cffFFE799【说明】：|r|n',
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --购买价格
    fire_seed = val[2],
    --物品技能
    is_skill = true,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        hero = player.hero
        
        --培养星星之火
        local rand_name = ac.get_reward_name(ac.unit_reward['培养异火'])
        if not rand_name then 
            return
        end    
        local skl = hero:find_skill(key,nil,true)
        if skl then 
            skl:set('quality',rand_name)
            skl:fresh()
            player:sendMsg('培养成功：'..key..' ('..rand_name..')')    
        else
            player:sendMsg('还没有 '..key)    
            return true
        end      

    end

end    