
-- require '刷怪.游戏结束'
ac.challenge_boss = {
    --boss名,区域string
    ['武器boss1'] = {ac.map.rects['boss-武器1']},
    ['武器boss2'] = {ac.map.rects['boss-武器2']},
    ['武器boss3'] = {ac.map.rects['boss-武器3']},
    ['武器boss4'] = {ac.map.rects['boss-武器4']},
    ['武器boss5'] = {ac.map.rects['boss-武器5']},
    ['武器boss6'] = {ac.map.rects['boss-武器6']},
    ['武器boss7'] = {ac.map.rects['boss-武器7']},
    ['武器boss8'] = {ac.map.rects['boss-武器8']},
    ['武器boss9'] = {ac.map.rects['boss-武器9']},
    ['武器boss10'] = {ac.map.rects['boss-武器10']},
    ['武器boss11'] = {ac.map.rects['boss-武器11'],180},

    ['防具boss1'] = {ac.map.rects['boss-甲1']},
    ['防具boss2'] = {ac.map.rects['boss-甲2']},
    ['防具boss3'] = {ac.map.rects['boss-甲3']},
    ['防具boss4'] = {ac.map.rects['boss-甲4']},
    ['防具boss5'] = {ac.map.rects['boss-甲5']},
    ['防具boss6'] = {ac.map.rects['boss-甲6']},
    ['防具boss7'] = {ac.map.rects['boss-甲7']},
    ['防具boss8'] = {ac.map.rects['boss-甲8']},
    ['防具boss9'] = {ac.map.rects['boss-甲9']},
    ['防具boss10'] = {ac.map.rects['boss-甲10']},
    ['防具boss11'] = {ac.map.rects['boss-甲11'],180},

    ['技能BOSS1'] = {ac.map.rects['boss-技能1'],270,nil,nil,8},
    ['技能BOSS2'] = {ac.map.rects['boss-技能2'],270,nil,nil,8},
    ['技能BOSS3'] = {ac.map.rects['boss-技能3'],270,nil,nil,8},
    ['技能BOSS4'] = {ac.map.rects['boss-技能4'],270,nil,nil,8},
    
    ['洗练石boss1'] = {ac.map.rects['boss-洗练石1'],270},
    ['洗练石boss2'] = {ac.map.rects['boss-洗练石2'],270},
    ['洗练石boss3'] = {ac.map.rects['boss-洗练石3'],270},
    ['洗练石boss4'] = {ac.map.rects['boss-洗练石4'],270},

    ['小斗气'] = {ac.map.rects['boss-境界1'],270},
    ['斗者'] = {ac.map.rects['boss-境界2'],270},
    ['斗师'] = {ac.map.rects['boss-境界3'],270},
    ['斗灵'] = {ac.map.rects['boss-境界4'],270},
    ['斗王'] = {ac.map.rects['boss-境界5'],270},
    ['斗皇'] = {ac.map.rects['boss-境界6'],270},
    ['斗宗'] = {ac.map.rects['boss-境界7'],270},
    ['斗尊'] = {ac.map.rects['boss-境界8'],270},
    ['斗圣'] = {ac.map.rects['boss-境界9'],270},
    ['斗帝'] = {ac.map.rects['boss-境界10'],270},
    ['斗神'] = {ac.map.rects['boss-境界11'],270},

    ['伏地魔'] = {ac.map.rects['boss-伏地魔'],270},
    
    ['星星之火boss'] = {ac.map.rects['boss-星星之火'],270},
    ['陨落心炎boss'] = {ac.map.rects['boss-陨落心炎'],270},
    ['三千焱炎火boss'] = {ac.map.rects['boss-三千焱炎火'],270},
    ['虚无吞炎boss'] = {ac.map.rects['boss-虚无吞炎'],270},
    
    -- ['强盗领主'] = {ac.map.rects['boss-藏宝图'],270},
    --boss名 = 区域，面向角度，特效区域，特效
    ['红发'] = {ac.map.rects['boss-红发'],180,'hand','wuqi13.mdx'},
    ['黑胡子'] = {ac.map.rects['boss-黑胡子'],180,'hand','wuqi10.mdx'},
    ['百兽'] = {ac.map.rects['boss-百兽'],180,'hand',''},
    ['白胡子'] = {ac.map.rects['boss-白胡子'],180,'hand','wuqi11.mdx'},

    ['食人魔'] = {ac.map.rects['boss-食人魔'],0},
    
}
--游戏初始化开启
ac.game:event '游戏-开始' (function()
    local i = 0
    for key,val in sortpairs(ac.challenge_boss) do 
        local mt = ac.creep[key]{    
            region = val[1],
            creeps_datas = key..'*1',
            -- boss重生时间
            cool = val[5] or 15,
            creep_player = ac.player.com[2],
        }  
        --进攻怪刷新时的初始化
        function mt:on_start()
        end
        --改变怪物面向角度
        function mt:on_change_creep(unit,lni_data)
            unit:set_facing(val[2] or 0)
            if val[3] and val[4] then 
                unit:add_effect(val[3],val[4])
            end    
            --特殊boss处理
            if unit:get_name() == '食人魔' then
                unit:event '单位-死亡'(function(_,unit,killer)
                    local rate = 50 + (10*ac.g_game_degree_attr)
                    local max_cnt = 12 --每人一局最大掉落次数
                    local p= killer:get_owner()
                    if unit:is_ally(killer) then
                        return
                    end
                    p.kill_srm = (p.kill_srm or 0) 
                    if p.kill_srm < max_cnt and math.random(100) <= rate then 
                        ac.item.create_item('勇士徽章',unit:get_point())
                        p.kill_srm = (p.kill_srm or 0) + 1  
                    end    
                end)
            end    
        end
        --优化挑战怪
        i = i + 1
        ac.wait(i*1100,function()
            --开启
            mt:start()
        end)
    end   
end)



