

ac.guoshi_list = {
    '大吉大利','死吻','剑刃风暴','刀刃旋风',
    '痛苦尖叫','死亡脉冲','击地','穿刺',
    '死亡飞镖','死亡之指'
}
-- print(12342342323)
for i=1,#ac.guoshi_list do 
    local name = ac.guoshi_list[i]
    --物品名称
    local mt = ac.skill[name..'的恶魔果实']
    mt{
    --等久
    level = 1,

    --图标
    art = [[guoshi.blp]],

    --说明
    tip = [[%strong_skill_name%的恶魔果实， 食用后可获得技能强化效果
宠物可帮忙食用]],

    --品质
    color = '紫',

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
    content_tip = '使用说明：'
    }

    function mt:on_cast_start()
        local hero = self.owner
        local target = self.target
        local items = self
        local player = hero:get_owner()
        hero = player.hero
        -- print(self.strong_skill_name)
        if not hero.strong_skill then 
            hero.strong_skill = {}
        end  
        if hero.strong_skill[self.strong_skill_name] then 
            player:sendMsg('【系统消息】 你的技能：|cff'..ac.color_code['红']..self.strong_skill_name..'|r，已强化成功')
            self:add_item_count(1)
            return 
        end    
        local skill = hero:find_skill(self.strong_skill_name)
        if skill then 
            hero.strong_skill[self.strong_skill_name] = true
            skill:strong_skill_func()
        else
            player:sendMsg('【系统消息】 请先学习技能：|cff'..ac.color_code['红']..self.strong_skill_name..'|r，强化失败')
            self:add_item_count(1)    
            return 
        end    
    end

end    
