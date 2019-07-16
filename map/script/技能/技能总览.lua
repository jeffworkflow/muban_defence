
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
    '万箭齐发','交叉闪电','闪电链','阳光枪','回旋刃','巨浪','御甲','炎爆术',
    '暴风雪','火焰雨','风暴之力','飞焰','雷霆之剑','空间之力','天罗地网',
    '血焰神脂','神威','刀刃旋风','痛苦尖叫',
    '死亡脉冲','践踏','穿刺',
   '水舞','缠绕','疾步风',
    '神圣护甲','不灭佛隐','血雾神隐','绝对领域','招架之力',
    '水疗术','生生不息','硬化皮肤','闪避','财富','贪婪者的心愿',
    '龙凤佛杀','凰燃天成','狂龙爆','红莲爆','暴击','渡业妖爆','技暴',
    '蚀魂魔舞','赤焰魔舞','望远镜','剑空破','吸血鬼','分裂伤害','嗜血术','碧涛妖变',
    '邪灵变','暗之领域','迷之领域',

    -- '强化后的神威','强化后的刀刃旋风','强化后的痛苦尖叫','强化后的死亡脉冲','强化后的践踏', '强化后的穿刺','强化后的水舞','强化后的疾步风','强化后的神圣护甲',
    -- '强化后的不灭佛隐','强化后的水疗术','强化后的招架之力','强化后的狂龙爆','强化后的红莲爆','强化后的渡业妖爆','强化后的蚀魂魔舞','强化后的暗之领域','强化后的迷之领域','强化后的缠绕',
}
--boss技能列表
ac.skill_list3 = {
    '无敌','撕裂大地',
    --'超新星',
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