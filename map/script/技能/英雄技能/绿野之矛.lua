local mt = ac.skill['绿野之矛']
mt{
    --等级
    level = 1,
    max_level = 5,
    is_skill = true,
    --是被动
    passive = true,
	--技能类型
	skill_type = "被动 智力",

    --原始伤害
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('智力')*self.int+self.shanghai
		end
	end	,

    int = {5,7.5,10,12.5,15},

    shanghai ={5000,50000,500000,125000,2000000},

    --释放几率
    chance = 15,
    --cd
    cool = 1,

    --投射物数量
    count = 4,
    --图标
    art = 'lvyezhimao.blp',

    --buff持续时间
    time = 3,


    --投射物模型
    model = [[lvyezhimao.MDX]],
    title = '绿野之矛',
    tip = [[
|cff11ccff%skill_type%:|r %chance% % 几率对敌人发射 %count% 只绿野之矛造成伤害
伤害计算：|cffd10c44智力 * %int% |r + |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r
]],
}
function mt:on_add()
    local hero = self.owner
    local skill = self
    --记录默认攻击方式
    if not hero.oldfunc then
        hero.oldfunc = hero.range_attack_start
    end
    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local u_group = {}
        local target = damage.target
        local max_damage = self.current_damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count - 1
       
		local unit_mark = {}

		for i,u in ac.selector()
			: in_range(hero,hero:get('攻击距离'))
			: is_enemy(hero)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: set_sort_first(target)
			: ipairs()
     	do
			if i <= count then
				local mvr = ac.mover.target
				{
					source = hero,
					target = u,
					model = self.model,
					speed = 1500,
					skill = skill,
				}
				if not mvr then
					return
                end
                
				function mvr:on_finish()
                    u:damage
                    {
                        source = hero,
                        damage = max_damage,
                        skill = skill,
                        missile = self.mover,
                        damage_type = '法术'
                    }
				end
			end	
        end
        
        --添加buff
        if math.random(100) <= 35 then
            local tbl = {}
            for unit,_ in pairs(ac.hero.all_heros) do
                table.insert(tbl,unit)
            end
            
            local p = ac.point(0,0)
            table.sort(tbl,function (a,b)
                return a:get_point() * p < b:get_point() * p
            end)

            for index,unit in ipairs(tbl) do 
                if unit and not unit.lyzm and unit:is_alive() and not unit:find_buff('绿野之矛') then
                    unit.lyzm = true
                    unit:add_buff '绿野之矛'{
                        skill = self,
                        time = self.time,
                    }
                end
            end 
        end
        
      --还原默认攻击方式
      hero.range_attack_start = hero.oldfunc
    end    

	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            self = self:create_cast()
            --当前伤害要在回调前初始化
            self.current_damage = self.damage
            
            hero:event_notify('触发天赋技能', self)

            --hero.range_attack_start = range_attack_start
            range_attack_start(hero,damage)
            --激活cd
            skill:active_cd()
        end 

        return false
    end)

end


function mt:on_remove()
    local hero = self.owner
    hero.range_attack_start = hero.oldfunc
    self.trg:remove()
end


local mt = ac.buff['绿野之矛']
-- 共存模式
mt.cover_type = 1
-- 只有1个同名buff生效
mt.cover_max = 1

mt.pulse = 1

function mt:on_add()
    local hero = self.target
    self.eff = hero:add_effect('chest',[[Abilities\Spells\NightElf\Rejuvenation\RejuvenationTarget.mdx]])
end

-- 叠加事件
function mt:on_cover(new)
	return false
end

function mt:on_pulse()
	local hero = self.target

    local max_life = hero:get '生命上限'
	hero:heal
	{
		source = hero,
		skill = self.skill,
		heal = max_life  / 100 + self.skill.owner:get '智力' * 0.3,
	}
end


function mt:on_remove()
    local hero = self.skill.owner
    self.eff:remove()
    self.target.lyzm = nil
end
