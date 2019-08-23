local mt = ac.skill['好多蛋蛋的黄金鸡']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[hjcpj.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+5000万 全属性
+2万  护甲
+5%  会心几率
+50%  会心伤害|r
    ]],
    ['全属性'] = 50000000,
    ['护甲'] = 20000,
    ['会心几率'] = 5,
    ['会心伤害'] = 50,
}


local mt = ac.skill['霸王色的霸气']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[bawangshe.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00每5秒触发一次|cff00ffff“霸王色的霸气” |cff00ff00对周围敌人造成全属性*30的伤害，并晕眩0.8秒|r
    ]],
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*30
    end,
    stun_time = 0.8,
    damage_area = 800,
    damage_type = '法术',
    effect = [[Hero_DoomBringer_N3S_V_mega.mdx]]
}
function mt:on_add()
    local hero = self.owner
    self.buf = hero:add_buff '霸王色的霸气'{
        damage = self.damage,
        damage_area = self.damage_area,
        damage_type = self.damage_type,
        effect = self.effect,
        skill = self,
        stun_time = self.stun_time,
    }

end  
function mt:on_remove()
    if self.buf  then self.buf:remove() self.buf = nil end
end


local mt = ac.buff['霸王色的霸气']
mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.ref = 'origin'
mt.model = [[]]
mt.value = 0
mt.pulse = 5

function mt:on_add()
end
function mt:on_pulse()
    local skill = self.skill
    -- print(self.effect)
    -- self.target:add_effect('origin',self.effect):remove()
    ac.effect(self.target:get_point(), self.effect, 270, 2,'origin'):remove()

    for i,u in ac.selector()
    : in_range(self.target,self.damage_area)
    : is_enemy(self.target)
    : of_not_building()
    : ipairs()
    do
        u:add_buff '晕眩'{
            time =self.stun_time
        }
        u:damage
        {
            source = self.target,
            damage = self.damage,
            skill = skill,
            damage_type = skill.damage_type
        }
    end

end    
function mt:on_remove()
end



local mt = ac.skill['大胃王']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   area = 800,
	--技能类型
	skill_type = "被动,力量",
	--被动
	passive = true,
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*50
end,
	--介绍
	tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00攻击10%几率造成范围全属性*50的技能伤害

]],
	--特效
    effect = [[Hero_Axe_N3S_E_Source.mdx]],
    art = [[daweiwang.blp]],
    damage_type = '法术',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            ac.effect(hero:get_point(), self.effect, 270, 1,'origin'):remove()
         
            for i, u in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : of_not_building()
                : ipairs()
            do
                -- u:add_buff '晕眩'
                -- {
                --     source = hero,
                --     time = self.time,
                -- }
                u:damage
                {
                    source = hero,
                    damage = self.damage,
                    skill = self,
                    damage_type = self.damage_type
                }
            end	
            
            --激活cd
            skill:active_cd()
    
        end
    end)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

local mt = ac.skill['家里有矿']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[jlyk.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00所有队友的全属性+5%
    ]],
    value = 5
}
function mt:on_add()
    local hero = self.owner
    if not hero:is_hero() then 
        return 
    end    
    if not ac.team_attr then ac.team_attr ={} end
    ac.team_attr['力量%'] = (ac.team_attr['力量%'] or 0) + self.value
    ac.team_attr['敏捷%'] = (ac.team_attr['敏捷%'] or 0) + self.value
    ac.team_attr['智力%'] = (ac.team_attr['智力%'] or 0) + self.value
end  
function mt:on_remove()
    local hero = self.owner
    if not hero:is_hero() then 
        return 
    end    
    if not ac.team_attr then ac.team_attr ={} end
    ac.team_attr['力量%'] = (ac.team_attr['力量%'] or 0) - self.value
    ac.team_attr['敏捷%'] = (ac.team_attr['敏捷%'] or 0) - self.value
    ac.team_attr['智力%'] = (ac.team_attr['智力%'] or 0) - self.value
end 



local mt = ac.skill['神格护体']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[sgrt.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+3000万 全属性
+3万  护甲
+15%  技能伤害加深
    ]],
    ['全属性'] = 30000000,
    ['护甲'] = 30000,
    ['技能伤害加深'] = 15
}


local mt = ac.skill['无敌破坏神']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[wdphs.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+5000万 全属性
+200%  物理伤害加深
+100%  技能伤害加深
    ]],
    ['全属性'] = 50000000,
    ['物理伤害加深'] = 200,
    ['技能伤害加深'] = 100
}


local mt = ac.skill['一代幸运神']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[qbfb.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+5000万 全属性
+100%  杀敌数加成
+100%  物品获取率
+100%  木头加成
+100%  火灵加成
    ]],
    ['全属性'] = 50000000,
    ['杀敌数加成'] = 100,
    ['木头加成'] = 100,
    ['火灵加成'] = 100,
    ['物品获取率'] = 100
}


local mt = ac.skill['百鸟朝凤']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[bncf.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+5000万 全属性
+5%     闪避
+5%     免伤几率
+35%    全伤加深
    ]],
    ['全属性'] = 50000000,
    ['免伤几率'] = 5,
    ['闪避'] = 5,
    ['全伤加深'] = 35,
}


local mt = ac.skill['超级彩蛋']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cjcd.blp]],
    title = '超级彩蛋',
    tip = [[

点击查看 |cff00ff00超级彩蛋|r
    ]],
}
mt.skills = {}

ac.game:event '技能-插入魔法书后' (function (_,hero,book_skill,skl)
    local skl= hero:find_skill('好多蛋蛋的黄金鸡',nil,true)
    if skl then 
        return 
    end 
    local cnt = 0
    local player = hero:get_owner()
    local skl= hero:find_skill('彩蛋',nil,true)
    if skl then 
        for index,skill in ipairs(skl.skill_book) do 
            -- print(index,skill.name)
            if skill.level >=1 then 
                cnt = cnt+1
            end    
        end
    end 
    if cnt >= 11 then 
		ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','好多蛋蛋的黄金鸡')
        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 集齐十八个蛋|r 获得成就|cffff0000 "好多蛋蛋的黄金鸡" |r，奖励 |cffff00005000万全属性，2万护甲，会心几率+5%，会心伤害+50%|r',6)
    end    

end)

ac.game:event '游戏-开始' (function()
    local unit = ac.game.findunit_byname('游戏说明')
    unit:event '受到伤害效果'(function(_,damage)
        if not damage.source:is_hero() then 
            return 
        end    
        local hero = damage.source
        local player = hero:get_owner()
        local item = hero:has_item('紫金碧玺佩')
        if item and item.level == item.max_level then 
            local skl = hero:find_skill('神格护体',nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','神格护体')
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 打桩爽翻了天，|r 获得成就|cffff0000 "神格护体" |r，奖励 |cffff00003000万全属性，3万护甲，技能伤害加深+15%|r',6)
            end    

        end
    end)
end)

--白鸟朝凤 触发
local reg = ac.region.create(ac.rect.j_rect('bncf9'))
reg:event '区域-进入'(function(trg,unit,reg)
    local time = 65 * 60
    if ac.g_game_time < time  then 
        return 
    end    
    if not unit:is_type('宠物') then 
        return 
    end  
    local p = unit:get_owner()
    local player = unit:get_owner()
    local hero =p.hero
    local skl = hero:find_skill('百鸟朝凤',nil,true)
    if skl then 
        return 
    end    
    --倒计时 得到彩蛋
    if p.down_time_tg then 
        p.down_time_tg:remove()
    end    
    p.down_time_tg = ac.timer(1000,15,function(t)end)
    function p.down_time_tg:on_timeout()
        --获得彩蛋
        ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','百鸟朝凤')
        ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 的宠物一呼百应，|r 获得成就|cffff0000 "百鸟朝凤" |r，奖励 |cffff00005000万全属性，5%闪避，5%免伤几率，35%全伤加深|r',6)
    end    

end)

