local mt = ac.skill['技能升级书']

mt{
    --等久
    level = 1,
    
    --图标
    art = [[other\shengjishu.blp]],
    
    --说明
    tip = [[使用后升级一次指定技能]],

    --物品类型
    item_type = '技能',
    
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    
    --物品技能
    is_skill = true,
    --物品详细介绍的title
    skill_cnt = 8,
    content_tip = '使用说明：'
    
}
    
function mt:on_add()
    self.first_use =true
end
function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    --宠物也帮忙升级
    hero = player.hero
    local item = self 
    local list = {}
    for i=1,self.skill_cnt do 
        local skill = hero:find_skill(i,'英雄')
        if skill then 
            local upgrade_count = skill.upgrade_count or 1
            if upgrade_count < 5  then 
                local price = upgrade_count * 500
                local info = {
                    name = skill:get_name() .. ' ' .. (skill:get_level() + 1) .. ' 级 (' .. skill:get_hotkey() ..')' ,
                    key = skill:get_hotkey():byte(),
                    skill = skill,
                }
                table.insert(list,info)
            end 
        end    
    end 
    local name = self.name
    if #list == 0 then
        player:sendMsg("没有可以升级的技能。")

        if self._count > 1 then 
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            hero:add_item(name,true)
        end   

        return
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)
    
    if not self.dialog  then 
        self.dialog = create_dialog(player,'选择你要升级的技能',list,
        function (index)
            self.dialog = nil
            local skill = list[index].skill
            if skill then 
                local upgrade_count = skill.upgrade_count or 1
                skill:set_level(skill:get_level() + 1)
                skill.upgrade_count = (upgrade_count + 1)
                if self._count > 0 then  
                    self:on_cast_start()
                    self:add_item_count(-1)
                end    
            else
                --取消
                if self._count > 1 then 
                   self:add_item_count(1) 
                else
                    if hero:is_alive() then 
                        --重新添加给英雄
                        hero:add_item(name,true)
                    else    
                        if hero.shengjishu_trg then hero.shengjishu_trg:remove() end
                        hero.shengjishu_trg = hero:event '单位-复活' (function ()
                            hero:add_item(name,true)
                            hero.shengjishu_trg:remove()
                        end) 
                    end    
                end      
            end 
        end)
    else
        self:add_item_count(1)    
    end    

end 
