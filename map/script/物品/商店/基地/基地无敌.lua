
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
]],

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
    unit:add_buff '无敌'{
        time = self.stu_time
    }


    
end
