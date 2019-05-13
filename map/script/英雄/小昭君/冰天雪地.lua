local mt = ac.skill['冰天雪地']
mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,

    title = '冰天雪地',
    tip = [[
		主动：在周围 %hit_area% 码降下暴风雪，每1秒造成 攻击力*2+智力*4点 法术伤害( %damage% )，并晕眩 %yun_time% 秒，同时刷新寒冰护盾。
		
		被动1（寒冰护盾）：每 %pulse_time% 秒自身获得一个护盾， 护盾可抵免 攻击力*1+智力*3点 伤害 (%shield%) 

		被动2：对眩晕的敌人，额外造成 攻击力*1+智力*3 点的法术伤害 (%yun_damage%)
	]],

	--技能图标
	art = [[jineng\jineng012.blp]],

	--cd 45
	cool = {40,30,20,15,10},

	--耗蓝
	cost = {60,250,450,640,1350},
    --伤害
    damage = function(self,hero)
        return hero:get '攻击' * 2 + hero:get '智力' * 4
	end,
	
    --伤害
    yun_damage = function(self,hero)
        return hero:get '攻击' * 1 + hero:get '智力' * 3
    end,

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	
    --持续时间
	time = {3,3.5,4,4.5,5},
	
    --晕眩时间
	yun_time = 0.3,
	
    --护甲
    defence_rate = 300,

    --暴风雪波数
	count = function(self,hero)
		return self.time
	end	,

    --碎片数量
    de_count = 24,

	--范围
    hit_area = function(self,hero)
        return 600
    end,
   
    --生成护盾时间
	pulse_time = {8,7,6,5,4},

    --护盾抵消伤害
	shield = function(self,hero)
        return hero:get '攻击' * 1 + hero:get '智力' * 3
	end,

	--暴风雪特效
    effect = [[Abilities\Spells\Human\Blizzard\BlizzardTarget.mdx]],
}

--创建暴风雪
local function tornado(skill,target,area,damage)
    local hero = skill.owner
    for i=1,skill.de_count do
        local angle = math.random(1, 360)
        local p = target - {angle, math.random(1, area)}
        --创建暴风雪特效
        local eff = ac.effect(p,skill.effect,0,1,'origin'):remove()
    end

    ac.wait(700,function()
		for _, u in ac.selector():in_range(target,area):is_enemy(hero):ipairs() do
			--被动2
			if u:find_buff('晕眩') then
				damage = damage + skill.yun_damage
			end	

			u:add_buff '晕眩'
			{
				source =hero,
                skill = skill,
                time = skill.yun_time,
			}

            u:damage{
                source = hero,
                skill = skill,
                damage = damage,
                damage_type = '法术'
			}
			
        end
    end)
end

local function add_shield(skill)
	local hero = skill.owner
	if not hero:find_buff('寒冰护盾') then 
		hero:add_buff '寒冰护盾'
		{
			life = skill.shield,
			skill = skill,
		}
	end	

end
function mt:on_add()
	local hero = self.owner
	--被动1 增加护盾
	add_shield(self)

	self.trg1 = hero:event '单位-复活'(function()
		--被动1 增加护盾
		add_shield(self)
		
	end)
end

function mt:on_cast_shot()

    local hero = self.owner
	local max_damage = self.damage
	local target = self.owner:get_point()
	local area = self.hit_area
	--创建一个施法圈
	-- local eff = ac.effect(target,[[mr.war3_ring.mdx]],0,area/200,'origin')

	--先执行一次，后没0.7秒执行一次
	tornado(self,target,area,max_damage)
	self.trg = hero:timer(0.7 * 1000,self.time /0.7, function()
		--执行一次
		tornado(self,target,area,max_damage)
		
	end)
	
	ac.wait(self.time*1000,function()
		-- if eff:remove()
	end)	

	--增加护甲处理
	hero:add_buff('冰天雪地-护甲')
	{
		defence_rate = self.defence_rate,
		skill = self,
		time = self.time,
	}
	--马上加寒冰护盾
	add_shield(self)

end	

function mt:on_remove()
	local hero = self.owner
	if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end	
	if self.trg1 then 
		self.trg1:remove()
		self.trg1 = nil 
	end	
end


local mt = ac.buff['冰天雪地-护甲']

mt.cover_type = 1


function mt:on_add()
	self.target:add('护甲%',self.defence_rate)
	-- self.eff = self.target:add_effect('chest', self.effect)
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:add('护甲%',-self.defence_rate)
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end




local mt = ac.shield_buff['寒冰护盾']

function mt:on_add()
	--添加护盾破碎时，特效消失。 
	--英萌通用特效如果 持续时间太长，无法关掉这个特效。
	--时间短的情况下没有进行测试，如果没有自动删除，可用如下代码删。
    local hero =self.target;
	self.trg = hero:event '受到伤害效果' (function(trg, damage)
		-- print("剩余护盾值",self.life)
		
		if self.life <= 0 then
		   local buff = hero:find_buff '通用-护盾特效'
		   if buff then
				buff:remove()
			
		   end	
		end   
		
	end	);
end
function mt:on_remove()
	self.trg:remove();
	--被动1 增加护盾
	ac.wait(self.skill.pulse_time * 1000 ,function()
		add_shield(self.skill)
	end);

end
function mt:on_cover()
	
end
