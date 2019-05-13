local mt = ac.skill['回旋刃']
mt{
    --等级
    level = 1,
    max_level = 5,
    --是被动
    passive = true,
    is_skill = true,
	--技能类型
	skill_type = "被动 力量",

    --原始伤害
    damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('力量')*self.int+self.shanghai
		end	
	end,

    int = {5,6,7,8,10},

    shanghai ={5000,50000,500000,125000,2000000},

    --释放几率
    chance = 15,
    
    cool = 1,
    --图标
    art = [[huixuanren.blp]],
    --投射物数量
    count = 2,

    --move_distance
    distance = 500,

    --碰撞范围
    hit_area = 150,

    --停留时长
    stay_time = 0.5,
    
    --回旋伤害比
    cycle_round_damage = 25,

    --投射物模型
    model = [[SentinelMissile.mdx]],
    title = '回旋刃',
    tip = [[
|cff11ccff%skill_type%:|r 攻击时 %chance% % 几率发射 %count% 个回旋刃，以目标为起始点向前移动 %distance% 距离对碰到单位造成伤害，停留 %stay_time% s后以最快的速度返回到英雄位置，回旋时造成 %cycle_round_damage% % 伤害
伤害计算：|cffd10c44力量 * %int%|r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r]],

}


function mt:on_add()
    local skill = self
    local hero = self.owner
    --记录默认攻击方式
    if not hero.oldfunc then
        hero.oldfunc = hero.range_attack_start
    end

    --新的攻击方式
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local target = damage.target
        local max_damage = self.current_damage
        --投射物数量
        local count = hero:get '额外投射物数量' + self.count 
       
		local unit_mark = {}

		for i,u in ac.selector()
			: in_range(hero,hero:get('攻击距离'))
			: is_enemy(hero)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: set_sort_first(target)
			: ipairs()
     	do
			if i <= 1 then
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
                    }
                    local angle = u:get_point()  / hero:get_point()
                    for i = 1,count do

                        -- 进行一次创造回旋刃，进行前移，停滞，返回
                        -- 目标 英雄，起始点 第一次投射物命中单位，先反方向移动 500距离，再停留，再折回。
                        local source = u:get_point():copy()
                        local stay_time = skill.stay_time 

                        -- local circle_target = ac.selector():in_range(u,skill.boom_area): is_enemy(hero):is_not(u): of_not_building(): random()
                        local angle = angle + (count / 2 - count - 0.5 + i) * 17.5




                        local mvr = ac.mover.target
                        {
                            source = hero,
                            start = source,
                            target = hero,
                            model = self.model,
                            angle =  angle,
                            turn_speed = 0,
                            speed = -1000,
                            skill = skill,
                            stay_time = skill.stay_time ,
                            hit_area = skill.hit_area,
                        }
                        if not mvr then
                            return
                        end
                          
                        --每0.03秒运动一次， 一次距离为 500*0.03，每次运动15距离。
                        function mvr:on_move()
                            local p1, p2 = self.mover:get_point(), self.target:get_point()
                            local target_angle = p1 / p2
                            
                            self.speed = self.speed + 20

                            if self.speed >= 0 then
                                --停滞，变换角度
                                if  self.stay_time > 0 then 
                                    self.stay_time = self.stay_time - 0.03 
                                    return
                                end      
                                self.speed = 1500 
                                self.angle = target_angle  
                                --后半段碰击
                                self.second_mover_hit = true
                            end    
                        
                        end   
                        --碰撞到单位的处理
                        local hited = {} 
                        function mvr:on_hit(dest)
                            hited[dest] = {}

                            if hited[dest][1] and hited[dest][2] then
                                return
                            end    

                            if not hited[dest][1] then

                                dest:damage
                                {
                                    source = hero,
                                    damage = max_damage * skill.cycle_round_damage/100,
                                    skill = skill,
                                    missile = self.mover,
                                }
                                hited[dest][1] =true

                            end

                            --二段伤害，只能在回溯时产生
                            if self.second_mover_hit then 
                                --必须要已造成一段伤害,且二段伤害还没产生时，才进行二段伤害。
                                if  hited[dest][1] and not hited[dest][2] then
                                    dest:damage
                                    {
                                        source = hero,
                                        damage = max_damage * skill.cycle_round_damage/100,
                                        skill = skill,
                                        missile = self.mover,
                                    }
                                    hited[dest][2] =true
                                end
                            end

                        end    
                    end
					--return true
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