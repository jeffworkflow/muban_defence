local mt = ac.skill['分裂伤害']
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
	skill_type = "被动,分裂",
	--被动
	passive = true,
	--属性加成
['分裂伤害'] = {25,50,75,100,125},
['攻击'] = {1000000,2000000,3000000,4000000,5000000},

	--介绍
    tip = [[

|cffffff00【攻击】+100W*Lv|r        
|cffffff00【分裂伤害】+25%*Lv|r 

]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNCleavingAttack.blp]],
	--特效
	effect = [[Abilities\Spells\Other\Cleave\CleaveDamageTarget.mdl]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
