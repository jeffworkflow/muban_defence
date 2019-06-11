--物品名称
local mt = ac.skill['挑战伏地魔']
mt{
--等久
level = 1,

--图标
art = [[icon\hunqi.blp]],

--说明
tip = [[|cffffff00召唤伏地魔，挑战成功可以将霸者之证升到顶级|r]],

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
store_affix = ''

}

function mt:on_cast_start()
    local hero = self.owner
    local player = hero.owner
    local shop_item = ac.item.shop_item_map[self.name]
    local item = hero:has_item('霸者之证')

    if item and item.level == 4 and item:get_item_count() >=150 then 
        ac.player.self:sendMsg('|cffff0000伏地魔|r |cff00ffff已出现，请大侠击杀，升级霸者之证|r') 
        --同一时间只能有一只伏地魔
        if ac.flag_fdm then 
            return   
        end
        ac.flag_fdm = true 
        --创建伏地魔
        local unit = ac.player.com[2]:create_unit('伏地魔',ac.map.rects['刷怪']:get_point()) 
        local data = ac.table.UnitData['伏地魔']
        if data.model_size then 
            unit:set_size(data.model_size)
        end   
        --添加4个boss技能
        for i=1,2 do 
            local skl_name = ac.skill_list3[math.random(#ac.skill_list3)]
            if not unit:find_skill(skl_name) then 
                unit:add_skill(skl_name,'英雄') 
            end
        end   
        --设置搜敌路径
        unit:set_search_range(99999)
        --注册事件
        unit:event '单位-死亡'(function(_,unit,killer) 
            ac.flag_fdm = false 
            --宠物打死也升级
            for i=1,10 do 
                local hero = ac.player(i).hero
                if hero then 
                    local item = hero:has_item('霸者之证')
                    if item and item.level == 4 and item:get_item_count() >=150 then 
                        -- ac.player.self:sendMsg('|cffff0000伏地魔|r |cff00ffff被击杀|r')  
                        item:set_item_count(1)
                        item:upgrade(1)
                    end
                end
            end  
        end)  


    else
        player:sendMsg('条件不足，无法挑战伏地魔')    
    end    



end

function mt:on_remove()
end