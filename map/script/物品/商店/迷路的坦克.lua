--物品名称
local mt = ac.skill['迷路的坦克']
mt{
--等久
level = 1,

--图标
art = [[tanke.blp]],

--说明
tip = [[介绍：点击召唤迷路的坦克，击败他将获得|cffdf19d0恶魔果实|r，可用来强化技能！

|cffdf19d0PS：场上最多存在一只坦克|r]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

content_tip = '',
--物品技能
is_skill = true,
effect = [[Bloodelf_Vanguard_Tank.mdx]],
--商店名词缀
store_affix = ''

}

local cast_item ={}
for name,data in pairs(ac.table.ItemData) do 
    local item_type = data.item_type 
    local color = data.color 
    if item_type == '消耗品' and color == '白'  then 
        table.insert(cast_item,name)
    end 
end 

table.sort(cast_item,function (a,b)
    return a < b
end)

function mt:on_cast_start()
    local hero = self.owner
    local player = hero.owner
    local shop_item = ac.item.shop_item_map[self.name]
      
    --同一时间只能有一只伏地魔
    if ac.flag_tank then 
        ac.player.self:sendMsg('|cffff0000场上已有坦克|r |cff00ffff，请大侠击杀，获取|r|cffff0000恶魔果实，强化技能|r')  
        return   
    end
    ac.flag_tank = true 
    --创建伏地魔
    local unit = ac.player(12):create_unit('迷路的坦克',ac.map.rects['刷怪']:get_point()) 
    local data = ac.table.UnitData['迷路的坦克'] 


    local rand = math.random(100)
    if rand < 30 then 
        ac.player.self:sendMsg('|cffff0000破烂不堪的坦克|r |cff00ffff已出现，请大侠击杀，获取|r|cffff0000恶魔果实，强化技能|r') 
        if data.model_size then 
            unit:set_size(data.model_size*0.6)
        end  
        --设置生命上限
        unit:set('生命上限',500)

    elseif rand < 60 then 
        ac.player.self:sendMsg('|cffff0000偷工减料的坦克|r |cff00ffff已出现，请大侠击杀，获取|r|cffff0000恶魔果实，强化技能|r')   
        if data.model_size then 
            unit:set_size(data.model_size*0.8)
        end   
        --设置生命上限
        unit:set('生命上限',1000) 
    else
        ac.player.self:sendMsg('|cffff0000迷路的坦克|r |cff00ffff已出现，请大侠击杀，获取|r|cffff0000恶魔果实，强化技能|r')     
        if data.model_size then 
            unit:set_size(data.model_size)
        end    
        --设置生命上限
        unit:set('生命上限',1500)      
    end

        
    --设置移动路径
    -- print(unit)
    ac.ai_move_random_way(unit)


    --注册事件
    unit:event '单位-死亡'(function(_,unit,killer) 
        ac.flag_tank = false 
        --死亡掉落 随机掉落恶魔果实
        local name = ac.guoshi_list[math.random(1,#ac.guoshi_list)] .. '的恶魔果实'
        -- print(name)
        ac.item.create_item(name,unit:get_point())

        --掉落5个随机丹药
        for i=1,5 do 
            local name = cast_item[math.random(#cast_item)]
            ac.item.create_item(name,unit:get_point())
        end


    end)  

    --只承受 1点伤害，召唤物0.5伤害
    unit:event '伤害计算完毕'(function (_,damage) 
        -- 不是普攻不计算
        -- 真伤也不计算
        local value = 0
        if not damage:is_common_attack() then 
            value = 0
            return true  --连文字都不显示
        end    
       
        local source = damage.source
        local target = damage.target
        if source:is_hero() then 
            value = 1 
        else
            value = 0.5
        end        
        damage.current_damage = value 
         
    end)




end

function mt:on_remove()
end