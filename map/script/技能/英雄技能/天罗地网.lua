local mt = ac.skill['天罗地网']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return (self.level+5)*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
   cool = 1 ,
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*7+10000)* self.level
end,
    --投射物数量
    count = 6,
	--属性加成
 ['攻击加全属性'] = {100,200,300,400,500},
	--介绍
	tip = [[
        
|cffffff00【攻击加全属性】+100*Lv|r

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(全属性*7+1w)*Lv|r

]],
    --模型
    model = [[AZ_TA01_D2.mdx]],
    art = [[feibiao.blp]],
	damage_type = '法术'
}
--计算高度
local function get_hith(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end

--交叉闪电
local function jiaocha_sd(skill,target,damage)
    local hero = skill.owner

    for _, u in ac.selector():in_range(target,500):is_enemy(hero):random_int(3) do
        local ln = ac.lightning('LN06', target, u,get_hith(target),get_hith(u))
        ln:fade(-15)
        --u:add_effect('origin',[[AZ_SSCrow_R.mdx]]):remove()
        u:damage{
            source = hero,
            skill = skill,
            damage = damage,
        }
    end
end

function mt:on_add()
    local hero = self.owner
    local skill = self
    --记录默认攻击方式
    if not hero.oldfunc then
        hero.oldfunc = hero.range_attack_start
    end

    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local max_damage = self.current_damage

        local target = damage.target

        local skill = self


        local u_group = {}
        local target = damage.target
        local max_damage = self.current_damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count - 1
       
		local unit_mark = {}

		for i,u in ac.selector()
			: in_range(hero,hero:get('攻击距离')+500)
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
					speed = 1900,
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
                        damage_type = skill.damage_type
                    }
                    jiaocha_sd(skill,u,max_damage)
				end
			end	
        end
        --还原默认攻击方式
        hero.range_attack_start = hero.oldfunc
    end

    self.trg = hero:event '造成伤害效果' (function(_, damage)
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

