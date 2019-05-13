local mt = ac.skill['风暴之力']
mt{
    --等级
    level = 1,
    max_level = 5,
    --是被动
    passive = true,
    is_skill = true,

    skill_type = "被动 智力",
    --伤害
    damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('智力')*self.int+self.shanghai
		end
	end	,
    
    int = {5,6,7,8,10},
    shanghai ={5000,50000,500000,125000,2000000},


    --释放几率
    chance = 15,
    cool = 1,

    --自由碰撞时的碰撞半径
    hit_area = function(self,hero)
        return 100 + hero:get '额外范围'
    end,

    --移动距离
    dis = 550,

    --图标
    art ='fengbaozhili.blp',

    --异步下数据 只作为文本提示
    areaa = 100,

    --几率
    my_chance = {5,7.5,10,12.5,15},

    --模型
    model = [[AZ_Kaer_X1.mdx]],
    title = '风暴之力',
    tip = [[|cff11ccff%skill_type%:|r  %my_chance% % 几率发动一个龙卷风向前方移动 %dis% 码，对经过的范围 %areaa% 区域造成伤害,龙卷风到达终点时分裂出四个，造成 40% 伤害
伤害计算：|cffd10c44智力 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r
]],
}

--分散龙卷风
local function tornado(skill,mover,max_damage)
    local hero = skill.owner
    --角度
    local angle = 45
    --移动距离
    local dis = 350
    --碰撞范围
    local areaa = skill.hit_area
    --伤害
    local damage = max_damage * 0.4
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
            start = mover:get_point(),
            size = 0.7,
        }
        if mvr then
            function mvr:on_hit(dest)
                local mover = mvr.mover
                dest:damage
                {
                    source = hero,
                    skill = skill,
                    damage = damage,
                    damage_type = '法术',
                    attack = true,
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
                damage_type = '法术',
                attack = true,
            }
        end

        function mvr:on_remove()
            tornado(self.skill,mvr.mover,max_damage)
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

