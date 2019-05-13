local mt = ac.skill['正义轰爆']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,

	max_level = 5,
	
	
	tip = [[
		主动：对指定区域的敌人进行轰炸，造成攻击力* %attack% 的物理伤害( %damage% )，并砸晕敌人 %time% 秒
		被动1：增加 %defence_rate% % 的护甲
		被动2：增加 %reduce_rate% % 的减伤
	]],
	
	--技能图标
	art = [[jineng\jineng002.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,

	--施法范围
	area = 400,

	--持续时间
	time = 2,

	--伤害参数1：攻击力
	attack = {12.5,15,17.5,20,25},

	--伤害
	damage = function(self,hero)
		return hero:get('攻击')*self.attack 
	end,	

	--护甲
	defence_rate = 50,

	--减免
	reduce_rate = 30,

	--cd
	cool = 10,

	--耗蓝
	cost = {30,130,250,400,600},

	--特效模型
	effect = [[AZ_Doomdragon_T.mdx]],
	-- effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	
	--施法距离
	range = 600,
}


function mt:on_add()
	local hero = self.owner 
	hero:add('护甲%',self.defence_rate)
	hero:add('减免',self.reduce_rate)
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	local target = self.target
	local point = target:get_point()
	-- print(point)
	--在目标区域创建特效

	self.eff = ac.effect(point, self.effect, 270, 1,'origin')
	
	ac.wait(2000,function () 
		self.eff:remove()
	
	end)
	
	-- self.eff = point:add_effect(self.effect):remove()

	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			source = hero,
			time = self.time,
		}
		u:damage
		{
			source = hero,
			damage = self.damage,
			skill = self
		}
	end	

end

function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
	hero:add('护甲%',-self.defence_rate)
    hero:add('减免',-self.reduce_rate)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end
