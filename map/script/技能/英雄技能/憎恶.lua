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
  return (self.owner:get('力量')*15+10000)* self.level
end,
	--属性加成
 ['每秒加力量'] = {50,100,150,200,250},
 ['攻击加力量'] = {50,100,150,200,250},
 ['杀怪加力量'] = {50,100,150,200,250},
	--介绍
    tip = [[

|cffffff00【每秒加力量】+50*Lv
【攻击加力量】+50*Lv
【杀怪加力量】+50*Lv|r

|cff00bdec【主动施放】向指定方向投出钩子，将敌人钩回身边
【伤害公式】(力量*15+1w)*Lv*5|r

]],
    --技能目标
    target_type = ac.skill.TARGET_TYPE_POINT,
    --图标
    art = 'zengwu.blp',
    --施法距离
    range =  1200,
    --投射物碰撞距离
    hit_area = 150,
    speed = 1200,
    --投射物模型
    model = [[SentinelMissile.mdx]],
    effect = [[Abilities\Weapons\WardenMissile\WardenMissile.mdl]],
    --cd
    cool = 15,
    damage_type = '法术',
    --减速事件
    reduce_time = 3,
    move_speed_rate = 20
}

function mt:on_add()
    local skill = self
    local hero = self.owner
end
 


function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local skill = self

    local function recycle_hook(poi,tbl,dest)
        --把英雄放在最后，当做参照点
        tbl[#tbl+ 1] = hero
        local mvr 
        if dest then 
            mvr = ac.mover.target
            {
                start = poi,
                target = hero,
                model = skill.model,
                mover = dest,
                target_unit = dest,
                speed = 1500,
                skill = skill,
            }
            dest:add_buff '晕眩'{
                time = 100,
            }
        else
            mvr = ac.mover.target
            {
                start = poi,
                target = hero,
                model = skill.model,
                speed = 1500,
                skill = skill,
            }

        end    
        if not mvr then
            return
        end
        function mvr:on_move()
            local poi_a = hero:get_point()
            local poi_b = tbl[#tbl]:get_point()
            --补上尾部空缺
            if poi_b * poi_a >= 40 then
                local angle = poi_a / poi_b
                local poi = hero:get_point() - {angle,40}
                local eff = ac.effect(poi,skill.effect,angle,1.2,'chest')
                table.insert(tbl,#tbl,eff.unit) --插入倒数第二位，让英雄始终保持在最后一位
                -- tbl[#tbl+1] = u
            end

            local poi_c = hero:get_point()
            for n = #tbl,2,-1 do
                local i = n - 1
                local j = n
                local poi_a = tbl[i]:get_point()
                local poi_b = tbl[j]:get_point()
                local angle = poi_a / poi_b
                local poi = poi_a - {angle,40}
                tbl[i]:set_position(poi)
                tbl[i]:set_facing(angle,true)
            end
            if #tbl ~=1 then 
                tbl[1]:remove()
                table.remove(tbl,1)
            end    
        end
    
        function mvr:on_finish()    
            table.remove(tbl,#tbl) --移除英雄
            for i=1,#tbl do 
                if tbl[i] then 
                    tbl[i]:remove()
                    tbl[i] = nil 
                end
            end  
            if self.target_unit then 
                self.target_unit:remove_buff '晕眩'
                --开始受伤害事件
                self.target_unit:damage
                {
                    skill = skill,
                    source = hero,
                    damage = skill.damage,
                    damage_type = '法术'
                }
                self.target_unit:add_buff '减速'{
                    time =skill.reduce_time,
                    move_speed_rate = skill.move_speed_rate,
                }
            end    
        end    
    end   

    local function start_hook(target)
        --初始角度
        local angle = hero:get_point() / target
        local tbl = {}
        local mvr = ac.mover.line
        {
            source = hero,
            model = self.model,
            angle = angle,
            speed = skill.speed,
            distance = skill.range,
            skill = skill,
            hit_area = skill.hit_area,
            size = 1
        }
        tbl[1] = mvr.mover
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
                local eff = ac.effect(poi,skill.effect,angle,1.2,'chest')
                tbl[#tbl+1] = eff.unit
            end
        end

        function mvr:on_hit(dest)
            -- print(dest:get_name())
            if dest:get_name() ~='毁灭者' then 
                self.flag_hit = true
                recycle_hook(self.mover:get_point(),tbl,dest)
                return true
            end    
        end
        function mvr:on_remove()
            if not self.flag_hit then 
                recycle_hook(self.mover:get_point(),tbl)
            end 
        end
    end    

    start_hook(target)
end