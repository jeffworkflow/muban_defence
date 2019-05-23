
-- require '刷怪.游戏结束'
ac.challenge_boss = {
    --boss名,区域string
    ['武器boss1'] = ac.map.rects['boss-武器1'],
    ['武器boss2'] = ac.map.rects['boss-武器2'],
    ['武器boss3'] = ac.map.rects['boss-武器3'],
    ['武器boss4'] = ac.map.rects['boss-武器4'],
    ['武器boss5'] = ac.map.rects['boss-武器5'],
    ['武器boss6'] = ac.map.rects['boss-武器6'],
    ['武器boss7'] = ac.map.rects['boss-武器7'],
    ['武器boss8'] = ac.map.rects['boss-武器8'],
    ['武器boss9'] = ac.map.rects['boss-武器9'],
    ['武器boss10'] = ac.map.rects['boss-武器10'],

    ['防具boss1'] = ac.map.rects['boss-甲1'],
    ['防具boss2'] = ac.map.rects['boss-甲2'],
    ['防具boss3'] = ac.map.rects['boss-甲3'],
    ['防具boss4'] = ac.map.rects['boss-甲4'],
    ['防具boss5'] = ac.map.rects['boss-甲5'],
    ['防具boss6'] = ac.map.rects['boss-甲6'],
    ['防具boss7'] = ac.map.rects['boss-甲7'],
    ['防具boss8'] = ac.map.rects['boss-甲8'],
    ['防具boss9'] = ac.map.rects['boss-甲9'],
    ['防具boss10'] = ac.map.rects['boss-甲10'],

    ['技能BOSS1'] = ac.map.rects['boss-技能1'],
    ['技能BOSS2'] = ac.map.rects['boss-技能2'],
    ['技能BOSS3'] = ac.map.rects['boss-技能3'],
    ['技能BOSS4'] = ac.map.rects['boss-技能4'],
    
    ['洗练石boss1'] = ac.map.rects['boss-洗练石1'],
    ['洗练石boss2'] = ac.map.rects['boss-洗练石2'],
    ['洗练石boss3'] = ac.map.rects['boss-洗练石3'],
    ['洗练石boss4'] = ac.map.rects['boss-洗练石4'],

    ['小斗气'] = ac.map.rects['boss-境界1'],
    ['斗者'] = ac.map.rects['boss-境界2'],
    ['斗师'] = ac.map.rects['boss-境界3'],
    ['斗灵'] = ac.map.rects['boss-境界4'],
    ['斗王'] = ac.map.rects['boss-境界5'],
    ['斗皇'] = ac.map.rects['boss-境界6'],
    ['斗宗'] = ac.map.rects['boss-境界7'],
    ['斗尊'] = ac.map.rects['boss-境界8'],
    ['斗圣'] = ac.map.rects['boss-境界9'],
    ['斗帝'] = ac.map.rects['boss-境界10'],

}
--游戏初始化开启
ac.game:event '游戏-开始' (function()
    for key,val in pairs(ac.challenge_boss) do 
        -- print(key,val)
        local mt = ac.creep[key]{    
            region = val,
            creeps_datas = key..'*1',
            cool = 5,
            creep_player = ac.player.com[2],
        }  
        --进攻怪刷新时的初始化
        function mt:on_start()
        end
        --开启
        mt:start()
    end   
end)



