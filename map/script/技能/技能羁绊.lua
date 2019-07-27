--技能羁绊
local mt = ac.skill['赤灵传奇']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['全属性'] = 5000000,
    ['物品获取率'] = 35,
    ['杀敌数加成'] = 35,
    ['木头加成'] = 35,
    ['火灵加成'] = 35,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时发送给全部玩家的tip
    on_add_tip = [[财富+贪婪者的心愿+凰燃天成+龙凤佛杀，激活赤灵传奇，获得额外属性：全属性+500万，物品获取率+35%，杀敌数加成+35%，木头加成+35%，火灵加成+35%]],
    --获得时发送给全部玩家的tip
    send_tip = [[财富+贪婪者的心愿+凰燃天成+龙凤佛杀，激活赤灵传奇，获得额外属性：全属性+500万，物品获取率+35%，杀敌数加成+35%，木头加成+35%，火灵加成+35%]]
}

local mt = ac.skill['血牛']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['生命上限%'] = 25,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[嗜血术+吸血鬼+血焰神脂+血雾神隐，激活血牛，获得额外属性：生命上限加成+25%]],
    --发送给全部玩家的tip
    send_tip =[[嗜血术+吸血鬼+血焰神脂+血雾神隐，激活血牛，获得额外属性：生命上限加成+25%]],
}


local streng_skill_list = {
    --羁绊技能，'要求技能1 要求技能2 ..'
    {'赤灵传奇','财富 贪婪者的心愿 凰燃天成 龙凤佛杀'},
    {'血牛','嗜血术 吸血鬼 血焰神脂 血雾神隐'},
    -- {'赤灵传奇','财富 贪婪者的心愿'},
    -- {'血牛','嗜血术 吸血鬼'},
 
}
--统一处理 
ac.skill_list5 = {}
for i,data in ipairs(streng_skill_list) do
    local target_skill ,source_skills = table.unpack(data)
    local mt = ac.skill[target_skill]
    mt.need_skills = {}
    for name in source_skills:gmatch '%S+' do
        table.insert(mt.need_skills,name)
    end
    table.insert(ac.skill_list5,target_skill)    
    --激活是发送文字信息
    function mt:on_add()
        local p = self.owner:get_owner()
        p:sendMsg(send_tip,5)
    end    
end    
--@要合成的skill
--@传入的skill(材料)
local function get_steng(hero,target_skill,in_skill)
    local flag 
    local has_cnt = 0
    local mt = ac.skill[target_skill]
    --查找人身上是否技能满足
    for i,name in ipairs(mt.need_skills) do
        if name == in_skill then 
            has_cnt = has_cnt + 1
        else    
            local skl = hero:find_skill(name,nil)
            if skl then 
                has_cnt = has_cnt + 1
            end    
        end    
    end        
    if has_cnt ==#mt.need_skills then 
        flag = true 
    end    
    return flag
end    


ac.game:event '技能-获得' (function (_,hero,self)
    if not hero:is_hero() then return end
    if self.item_type then return end

    for i,target_skill in ipairs(ac.skill_list5) do 
        local flag = get_steng(hero,target_skill,self.name)
        if flag then 
            local has_skill = hero:find_skill(target_skill,nil)
            if not has_skill then 
                local new_skill = hero:add_skill(target_skill,'隐藏') --增加新技能
                --改老技能的文字说明
                for i,name in ipairs(new_skill.need_skills) do
                    local skl = hero:find_skill(name,nil)
                    if skl then 
                        skl.old_tip = skl.tip
                        skl.tip = skl.tip..'\n'..new_skill.on_add_tip
                        skl:fresh_tip()
                    end   
                end  
            end    
        end    
    end    

end)

ac.game:event '技能-失去' (function (_,hero,self)
    if not hero:is_hero() then return end
    if self.item_type then return end
    for i,target_skill in ipairs(ac.skill_list5) do 
        local flag = get_steng(hero,target_skill,self.name)
        if flag then 
            local has_skill = hero:find_skill(target_skill,nil)
            if has_skill then 
                has_skill:remove()--移除技能
                --改老技能的文字说明
                for i,name in ipairs(has_skill.need_skills) do
                    local skl = hero:find_skill(name,nil)
                    if skl then 
                        skl.tip = skl.old_tip
                        skl:fresh_tip()
                    end   
                end  
            end    
        end    
    end    

end)    



