local mt = ac.creep['刷怪-无尽']{    
    region = '',
    creeps_datas = '',
    is_random = true,
    creep_player = ac.player.com[2],
    tip ="无尽模式开始"

}
function mt:on_start()
    --继承刷怪的信息 函数 
    self.region = ac.creep['刷怪'].region
    self.all_units = ac.creep['刷怪'].all_units

    self.has_unit = ac.creep['刷怪'].has_unit
    self.get_temp_type = ac.creep['刷怪'].get_temp_type
    self.random_creeps_datas = ac.creep['刷怪'].random_creeps_datas
    self.get_creep_skill = ac.creep['刷怪'].get_creep_skill
    self.add_creep_skill = ac.creep['刷怪'].add_creep_skill
    self.send_skill_message = ac.creep['刷怪'].send_skill_message
    self.attack_hero = ac.creep['刷怪'].attack_hero

    --每3秒命令进攻怪攻击附近的英雄
    self:attack_hero() 

end
function mt:on_next()    
    --进攻提示
    if ac.ui then ac.ui.kzt.up_jingong_title('无尽 - 第 '..self.index..' 层 ') end
    --每一波开始时，进行初始化数据
    self.all_food = ac.all_food    --每多一个玩家， 多20怪物总人口,每回合开始都去检测人口数量
    self.used_food = 0 
    self.current_creep ={}

    
    --获得随机 1-2 个种类的进攻怪
    local temp_type = self:get_temp_type()
    self:random_creeps_datas(temp_type)
    
    --每多一个玩家， 多20怪物总人口d，都是喽喽
    local small_unit_name = self.all_units['喽喽'][math.random(1,#self.all_units['喽喽'])]
    local more_food = 20 * (get_player_count() - 1)
    if more_food > 0 then 
        self.creeps_datas = self.creeps_datas .. ' '..small_unit_name..'*'..tostring(more_food) 
    end  

    print(self.creeps_datas)
    
    --转化字符串 为真正的区域
    self:set_region()
    --转化字符串 为真正的野怪数据
    self:set_creeps_datas()

    --获得随机野怪技能
    self.rand_skill_list = self:get_creep_skill()

    --发送本层怪物信息 3次10秒
    self:send_skill_message(3,10)
    print('当前波数 '..self.index)
    
	--嘉年华 15秒后 ,直接进入下一波
    if ac.g_game_mode == 2 then 
        --@刷兵规则
        local creep = self

        if self.timer_ex1 then 
            self.timer_ex1:remove()
        end 

        self.timer_ex1 = ac.timer_ex 
        {
            time = 15,
            title = "距离下一波怪开始",
            func = function ()
                creep.timer_ex1 = nil
                creep:next() --时间到马上下一波
            end,
        }
        
        --@游戏失败 场上怪物超过50只
        if not self.mode_timer then 
			self.mode_timer = ac.loop(2*1000,function(t)
				local max_cnt = 50 * get_player_count()
                if self.current_count >= max_cnt * 0.5 then 
                    ac.player.self:sendMsg("【系统提示】当前怪物存活过多，还剩 |cffE51C23 "..(max_cnt - self.current_count).." 只|r 游戏结束，请及时清怪")
                end    
                if self.current_count >= max_cnt then 
                    t:remove()
                    self:on_finish()
                    ac.game:event_notify('游戏-结束')
                end    
            end)
        end    
    end 

end
--改变怪物
function mt:on_change_creep(unit,lni_data)
    local base_attack = 600000 --每波 + 100000
    local base_defence = 2000
    local base_life = 10000000
    local base_mana = 2500000
    local base_move_speed = 325
    local base_attack_gap = 1.5
    local base_life_recover = 25000
    local base_mana_recover = 25000
    local base_attack_distance = 125
    local base_attack_speed = 35


    local upgrade_attr = {
        ['攻击'] = 375000,
        ['护甲'] = 225,
        ['魔抗'] = 225,
        ['生命上限'] = 3000000,
        ['魔法上限'] = 1000000,
        ['生命恢复'] = 10000,
        ['魔法恢复'] = 10000,
        ['攻击速度'] = 5,
    }
    --设置属性
    unit:set('移动速度',base_move_speed)
    unit:set('攻击间隔',base_attack_gap)
    unit:set('攻击距离',base_attack_distance)
    unit:set('攻击速度',(base_attack_speed + upgrade_attr['攻击速度'] * self.index))
    --设置 属性倍数 及 每波成长
    if lni_data.attr_mul  then
        unit:set('攻击',(base_attack + upgrade_attr['攻击'] * self.index) * lni_data.attr_mul * (ac.g_game_degree_attr ))
        unit:set('护甲',(base_defence + upgrade_attr['护甲'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr ))
        unit:set('生命上限',(base_life + upgrade_attr['生命上限'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr ))
        unit:set('魔法上限',(base_mana + upgrade_attr['魔法上限'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr  ))
        unit:set('生命恢复',(base_life_recover + upgrade_attr['生命恢复'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr ))
        unit:set('魔法恢复',(base_mana_recover + upgrade_attr['魔法恢复'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr  ))
        unit:set('魔抗',(base_defence + upgrade_attr['魔抗'] * self.index) * lni_data.attr_mul* (ac.g_game_degree_attr ))
    end  

    --掉落概率
    unit.fall_rate = 0
    --掉落金币和经验
    unit.gold = 0
    unit.exp = 467

    --设置搜敌路径
    -- unit:set_search_range(99999)
    --随机添加怪物技能
    self:add_creep_skill(self.rand_skill_list,unit)
   
end

--刷怪结束
function mt:on_finish()  
    if self.timer_ex1 then 
        self.timer_ex1:remove()
    end
    if self.key_unit_trg then 
        self.key_unit_trg:remove()
    end    
    if self.mode_timer then 
        self.mode_timer:remove()
    end  
    if self.attack_hero_timer then 
        self.attack_hero_timer:remove()
    end   
end    

