local mt = ac.skill['群体治疗']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 治疗",
	--耗蓝
	cost = {40,150,260,370,500},
	--冷却时间
	cool = 15,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 回复全体队友%life_rate% %的血
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNScrollOfTownPortal.blp]],
	--特效
	effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
	--生命上限比
	life_rate = {15,20,25,30,35},
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()

	for i = 1,10 do 
        local player = ac.player(i)
		local hero = player.hero

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

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
