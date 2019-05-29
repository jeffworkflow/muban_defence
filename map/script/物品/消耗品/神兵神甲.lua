
-- 神兵
local magic_item = {
    ['神兵'] ={'凝脂剑','元烟剑','暗影','青涛魔剑','青虹紫霄剑','熔炉炎刀','紫炎光剑','封神冰心剑','冰莲穿山剑','十绝冰火剑'},
    ['神甲'] ={'芙蓉甲','鱼鳞甲','碧云甲','青霞甲','飞霜辉铜甲','天魔苍雷甲','金刚断脉甲','丹霞真元甲','血焰赤阳甲','神魔蚀日甲'}
}
for key,tab in pairs(magic_item) do 
    for i,value in ipairs(tab) do 
        local mt = ac.skill[value]
        mt{
            --等久
            level = 0,
            --魔法书相关
            is_order = 1 ,
            --物品类型
            item_type = '消耗品',
            --目标类型
            target_type = ac.skill.TARGET_TYPE_NONE,
            --冷却
            cool = 0,
            content_tip = '',
            --物品技能
            is_skill = true,
            --商店名词缀
            store_affix = '',
            --最大使用次数
            max_use_count = 1
        }
        --继承物品lni数据
        --如果存在lni则继承lni的属性
        local data = ac.table.ItemData[value]
        mt.lni_data = data
        if data then
            for k, v in sortpairs(data) do
                mt[k] = v
            end
        end 
        --使用物品
        function mt:on_cast_start()
            local hero = self.owner
            local player = self.owner:get_owner()
            hero = player.hero 
            --改变外观，添加武器
            if hero.effect_wuqi then 
                hero.effect_wuqi:remove()
            end     
            hero.effect_wuqi = hero:add_effect('hand',self.effect)
            print('使用武器')
            local skl = hero:find_skill(self.name,nil,true)
            if skl and skl.level >=1 then 
                player:sendMsg('神兵或神甲已入体，不允许重复')
                --需要先增加一个，否则消耗品点击则无条件先消耗
                if self.add_item_count then 
                    self:add_item_count(1) 
                end    
                return 
            end    
            skl:set_level(1)
        end
    end
end

--魔法书
local mt = ac.skill['神兵利器']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[wuqi17.blp]],
    title = '神兵利器',
    tip = [[

查看 |cff00ff00神兵利器|r
    ]],
}
mt.skills = magic_item['神兵']

local mt = ac.skill['护天神甲']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jia10.blp]],
    title = '护天神甲',
    tip = [[

查看 |cff00ff00护天神甲|r
    ]],
}
mt.skills = magic_item['神甲']



--解决暗图标 
-- ac.game:event '物品-创建' (function (_,item)
--     if item.level >=1 then 
--         return 
--     end
--     if item.on_blend then 
--         item.on_blend:remove()
--     end    
--     item.level = 1 
--     local blend = item.blend or ac.blend_file[item.color or 'nil'] 
-- 	if blend then 
-- 		item.owner = ac.dummy
-- 		item.on_bland = item:add_blend(blend, 'frame', 2)
-- 		item.owner = nil
-- 	end	
--     item.level = 0 
-- end)    
