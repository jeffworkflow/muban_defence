--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['恶魔果实']
mt{
--等久
level = 1,
--冷却
cool = 0,
content_tip = '|cffffe799使用说明：|r',
--描述
tip = [[


|cff00ffff点击可食用 让|cffff0000满级技能|cff00ffff获得强化！无法强化相同技能！|r

已强化 %cnt%|cffffff00 / %max_cnt%|r 个： %content%]],

cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.ruti_cnt or 0 
    end    
    return cnt
end,
max_cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.max_ruti_cnt or 8
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

auto_fresh_tip = true

}

--处理强化
function mt:on_strong(skill)
    local hero = skill.owner
    local player = hero:get_owner()
    hero = player.hero
    local slot_id = skill.slot_id
    if skill.passive then 
        --先删除
        skill:remove() 
        ac.game:event_notify('技能-插入魔法书',hero,'神技入体',skill.name)
        player:sendMsg('|cffffe799【系统消息】|r|cffffff00技能强化成功|r 强化后的技能可以在 神技入体系统 查看')
        --设置入体技能为5级
        ac.wait(300,function() 
            local skl = hero:find_skill(skill.name,nil,true)
            if skl then skl:set_level(skl.max_level) end
        end)
    else
        -- hero:add_skill('强化后的'..skill.name,'英雄',slot_id)
        hero:replace_skill(skill.name,'强化后的'..skill.name)
        player:sendMsg('|cffffe799【系统消息】|r|cffffff00技能强化成功|r 强化后的技能可以在 英雄技能栏 查看')
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
    --超越极限
    player.max_ruti_cnt = player.max_ruti_cnt or 8
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = player.max_ruti_cnt 
    if (player.ruti_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('无法食用更多的恶魔果实')
        return 
    end    
    for i=1,8 do 
        local skill = hero:find_skill(i,'英雄')
        if skill then 
            local flag
            if player.ruti then 
                for i,item in ipairs(player.ruti) do
                    if item.name == skill.name then 
                        flag =true 
                        break
                    end    
                end
            end  
            if skill.level>=5  and not flag then 
                count = count + 1
                local info = {
                    name = "|cff"..ac.color_code['紫']..'强化'.. skill:get_name() .. '  (' .. skill:get_hotkey() ..')' ,
                    skill = skill
                }
                table.insert(list,info)
            end    
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
        self.dialog = create_dialog(player,'请选择要强化的技能',list,function (index)
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
                
                --触发超级彩蛋
                if player.ruti_cnt  == 8 then 
                    ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','霸王色的霸气')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用恶魔果实|r 惊喜获得技能|cffff0000 "霸王色的霸气" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*30的伤害，并晕眩0.8秒|r',6)
                end   
                

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

