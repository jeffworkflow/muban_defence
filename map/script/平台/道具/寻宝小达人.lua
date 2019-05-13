local mt = ac.skill['寻宝小达人']
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
|cffffff00特权1：|r开局赠送5张藏宝图，5张抽奖券（发放至宠物背包），物品获取率+20%
|cffffff00特权2：|r移速+50，无视碰撞体积]],
	--技能图标
	art = [[xbxdr.blp]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end,    
	--特效
	effect = [[]],
    --藏宝图数量
    cbt_cnt = 5,
    --抽奖券数量
    cash_coupon_cnt = 5,
    --移动速度
    move_speed = 50,
	--物品获取率
    fall_rate = 20,
    
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    local p = hero:get_owner()
    local peon = p.peon
    hero:add('物品获取率',self.fall_rate)
    hero:add('移动速度',self.move_speed)
    for i =1 ,self.cbt_cnt do 
        hero:add_item('藏宝图',true)
    end    
    hero:add_restriction '幽灵'

    for i =1 ,self.cash_coupon_cnt do 
        peon:add_item('抽奖券',true)
    end   
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('物品获取率',-self.fall_rate)
    hero:add('移动速度',-self.move_speed)
    hero:remove_restriction '幽灵'
end
