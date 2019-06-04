
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['挑战最终boss']
mt{
--等久
level = 1,
--图标
art = [[tzzzbs.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cffff0000点击挑战最终BOSS，杀死后游戏直接胜利|r

|cffcccccc请确保已经有足够的实力|r]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
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
        ac.game:event_dispatch('游戏-最终boss')
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 有玩家直接|cffff0000挑战最终boss|r，请大家共同前往击杀',3)
    end     
end
