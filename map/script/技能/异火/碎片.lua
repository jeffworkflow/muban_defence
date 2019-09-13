
local fire = {
    --技能名 = 图标,tip
    ['星星之火'] = {[[huo1.blp]],[[|n|n收集|cffdf19d0100个星星之火碎片|r，将自动合成|cff00ff00初级异火：星星之火|r|n]]},
    ['陨落心炎'] = {[[huo2.blp]],[[|n|n收集|cffdf19d0100个陨落心炎碎片|r，将自动合成|cff00ffff中级异火：陨落心炎|r|n]]},
    ['三千焱炎火'] = {[[huo3.blp]],[[|n|n收集|cffdf19d0100个三千焱炎火碎片|r，将自动合成|cffffff00高级异火：三千焱炎火|r|n]]},
    ['虚无吞炎'] = {[[huo4.blp]],[[|n|n收集|cffdf19d0100个虚无吞炎碎片|r，将自动合成|cffff0000顶级异火：虚无吞炎|r|n]]}, 
    ['陀舍古帝'] = {[[tsgd.blp]],[[|n|n收集|cffdf19d0100个陀舍古帝碎片|r，将自动合成|cffff0000神级异火：陀舍古帝|r|n]]}, 
    ['无尽火域'] = {[[wjhy.blp]],[[|n|n收集|cffdf19d0100个无尽火域碎片|r，将自动合成|cffff0000神级异火：无尽火域|r|n]]}, 
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
    --不可使用
    no_use = true,
    --品质
    --color = '青',
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
    --多少秒后地上物品消失
    time_removed = 180,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r'
    }

    -- function mt:on_cast_start()
    --     local unit = self.owner
    --     local hero = self.owner
    --     local player = hero:get_owner()
    --     local name = self:get_name()
    --     hero = player.hero

    --     --需要增加一个，否则消耗品点击则无条件消耗
    --     self:add_item_count(1) 
    --     if self._count < 100 then 
    --         return 
    --     end    

    --     local skl = hero:find_skill(key,nil,true)
    --     if skl then 
    --         player:sendMsg('|cffffe799【系统消息】|r|cffffff00体内已有'..key..' 吞噬失败|r',2)
    --     else
    --         ac.game:event_notify('技能-插入魔法书',hero,'异火',key)
    --         player:sendMsg('|cffffe799【系统消息】|r|cff00ff00吞噬'..key..'成功|r 吞噬后的属性可以在异火系统中查看',2)
    --         --自己移除掉
    --         self:add_item_count(-100) 
    --     end   
    -- end
end



