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
     --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
     --提示的tip
    send_tip = [[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "赤灵传奇" |r，|cff00ff00全属性+500万，物品获取率+35%，杀敌数加成+35%，木头加成+35%，火灵加成+35%|r]]
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
    ['力量%'] = 25,
    ['杀怪加力量'] = 1500,
    ['攻击加力量'] = 1500,
    ['每秒加力量'] = 1500,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
    --发送给全部玩家的tip
    send_tip =[[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "血牛" |r，|cff00ff00力量加成+25%，杀怪加力量/攻击加力量/每秒加力量+1500|r]],
}

local mt = ac.skill['疾风']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['敏捷%'] = 25,
    ['杀怪加敏捷'] = 1500,
    ['攻击加敏捷'] = 1500,
    ['每秒加敏捷'] = 1500,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
    --发送给全部玩家的tip
    send_tip =[[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "疾风" |r，|cff00ff00敏捷加成+25%，杀怪加敏捷/攻击加敏捷/每秒加敏捷+1500|r]],
}

local mt = ac.skill['为爆炸而生']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['暴击几率'] = 5,
    ['暴击加深'] = 200,
    ['技暴几率'] = 10,
    ['技暴加深'] = 100,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
    --发送给全部玩家的tip
    send_tip =[[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "为爆炸而生" |r，|cff00ff00暴击几率+5%,暴击加深+200%，技暴几率+10%,技暴加深+100%|r]],
}

local mt = ac.skill['冰火三重天']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['技暴几率'] = 10,
    ['技暴加深'] = 100,
    ['技能伤害加深'] = 20,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
    --发送给全部玩家的tip
    send_tip =[[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "冰火三重天" |r，|cff00ff00技暴几率+10%，技暴加深+100%，技能伤害加深+20%|r]],
}

local mt = ac.skill['三千世界']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--被动
	passive = true,
	--属性加成
    ['攻击减甲'] = 88,
    ['攻击速度'] = 100,
    ['攻击间隔'] = -0.15,
	--技能图标
    art = [[jineng\jineng019.blp]],
    --获得时给每个材料技能添加的文字
    on_add_tip = [[]],
    --发送给全部玩家的tip
    send_tip =[[|cffffe799【系统消息】|r 恭喜获得隐藏羁绊技能|cffff0000 "三千世界" |r，|cff00ff00攻击减甲+88，攻击速度+100%，攻击间隔-0.15|r]],
}

local streng_skill_list = {
    --羁绊技能，'要求技能1 要求技能2 ..'
    {'赤灵传奇','财富 贪婪者的心愿 凰燃天成 龙凤佛杀'},
    {'血牛','嗜血术 吸血鬼 血焰神脂 血雾神隐'},
    {'疾风','刀刃旋风 疾步风 暴风雪 风暴之力'}, 
    {'为爆炸而生','狂龙爆 红莲爆 渡业妖爆'}, 
    {'冰火三重天','暴风雪 风暴之力 炎爆术'}, 
    {'三千世界','剑空破 审判之剑 雷霆之剑'}, 
    
    -- {'赤灵传奇','财富 贪婪者的心愿'},
    -- {'血牛','嗜血术 吸血鬼'},
 
}
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
        p:sendMsg(self.send_tip,5)
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
                        skl.tip = skl.tip..new_skill.on_add_tip
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
        local sk = ac.skill[target_skill]
        local need_skill_str = table.concat(sk.need_skills)
        if finds(need_skill_str,self.name) then 
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
    end    

end)    



