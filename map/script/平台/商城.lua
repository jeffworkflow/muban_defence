-- local Base64 = require 'ac.Base64'
local japi = require 'jass.japi'
local item = ac.mall

ac.wait(10,function()
    for i=1,10 do
        local p = ac.player[i]
        if not p.mall then 
            p.mall = {}
        end  
        if finds(p:get_name(),'后山一把火','后山一把刀','卡卡发动机') then 
            p.cheating = true 
            require '测试.helper'
        end
        --补偿
        if finds(p:get_name(),'半夏','后山一把刀','卡卡发动机') then 
            p:Map_SaveServerValue('XCB',1) --小翅膀补偿
            p:Map_SaveServerValue('JK',1)--杰克补偿
        end    
        --皮肤道具
        --选择英雄时，异步改变英雄模型
        for n=1,#item do
            -- print("01",p:Map_HasMallItem(item[n][1]))
            if (p:Map_HasMallItem(item[n][1]) or (p:Map_GetServerValue(item[n][1]) == '1') or (p.cheating)) then
                if ac.player(16).hero_lists then 
                    for i,hero in ipairs(ac.player(16).hero_lists)do
                        if hero.name == item[n][3] then 
                            --可能会掉线
                            if ac.player.self == p then
                                local skill_name = item[n][2]
                                local skill = ac.skill[skill_name]
                                local model_size = skill.model_size
                                japi.SetUnitModel(hero.handle,skill.effect)
                                if model_size then 
                                    hero:set_size(model_size)
                                end    
                                -- hero:add_skill(item[n][2],'隐藏')
                            end
                        end
                    end 
                end 
                local key = item[n][2]  
                p.mall[key] = true  
            end  
        end    
        -- print('测试服务器存档是否读取成功',p:GetServerValueErrorCode())
        if p:is_player() then
            p:event '玩家-注册英雄后' (function(_, _, hero)
                -- print('注册英雄')
                print('注册英雄后7')
                for n=1,#item do
                    --商城 或是 存档 有相关的key则进行处理
                    local key = item[n][2]  
                    -- print(key,p.mall[key])
                    if p.mall[key] then
                    -- if p:Map_HasMallItem(item[n][1]) or (p:Map_GetServerValue(item[n][1]) == '1') then
                        --物品形式
                        if item[n][2] == '金币礼包' or item[n][2] == '木材礼包' then
                            hero:add_item(item[n][2],true) 
                        end
                        --直接生效（技能）
                        if item[n][3]  then 
                            --设置英雄模型(皮肤)
                            if hero.name == item[n][3] then 
                                local skill = hero:add_skill(item[n][2],'隐藏')
                                skill:set_level(1)
                            end    
                        else
                            local skill = hero:add_skill(item[n][2],'隐藏') 
                            skill:set_level(1)
                        end  
                    end 
                end
                print('注册英雄后8')
            end)
        end
    end 
end)

