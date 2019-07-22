local mt = ac.skill['血雾神隐']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,无敌",
	--被动
	passive = true,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】被攻击35/30/25/20/15次后开启一下技能|r|cffffff00（0.5秒内免疫任何伤害）|r
    
]],
	--技能图标
	art = [[xwsy.blp]],
	--特效
    effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
    cool = 0.5,
    wtf_cnt = {35,30,25,20,15},
    time =0.5
}
function mt:on_add()
    local skill = self
    local hero = self.owner
  
    self.trg = hero:event '受到伤害效果' (function(trg, damage)
        if self:is_cooling() then 
            return 
        end    
        local cast = self:create_cast()
        -- print('受到伤害',self.wtf_cnt)
        if self.wtf_cnt>0 then 
            self.wtf_cnt = self.wtf_cnt -1
        else
            --添加免伤buff
            self.buff = hero:add_buff('免伤几率')
            {
                value = 100,
                time = self.time,
                source = hero,
                skill = self,
            }
            --创建施法表，重新取施法时的数据
            self.wtf_cnt = cast.wtf_cnt
            self:active_cd()
        end    
    end)    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


local mt = ac.buff['免伤几率']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('免伤几率',self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('免伤几率',-self.value)    
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end
