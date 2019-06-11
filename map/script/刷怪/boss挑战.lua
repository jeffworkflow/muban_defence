
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

    ['技能BOSS1'] = {ac.map.rects['boss-技能1'],270},
    ['技能BOSS2'] = {ac.map.rects['boss-技能2'],270},
    ['技能BOSS3'] = {ac.map.rects['boss-技能3'],270},
    ['技能BOSS4'] = {ac.map.rects['boss-技能4'],270},
    
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

    ['伏地魔'] = {ac.map.rects['boss-伏地魔'],270},
    
    ['星星之火boss'] = {ac.map.rects['boss-星星之火'],270},
    ['陨落心炎boss'] = {ac.map.rects['boss-陨落心炎'],270},
    ['三千焱炎火boss'] = {ac.map.rects['boss-三千焱炎火'],270},
    ['虚无吞炎boss'] = {ac.map.rects['boss-虚无吞炎'],270},

}
--游戏初始化开启
ac.game:event '游戏-开始' (function()
    for key,val in pairs(ac.challenge_boss) do 
            -- print(key,val)
        local mt = ac.creep[key]{    
            region = val[1],
            creeps_datas = key..'*1',
            -- boss重生时间
            cool = 15,
            creep_player = ac.player.com[2],
        }  
        --进攻怪刷新时的初始化
        function mt:on_start()
        end
        --改变怪物面向角度
        function mt:on_change_creep(unit,lni_data)
            unit:set_facing(val[2] or 0)
        end
        --开启
        mt:start()
    end   
end)



