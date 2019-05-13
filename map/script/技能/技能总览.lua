
--[[

    在F9打开的任务栏中 显示所有技能图标 名字 跟 说明

]]

--野怪技能列表
ac.skill_list = {
    '肥胖','强壮','钱多多','经验多多','物品多多',
    '神盾','闪避+','闪避++','眩晕','生命回复',
    '重生','死亡一指','灵丹妙药','刺猬',
    '抗魔','魔抗++','火焰','净化','远程攻击',
    '幽灵','腐烂','流血','善恶有报',
    --'沉默光环','减速光环'
}
--技能列表
ac.skill_list2 = {
    '重击','暴击','粉碎','闪电手','硬化皮肤','闪避','望远镜','弹射','法术强化','召唤强化','贪婪者的心愿','财富',
    '缠绕','风暴锤子','击地','践踏','穿刺','时间静止','妖刀','静止陷阱',
    '荆棘光环','强击光环','辉煌光环',
    '专注光环',
    '耐力光环','战鼓光环','吸血光环','寻宝光环','财源滚滚','冰冷核心','魔王降临',
    '暴风雪','阳光枪','火焰雨','巨浪','飞焰','炎爆术','光子灵枪','闪电链','死亡之指','死亡脉冲','痛苦尖叫',
    '光明契约','摔破罐子','刀刃旋风','黑暗契约','死亡飞镖','闪烁','狂猛','献祭','群体治疗','圣光','治疗守卫','冰甲','心灵之火',
    '闪电手','愤怒','爱屋及乌','妙手空空',
    '自然之力','水元素','影子','狼','地狱火','凤凰','F4战斗机','战鹰','硬币机器','张全蛋',
    '万箭齐发','风暴之力','绿野之矛','御甲','交叉闪电','回旋刃',
    '神圣护甲','疾步风'
    --'属性转换'
}
--boss技能列表
ac.skill_list3 = {
    '产卵','地狱火雨','大地震','撕裂大地','暗影冲刺','暗能源','毁灭','洪流',
    -- '激光',
    '火刑','血之祭祀','超强力量',
    '超新星','雷击','骚灵','魔力之枷','龙破斩',
}

--统一定 技能价格 技能售价
for _,name in ipairs(ac.skill_list2) do
    ac.skill[name].gold = 2000
end    


local function initialize()
    local unit = ac.player(16):create_dummy('e001',ac.point(0,0),0)

    local list = ac.skill_list2

    table.sort(list,function (a,b) return a < b end)
    
    for index,name in ipairs(list) do 
        local skill = unit:add_skill(name,'隐藏')
        local title = name
        local tip = skill:get_simple_tip(nil,1)
        local art = skill:get_art()

        local quest = CreateQuestBJ(bj_QUESTTYPE_REQ_DISCOVERED,title,tip,art)
        skill:remove()
    end 
    unit:remove()
end 



-- initialize()