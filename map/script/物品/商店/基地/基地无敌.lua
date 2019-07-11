
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['基地无敌']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNDivineShieldOff.blp]],

--说明
tip = [[


让基地|cff00ff00无敌30秒|r

|cffcccccc请确保木头足够再购买，否则技能会进入CD，切勿瞎点|r]],

--物品类型
item_type = '神符',
--售价 500000
wood = 500,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 300,
--特殊id 带cd
type_id = 'EX01',

--持续时间
stu_time = 30,

content_tip = '|cffFFE799【使用说明】：|r',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    unit:add_buff '无敌1'{
        time = self.stu_time
    }


    
end
local mt = ac.buff['无敌1']

mt.cover_type = 1
mt.model =[[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]]
mt.ref = 'origin'
mt.eff = nil
mt.debuff = true
mt.control = 5

function mt:on_add()
	self.target:add_restriction '无敌'
	if self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:remove_restriction '无敌'
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
