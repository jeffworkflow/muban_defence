local mt = ac.skill['神技大礼包']
mt{
--等久
level = 0,
--图标
art = [[sjdlb.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00随机技能1个
技能升级书lv1-lv4各一本 |cffff0000可直接将技能升到顶级|r
|cff00ff00恶魔果实1个 |cffff0000可直接强化顶级技能|r
|cffffff00神装大礼包+神技大礼包激活：吞噬丹*1 点金石*30  恶魔果实*1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}
function mt:on_add()
    local hero = self.owner
    local target = self.target
    local p = hero:get_owner()
    local peon = p.peon
    if peon:has_item(self.name) then 
        return 
    end   
    peon:add_item('神技大礼包 ') 
end    


local mt = ac.skill['神技大礼包 ']
mt{
--等久
level = 1,
--图标
art = [[sjdlb.blp]],
is_order = 1,
item_type ='消耗品',
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00随机技能1个
技能升级书lv1-lv4各一本 |cffff0000可直接将技能升到顶级|r
|cff00ff00恶魔果实1个 |cffff0000可直接强化顶级技能|r
|cffffff00神装大礼包+神技大礼包激活：吞噬丹*1 点金石*30  恶魔果实*1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero

    --添加吞噬丹
    if not p.mall_flag[self.name] then 
        self.owner:add_item('恶魔果实',true)
        --给英雄随机添加随机技能
        local name = ac.skill_list2[math.random(1,#ac.skill_list2)]
        ac.item.add_skill_item(name,self.owner)
        --添加4本技能书
        for i=1,4 do
            self.owner:add_item('技能升级书Lv'..i,true)
        end    
    end    
end    
