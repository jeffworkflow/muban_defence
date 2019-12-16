
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['挑战最终boss']
mt{
--特殊id
type_id = 'EX03',    
--等久
level = 1,
--图标
art = [[tzzzbs.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cffff0000点击挑战最终BOSS，杀死后游戏直接胜利|r

|cffcccccc请确保已经有足够的实力|r
|cffcccccc请确保木头足够再购买，否则技能会进入CD，切勿瞎点|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
shop_count = 0, --初始个数
--售价 500000
wood = 50000,
--冷却
cool = 0,
content_tip = '',
--物品技能
is_skill = true,
--商店名词缀
store_affix = ''
}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    
    if not ac.final_boss then 
        for i=1,3 do 
            ac.creep['刷怪'..i]:finish()
        end    
        ac.game:event_dispatch('游戏-最终boss')
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
    else
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 最终boss已存在或已经死亡。',3)
    end     
end
