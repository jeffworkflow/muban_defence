local mt = ac.skill['御甲']
mt{
    --等级
    level = 1,
    max_level = 5,
    --是被动
    passive = true,
    is_skill = true,
	--技能类型
	skill_type = "被动 力量",

    --伤害
    damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('力量')*self.int+self.shanghai
		end	
	end,

    int = {5,6,7,8,10},

    shanghai ={5000,50000,500000,125000,2000000},

    --释放几率
    chance = 15,
	--cd
	cool = 1,

    --连锁数量
    count = 5,

    --图标
    art = 'yujia.blp',
	--爆炸半径
    hit_area = function(self,hero)
        if hero then 
            return 100 + hero:get '额外范围'
        else 
            return 100
        end        
    end,

    --模型
    model = [[AZ_[Sepll]LinaSun _T2_Blast.MDX]],
    title = '御甲',
    tip = [[|cff11ccff%skill_type%:|r %chance% % 几率发动御甲对单位造成伤害并向周围连锁 %count% 次,并对周围 %hit_area% 内单位造成 30% 伤害 
伤害计算：|cffd10c44 力量 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r
]]
}

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
        ac.effect(target:get_point(),self.model,0,1,'origin'):remove()
        target:damage
        {
            source = hero,
            skill = self,
            damage = max_damage,
            damage_type = '物理',
        }

        local count = self.count + hero:get '额外连锁数量' - 1

        --已造成闪电链的单位保存进去
        local group = {}
        table.insert(group,target)

        ac.timer(200,count,function()
            u = ac.selector():in_range(target,700):is_enemy(hero)
            for index, value in ipairs(group) do
                u:is_not(value)
            end
            u = u:random()
            if not u then
                return
            end

            target = u
            table.insert(group,target)
            ac.effect(target:get_point(),self.model,0,1,'origin'):remove()
            target:damage
            {
                source = hero,
                skill = self,
                damage = max_damage,
                damage_type = '物理',
            }

            for _, u_t in ac.selector():in_range(target,self.hit_area):is_enemy(hero):is_not(target):ipairs() do
                u_t:damage
                {
                    source = hero,
                    skill = self,
                    damage = max_damage * 0.3,
                    damage_type = '物理',
                }
            end
        end)

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

