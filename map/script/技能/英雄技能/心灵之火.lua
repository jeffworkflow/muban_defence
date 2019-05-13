local mt = ac.skill['心灵之火']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = {10,110,210,310,450},
	--冷却时间
	cool = 7,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 增加指定队友40%的攻击力，持续15S
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNInnerFireOn.blp]],
	--特效
	effect = [[Abilities\Spells\Human\InnerFire\InnerFireTarget.mdl]],
	--攻击力
	attack = {40,50,75,100,150},
	--持续时间
	time = 15,
	--目标允许	
	target_data = '联盟 玩家单位 自己',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()
	local skill = self
	local hero = self.target

	if  hero and hero:is_alive() then 

		hero:add_buff '心灵之火'
		{
			skill = skill,
			model = skill.effect,
			value = skill.attack,
			time = skill.time
		}
	end	

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


local mt = ac.buff['心灵之火']
mt.ref = 'overhead' 
mt.cover_type = 1
mt.cover_max = 1
mt.keep = true

function mt:on_add()
	local hero =self.target;
	self.eff = hero:add_effect(self.ref,self.model)

	hero:add('攻击%',self.value * (1+hero:get('主动释放的增益效果')/100))

end

function mt:on_remove()
	if self.eff then self.eff:remove() self.eff =nil end 
	if self.trg then self.trg:remove() self.trg =nil end 

	local hero =self.target;
	hero:add('攻击%',- self.value * (1+hero:get('主动释放的增益效果')/100))
	
end
function mt:on_cover(new)
	return new.value > self.value
end