
--挑战完boss，境界，成就。

ac.prod_level = {
    ['小斗气'] = {{['全属性']=2000000,
    ['暴击几率']=2.5,
    ['暴击加深']=25,
    ['技能冷却']=10,
    ['每秒回血']=10,},[[tupo1.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+200w 全属性
-10%   技能冷却
+10%   每秒回血
+2.5%  暴击几率
+25%   暴击加深|r

]]},

['斗者'] = {{['全属性']=3000000,
['免伤']=2.5,
['闪避']=2.5,
['触发概率']=10,},[[tupo2.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+300w 全属性
+2.5%  免伤
+2.5%  闪避
+10%   触发概率|r

]]},

['斗师'] = {{['全属性']=2000},[[tupo3.blp]],[[
+2000全属性
]]},

['斗灵'] = {{['全属性']=2000},[[tupo4.blp]],[[
+2000全属性
]]},

['斗王'] = {{['全属性']=2000},[[tupo5.blp]],[[
+2000全属性
]]},

['斗皇'] = {{['全属性']=2000},[[tupo6.blp]],[[
+2000全属性
]]},

['斗宗'] = {{['全属性']=2000},[[tupo7.blp]],[[
+2000全属性
]]},

['斗尊'] = {{['全属性']=2000},[[tupo8.blp]],[[
+2000全属性
]]},

['斗圣'] = {{['全属性']=2000},[[tupo9.blp]],[[
+2000全属性
]]},

['斗帝'] = {{['全属性']=2000},[[tupo10.blp]],[[
+2000全属性
]]},

}
for key,val in pairs(ac.prod_level) do 
    local mt = ac.skill[key]
    mt{
        --等久
        level = 0,
        --魔法书相关
        is_order = 1 ,
        --目标类型
        target_type = ac.skill.TARGET_TYPE_NONE,
        art = val[2],
        tip = val[3],
        --冷却
        cool = 0,
        content_tip = '',
        extr_tip = '\n|cffFFE799【状态】：|r|cffff0000未激活|r',
        --物品技能
        is_skill = true,
        --商店名词缀
        store_affix = '',
        --最大使用次数
        max_use_count = 1
    }
    function mt:on_add()
        local hero = self.owner
        for key,value in sortpairs(val[1]) do 
            hero:add(key,value)
        end    
        self:set('extr_tip','\n|cffFFE799【状态】：|r|cffff0000已激活|r')
    end
    --使用物品
    function mt:on_cast_start()
       
    end
end


--魔法书
local mt = ac.skill['境界突破']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[tupo10.blp]],
    title = '境界突破',
    tip = [[

查看 |cff00ff00境界突破|r
    ]],
}
mt.skills = {'小斗气','斗者','斗师','斗灵','斗王','斗皇','斗宗','斗尊','斗圣','斗帝'}

ac.game:event '单位-死亡'(function(_,unit,killer)
    local name = unit:get_name()
    if finds(name,'小斗气','斗者','斗师','斗灵','斗王','斗皇','斗宗','斗尊','斗圣','斗帝') then
        local skl = killer:find_skill(name,nil,true)
        local p = killer:get_owner()
        p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00境成功|r 突破后的属性可以在境界系统中查看')
        if skl then 
            skl:set_level(1)
        end    
    end    
end)