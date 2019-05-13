local mt = ac.skill['魔龙之心']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 0,
    --魔法书
    is_order = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
    tip = [[%active%
|cffffff00特权：|r杀怪全属性+5，经验获取率+25%，开局赠送一颗吞噬丹（发放至宠物背包）]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end, 
	--技能图标
	art = [[mlzx.blp]],
	--特效
	effect = [[]],
    --杀怪全属性
    killer_attr = 5,
    --经验加成
    xp_rate = 25,
    --吞噬丹个数
    tsd_cnt = 1
    
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    local p = hero:get_owner()
    local peon = p.peon
    hero:add('经验加成',self.xp_rate)
    hero:add('杀怪全属性',self.killer_attr)
    --加在宠物身上
    for i =1 ,self.tsd_cnt do 
        peon:add_item('吞噬丹',true)
    end    
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('经验加成',-self.xp_rate)
    hero:add('杀怪全属性',-self.killer_attr)
end
