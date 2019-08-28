local mt = ac.skill['风暴之力']
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
	--技能类型
    skill_type = "被动,智力",
    --cd
    cool =1,
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10000)* self.level
end,
	--属性加成
 ['攻击加智力'] = {200,400,600,800,1000},
	--介绍
	tip = [[
        
|cffffff00【攻击加智力】+200*Lv

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(智力*15+1w)*Lv

]],

    --自由碰撞时的碰撞半径
    hit_area = function(self,hero)
        return 100 + hero:get '额外范围'
    end,
    --移动距离
    dis = 550,
    --图标
    art ='fengbaozhili.blp',
    model = [[AZ_Kaer_X1.mdx]],
    damage_type = '法术'
}
--分散龙卷风
local function tornado(skill,target,max_damage)
    local hero = skill.owner
    --角度
    local angle = 45
    --移动距离
    local dis = 350
    --碰撞范围
    local areaa = skill.hit_area
    --伤害
    local damage = max_damage * 0.1
    for i=0,3 do
        angle = angle + i * 90
        mvr = ac.mover.line
        {
            source = hero,
            model = skill.model,
            angle = angle,
            distance = dis,
            speed = 500,
			skill = skill,
			damage = damage,
            hit_area = areaa,
            start = target,
            size = 0.7,
        }
        if mvr then
            function mvr:on_hit(dest)
                dest:damage
                {
                    source = hero,
                    skill = skill,
                    damage = damage,
                    damage_type = skill.damage_type,
                }
            end
        end

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
        local area = self.hit_area
        local distance1 =  target:get_point() * hero:get_point() 
        if distance1 >=200 then 
            distance1 = 200
        end    

        mvr = ac.mover.line
        {
            source = hero,
            model = self.model,
            angle = hero:get_point()/target:get_point(),
            distance = self.dis,
            speed = 700,
			skill = self,
			damage = max_damage,
            hit_area = area,
            start = target:get_point() -{target:get_point()/hero:get_point(),distance1} 
        }

        if not mvr then
            return
        end

        function mvr:on_hit(dest)
            local mover = mvr.mover
            dest:damage
            {
                source = hero,
                skill = self.skill,
                damage = max_damage,
                damage_type = skill.damage_type,
            }
        end

        function mvr:on_remove()
            tornado(self.skill,mvr.mover:get_point(),max_damage)
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
