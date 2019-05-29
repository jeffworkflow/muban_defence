--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['恶魔果实']
mt{
--等久
level = 1,
--冷却
cool = 0,
--描述
tip = [[
能强化一个技能，主动→被动，被动→入体
已强化 %cnt%|cffffff00/8|r 个： %content%]],
cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.ruti_cnt or 0 
    end    
    return cnt
end,
content = function(self) 
    local content = '' 
    --恶魔果实在宠物也可以展示
    if self and self.owner  then 
        local hero = self.owner
        local player = hero:get_owner()
        if player.ruti then 
            for i,item in ipairs(player.ruti) do
                content = content ..'\n'.. item.name
            end
        end    
    end    
    return content
end,
--品质
color = '紫',
art = [[guoshi.blp]],
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
strong_skill_name = name,
--冷却
cool = 1,
--购买价格
gold = 10000,
--物品模型
specail_model = [[acorn.mdx]],
model_size = 2,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '使用说明：',
auto_fresh_tip = true

}

--处理强化
function mt:on_strong(skill)
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    local slot_id = skill.slot_id
    if skill.passive then 
        --先删除
        skill:remove() 
        ac.game:event_notify('技能-插入魔法书',hero,'神技入体',skill.name)
    else
        -- hero:add_skill('强化后的'..skill.name,'英雄',slot_id)
        hero:replace_skill(skill.name,'强化后的'..skill.name)
    end   
    
end
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {}
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = 8
    if (player.ruti_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('恶魔果实使用已满，不可用')
        return 
    end    

    for i=1,8 do 
        local skill = hero:find_skill(i,'英雄')
        if skill and skill.level>=5  then 
            count = count + 1
            local info = {
                name = "|cff"..ac.color_code['紫']..'强化'.. skill:get_name() .. '  (' .. skill:get_hotkey() ..')' ,
                skill = skill
            }
            table.insert(list,info)
        end
    end 

    if count < 1 then 
        player:sendMsg('没有可强化的技能')
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name,true)
        end     
        return 
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'强化技能',list,function (index)
            local skill = list[index].skill
            if skill then 
                --进行强化处理
                self:on_strong(skill)
                --吞噬个数 +1
                if not player.ruti_cnt then 
                    player.ruti_cnt =0
                end    
                player.ruti_cnt = player.ruti_cnt + 1

                --吞噬名
                if not player.ruti then 
                    player.ruti = {}
                end    
                table.insert(player.ruti,skill)
            

            else
                -- print('取消更换技能')
                if self._count > 1 then 
                    -- print('数量')
                    self:set_item_count(self._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name,true)
                end        
            end
            
            self.dialog = nil
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end


local mt = ac.skill['神技入体']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sc.blp]],
    title = '神技入体',
    tip = [[
查看 神技入体
    ]],
}
mt.skills ={}
