local mt = ac.skill['憎恶']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
	--技能类型
	skill_type = "主动,控制",
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*15+10000)* self.level
end,
	--属性加成
 ['每秒加敏捷'] = {50,100,150,200,250},
 ['攻击加敏捷'] = {50,100,150,200,250},
 ['杀怪加敏捷'] = {50,100,150,200,250},
	--介绍
    tip = [[

|cffffff00【每秒加敏捷】+50*Lv
【攻击加敏捷】+50*Lv
【杀怪加敏捷】+50*Lv|r

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(敏捷*15+1w)*Lv|r

]],
    --技能目标
    target_type = ac.skill.TARGET_TYPE_POINT,
    --图标
    art = 'wanjianqifa.blp',
    --施法距离
    range =  1000,
    --投射物碰撞距离
    hit_area = 150,
    speed = 1000,
    --投射物模型
    model = [[SentinelMissile.mdx]],
    effect = [[Abilities\Weapons\WardenMissile\WardenMissile.mdl]],
    --cd
    cool = 15,
    damage_type = '法术'
}

function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local skill = self

    --初始角度
    local angle = hero:get_point() / target
    --创建一个钩子头
    local head = ac.player[16]:create_dummy('e001',hero,angle)
    head:add_effect('chest',self.model_heda)

    local tbl = {}
    tbl[1] = head
	local mvr = ac.mover.line
	{
		source = hero,
        mover = head,
		angle = angle,
        speed = skill.speed,
        distance = skill.range,
        skill = skill,
        hit_area = skill.hit_area,
        size = 1
	}

    function mvr:on_move()
        --移动所有链条单位
        for i=2,#tbl do
            --让所有链条都与上一个节点保持距离
            local poi_a = tbl[i]:get_point()
            local poi_b = tbl[i - 1]:get_point()
            local angle = poi_a / poi_b
            local poi = poi_a - {angle,40}
            tbl[i]:set_position(poi)
            tbl[i]:set_facing(angle,true)
        end

        local poi_a = hero:get_point()
        local poi_b = tbl[#tbl]:get_point()
        --补上尾部空缺
        if poi_b * poi_a >= 40 then
            local angle = poi_a / poi_b
            local poi = hero:get_point() - {angle,40}
            local u = ac.player[16]:create_dummy('e001',poi,angle)
            u:add_effect('chest',skill.effect)
            u:set_size(1.2)
            tbl[#tbl+1] = u
        end
    end

    function mvr:on_hit()

        local mvr = ac.mover.target
        {
            source = hero,
            target = u,
            model = self.model,
            speed = 1500,
            skill = skill,
        }
        if not mvr then
            return
        end
        function mvr:on_move()

        end

        function mvr:on_finish()

        end    
        -- for i,unit in ipairs(tbl) do 

        --     tbl[1]:set_position

        -- end    

    end
    function mvr:on_remove()

    end
end