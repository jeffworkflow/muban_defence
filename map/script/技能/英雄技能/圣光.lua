local mt = ac.skill['圣光']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 治疗",
	--耗蓝
	cost = {20,130,240,350,460},
	--冷却时间
	cool = 15,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 回复指定队友 %life_rate% %的血
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNHolyBolt.blp]],
	--特效
	effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
	--生命上限比
	life_rate = {20,30,40,50,60},
	--目标允许	
	target_data = '联盟 玩家单位 自己',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()

	local hero = self.target

	if  hero and hero:is_alive() then 

		hero:add_effect('overhead',self.effect):remove()
		hero:heal
		{
			source = hero,
			skill = self,
			size = 10,
			string = self.name,
			heal = hero:get('生命上限')*self.life_rate/100 *( 1 + hero:get('主动释放的增益效果')/100),
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
