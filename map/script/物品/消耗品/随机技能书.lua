local mt = ac.skill['随机技能书']
mt{
    --等久
    level = 1,
    --图标
    art = [[other\suijijineng.blp]],
    --说明
    tip = [[点击获取 随机技能]],
    --物品类型
    item_type = '消耗品',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    --购买价格
    gold = 1000,
    --物品技能
    is_skill = true,
    --随机技能个数
    cnt = 4,
    --技能模型
    _model = ac.zb_color_model['书'],
    model_size = 1.5,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
    cus_type = '技能' --类型

}

function mt:on_add()
    self.first_use =true
end
function mt:on_cast_start()
    local hero = self.owner
    local owner = self.owner
    local player = hero:get_owner()
    -- hero = player.hero
    local item = self 
    local list = {}

    -- if not self.skill_list_xs then 
        self.skill_list_xs = {}
        for i=1,self.cnt do 
            local skl_list = ac.skill_list2
            local name = skl_list[math.random(#skl_list)]
            table.insert(self.skill_list_xs,name)
        end 
    -- end    
    
    for _,skill_name in ipairs(self.skill_list_xs) do
        local skill = ac.skill[skill_name]
        local info = {
            name = skill:get_name() .. '  (' .. (skill.skill_type or '') ..')' ,
            skill = skill,
        }
        table.insert(list,info)
    end    

    if #list == 0 then
        player:sendMsg("没有技能可添加")

        if self._count > 1 then 
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            owner:add_item(self.name)
        end   

        return
    end 

    -- local info = {
    --     name = '取消 (Esc)',
    --     key = 512
    -- }
    -- table.insert(list,info)
    
    if not self.dialog  then 
        self.dialog = create_dialog(player,'选择你要的技能',list,
        function (index)
            self.dialog = nil
            local skill = list[index].skill
            if skill then 
                if hero:is_alive() then 
                    ac.item.add_skill_item(skill:get_name(),hero)
                    if self._count > 0 then  
                        self:on_cast_start()
                        self:add_item_count(-1)
                    end  
                else
                    if hero.suijijineng_trg then hero.suijijineng_trg:remove() end
                    hero.suijijineng_trg = hero:event '单位-复活' (function ()
                        ac.item.add_skill_item(skill:get_name(),hero)
                        hero.suijijineng_trg:remove()
                    end)    
                end     

            else
                --取消(没有取消)
                if self._count > 1 then 
                   self:add_item_count(1) 
                else
                    --重新添加给英雄
                    owner:add_item(self.name)
                end             
            end 
        end)
    else
        self:add_item_count(1)    
    end    

end 

