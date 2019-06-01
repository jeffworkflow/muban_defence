

for ix =1 ,4 do 
    local affix 
    if ix == 1 then 
        affix = '一'
    elseif ix == 2 then
        affix = '二' 
    elseif ix == 3 then
        affix = '三'    
    else 
        affix = '四' 
    end          
    local mt = ac.skill[affix..'号洗练石']
    mt{
        --等久
        level = 0,
        --图标
        art = [[xilianshi.blp]],
        --说明
        tip = [[%change_tip%]],
        change_tip = [[

|cff00ffff可洗练出装备的套装属性，但合成材料会消失，激活的属性可在套装系统中查看|r
                
|cff00ff00【合成材料】5个同套装装备+洗练石|r

|cffcccccc【同一套装属性只能激活一次】|r]],
        --物品类型
        item_type = '消耗品',
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        --物品技能
        is_skill = true,
        --物品详细介绍的title
        skill_cnt = 8,
        content_tip = '使用说明：',
        --最大使用次数
        max_use_count = 1
    }
        
    function mt:on_add()
        self.first_use =true
        
    end
    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        --宠物也帮忙升级
        hero = player.hero
        if not hero.suit then 
            player:sendMsg('|cffFFE799【系统消息】|r|cffff0000洗练失败|r 请检查合成材料',2)
            if self.add_item_count then 
                self:add_item_count(1) 
                
            end    
            return true
        end     
        
        local skl = hero:find_skill(self.name,nil,true)
        if skl and skl.level >=1 then 
            player:sendMsg('|cffFFE799【系统消息】|r|cffff0000操作失败|r '..self.color_name..'已被激活，可以在套装系统中查看',2)
            if self.add_item_count then 
                self:add_item_count(1) 
            end    
            return true
        end  
        if not hero.flag_suit then 
            hero.flag_suit = {}
        end    
        local item = self 
        local flag
        for key,val in pairs(hero.suit) do   
            --如果5个集满
            if val[5] and val[5][1] and not hero.flag_suit[key] then 
                if not val[5][5] then 
                    flag =true
                    local tip = val[5][4]
                    skl:set('change_tip',tip)
                    skl:fresh_tip()
                    skl:set_level(1)
                    --增加属性5个的 
                    for k,v in val[5][3]:gmatch '(%S+)%+(%d+%s-)' do
                        --额外增加人物属性
                        hero:add(k,v)
                    end  
                    for k,v in val[3][3]:gmatch '(%S+)%+(%d+%s-)' do
                        hero:add(k,v)
                    end 
                    player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00激活成功|r 可以在套装系统中查看',2)
                    --标记已经洗练过（不可洗练两套海贼王）
                    hero.flag_suit[key] =true
                    break
                end     
            end    
        end   
        --移除物品
        if flag then
            for i=1,6 do
                local items = hero:get_slot_item(i) 
                if items.name ~= self.name then  
                    items:item_remove()
                end    
            end  
        else
            player:sendMsg('|cffFFE799【系统消息】|r|cffff0000洗练失败|r 合成材料出错或者该套装已被激活',5)
            if self.add_item_count then 
                self:add_item_count(1) 
            end    
            return true    
        end   


    end 


end    

--魔法书
local mt = ac.skill['套装洗练']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[xilianshi.blp]],
    title = '套装洗练',
    tip = [[
        
查看 |cff00ff00套装洗练|r
    ]],
}
mt.skills = {
    '一号洗练石','二号洗练石','三号洗练石','四号洗练石'
}