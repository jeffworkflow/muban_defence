
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['停怪']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNMagicLariet.blp]],

--说明
tip = [[


使得怪物|cff00ff00暂停进攻90秒|r

|cffcccccc请确保木头足够再购买，否则技能会进入CD，切勿瞎点|r]],
shop_count = 0, --初始个数
--特殊id 带cd
type_id = 'EX00',

--物品类型
item_type = '神符',
--售价 500000
wood = 2000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 600,
--停怪时长
stu_time = 90,

content_tip = '|cffFFE799【使用说明】：|r',

--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    local p = self.owner:get_owner()
    for i=1,3 do 
        local creep = ac.creep['刷怪'..i]
        creep:PauseTimer(self.stu_time)
    end
    --启用另一个计时器 显示停怪恢复倒计时	
    ac.main_stop_timer = ac.timer_ex
    {
        time = self.stu_time,
        title = '停怪还剩：',
        func = function()
            ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
            ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
            ac.player.self:sendMsg('|cffff0000停怪结束！！！ 请注意进攻怪来袭。|r')
            ac.main_stop_timer = nil
        end,
    }
    ac.player.self:sendMsg('玩家 '..p:get_name()..' 购买了|cffff0000停怪！|r停怪90秒。')
end

-- ac.game:event '单位-货币不足' (function(_,seller,u,it)
--     -- print(_,seller,u,it)
--     if it.name == '停怪' then
--         -- print('进入回调')
--         seller:remove_sell_item(it.name)
--         ac.wait(3000,function()
--            seller:add_sell_item(it.name,4)
--         end)
--     end

-- end)
