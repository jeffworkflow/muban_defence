
--挑战完boss，境界，成就。

ac.prod_level = {
    ['小斗气'] = {{['全属性']=2000000,
    ['暴击几率']=2.5,
    ['暴击加深']=25,
    ['免伤']=2.5,
    ['每秒回血']=10,},[[tupo1.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+200w 全属性
+2.5%  免伤
+2.5%  暴击几率
+25%   暴击加深
+10%    每秒回血|r

]]},

['斗者'] = {{
['全属性']=3000000,
['闪避']=2.5,
['技暴几率']=2.5,
['技暴加深']=25,
['攻击减甲']=5,
},[[tupo2.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+300w 全属性
+2.5%  闪避
+2.5%  技暴几率
+25%   技暴加深
+5      攻击减甲|r

]]},

['斗师'] = {{
['全属性']=4000000,
['免伤几率']=2.5,
['全伤加深']=2.5,
['触发概率加成']=5,
},[[tupo3.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+400w 全属性
+2.5%  免伤几率
+2.5%  全伤加深
+5%    触发概率加成|r

]]
},

['斗灵'] = {{['全属性']=5000000,
['免伤']=2.5,
['暴击几率']=2.5,
['暴击加深']=25,
['技能冷却']=5,},[[tupo1.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+500w 全属性
+2.5%  免伤
+2.5%  暴击几率
+25%   暴击加深
-5%    技能冷却|r

]]},

['斗王'] = {{
['全属性']=6000000,
['闪避']=2.5,
['技暴几率']=2.5,
['技暴加深']=25,
['攻击减甲']=5,
},[[tupo2.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+600w 全属性
+2.5%  闪避
+2.5%  技暴几率
+25%   技暴加深
+5      攻击减甲|r

]]},

['斗皇'] = {{
['全属性']=7000000,
['免伤几率']=2.5,
['全伤加深']=2.5,
['触发概率加成']=5,
},[[tupo3.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+700w 全属性
+2.5%  免伤几率
+2.5%  全伤加深
+5%    触发概率加成|r

]]
},

['斗宗'] = {{['全属性']=7500000,
['免伤']=2.5,
['暴击几率']=2.5,
['暴击加深']=25,
['技能冷却']=5,},[[tupo1.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+750w 全属性
+2.5%  免伤
+2.5%  暴击几率
+25%   暴击加深
-5%    技能冷却|r

]]},

['斗尊'] = {{
['全属性']=8000000,
['闪避']=2.5,
['技暴几率']=2.5,
['技暴加深']=25,
['攻击减甲']=5,
},[[tupo2.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+800w 全属性
+2.5%  闪避
+2.5%  技暴几率
+25%   技暴加深
+5      攻击减甲|r

]]},

['斗圣'] = {{
['全属性']=8500000,
['免伤几率']=2.5,
['全伤加深']=2.5,
['攻击间隔']=-0.05,
},[[tupo3.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+850w 全属性
+2.5%  免伤几率
+2.5%  全伤加深
-0.05   攻击间隔|r

]]
},

['斗帝'] = {{
['全属性']=10000000,
['免伤几率']=2.5,
['全伤加深']=2.5,
['攻击间隔']=-0.05,
},[[tupo3.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+1000w 全属性
+5%    全伤加深|r

]]
},
['斗神'] = {{
['全属性']=15000000,
['对BOSS额外伤害']=5,
},[[doushen.blp]],[[
%extr_tip%

|cffFFE799【境界属性】：|r
|cff00ff00+1500w 全属性
+5%    对BOSS额外伤害|r

]]
},
}
for key,val in sortpairs(ac.prod_level) do 
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
        self:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
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

点击查看 |cff00ff00境界突破|r
    ]],
}
mt.skills = {'小斗气','斗者','斗师','斗灵','斗王','斗皇','斗宗','斗尊','斗圣','斗帝','斗神'}
--注册死亡事件升级技能
ac.game:event '单位-死亡'(function(_,unit,killer)
    local name = unit:get_name()
    if finds(name,'小斗气','斗者','斗师','斗灵','斗王','斗皇','斗宗','斗尊','斗圣','斗帝','斗神') then
        local skl = killer:find_skill(name,nil,true)
        local p = killer:get_owner()
        p:sendMsg('|cffFFE799【系统消息】|r|cff00ff00境界突破成功|r 突破后的属性可以在境界系统中查看',3)
        if skl then 
            skl:set_level(1)
        end    
    end    
end)