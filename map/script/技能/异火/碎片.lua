
local fire = {
    --技能名 = 图标,tip
    ['星星之火'] = {[[other\suiji101.blp]],[[集满100个，点击激活]]},
    ['陨落心炎'] = {[[other\suiji101.blp]],[[集满100个，点击激活]]},
    ['三千焱炎火'] = {[[other\suiji101.blp]],[[集满100个，点击激活]]},
    ['虚无吞炎'] = {[[other\suiji101.blp]],[[集满100个，点击激活]]}, 
}

for key,val in pairs(fire) do 
    --星星之火碎片
    local mt = ac.skill[key..'碎片']
    mt{
    --等久
    level = 1,
    --图标
    art = val[1],
    --说明
    tip = val[2],
    --品质
    color = '青',
    --物品类型
    item_type = '消耗品',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 1,
    --购买价格
    gold = 0,
    --物品数量
    _count = 1,
    --物品详细介绍的title
    content_tip = '使用说明：'
    }

    function mt:on_cast_start()
        local unit = self.owner
        local hero = self.owner
        local player = hero:get_owner()
        local name = self:get_name()
        hero = player.hero

        --需要增加一个，否则消耗品点击则无条件消耗
        self:add_item_count(1) 
        if self._count < 100 then 
            return 
        end    

        local skl = hero:find_skill(key,nil,true)
        if skl then 
            player:sendMsg(key..' 已入体，不可重复')
        else
            ac.game:event_notify('技能-插入魔法书',hero,'异火',key)
            player:sendMsg('入体成功：'..key)
            --自己移除掉
            self:add_item_count(-100) 
        end   
    end
end
