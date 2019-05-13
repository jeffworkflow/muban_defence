local mt = ac.skill['影子']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "召唤 英雄属性",
	--耗蓝
	cost = {60,120,240,480,960},
	--冷却时间40
	cool = 20,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤1只影子助战
	
	|cff00bdec召唤物属性：和英雄属性相关|r
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNMirrorImage.blp]],
	--召唤物
    unit_name = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
         return self.owner:get_name()
        end 
    end,
	--召唤物属性倍数
	attr_mul = {0.6,0.8,1,1.2,1.4},
	--持续时间
	time = 30,
	--数量
	cnt = 1,
}
	
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	
	local cnt = (self.cnt + hero:get('召唤物')) or 1
	--多个召唤物
	for i=1,cnt do 

		local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
		local unit = hero:get_owner():create_unit(self.unit_name,point)	
		unit.unit_type = 'unit'
		unit:remove_ability 'AInv'
        local data = {}
        data.attribute ={
            ['攻击'] = hero:get('攻击'),
			['护甲'] = hero:get('护甲') * 0.5,
			['攻击速度'] = hero:get('攻击速度'),
            ['生命上限'] = hero:get('生命上限'),
            ['魔法上限'] = hero:get('魔法上限'),
            ['生命恢复'] = hero:get('生命恢复'),
            ['魔法恢复'] = hero:get('魔法恢复'),
			['移动速度'] = hero:get('移动速度'),
			['物爆几率'] = hero:get('物爆几率'),
			['物爆伤害'] = hero:get('物爆伤害'),
			['会心几率'] = hero:get('会心几率'),
			['会心伤害'] = hero:get('会心伤害'),
        }

		self.buff = unit:add_buff '召唤物' {
			time = self.time,
			attribute = data.attribute,
			attr_mul = self.attr_mul - 1,
			skill = self,
			follow = true
		}
	end	


end

function mt:on_remove()

    local hero = self.owner 
	--移除时将召唤物移除
    -- if self.buff then
    --     self.buff:remove()
    --     self.buff = nil
	-- end  
	
end