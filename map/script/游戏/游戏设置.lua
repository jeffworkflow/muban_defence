
--游戏全局设置
--ac.rect.map 全图 rect.create(-4000,-4000,4000,4000) or
local rect = require("types.rect")
local region = require("types.region")

ac.map = {}
ac.map_area =  ac.rect.map
ac.map.rects={
    ['刷怪1'] = rect.j_rect('cg1') ,
    ['刷怪2'] = rect.j_rect('cg2') ,
    ['刷怪3'] = rect.j_rect('cg3') ,
	['进攻点'] = rect.j_rect('jg1') ,
	['主城'] = rect.j_rect('jg2_jd') ,
	
    ['刷怪-boss'] = rect.j_rect('cgboss4') ,
	['选人区域'] =rect.j_rect('xr') ,
	['npc1'] =rect.j_rect('npc1') ,
	['npc2'] =rect.j_rect('npc2') ,
	['npc3'] =rect.j_rect('npc3') ,
	['npc4'] =rect.j_rect('npc4') ,
	['npc5'] =rect.j_rect('npc5') ,
	['npc6'] =rect.j_rect('npc6') ,
	['npc7'] =rect.j_rect('npc7') ,
	['npc8'] =rect.j_rect('npc8') ,
	['npc9'] =rect.j_rect('npc9') ,
    ['选人出生点'] =rect.j_rect('xrcs') ,
	['出生点'] =rect.j_rect('F2cs') ,

	--野怪
	['杀鸡敬猴1'] =rect.j_rect('sjjh1') ,
	['杀鸡敬猴2'] =rect.j_rect('sjjh2') ,
	['杀鸡敬猴3'] =rect.j_rect('sjjh3') ,
	

	--练功房 
	['练功房11'] =rect.j_rect('lgf11') ,
	['练功房12'] =rect.j_rect('lgf12') ,
	['练功房13'] =rect.j_rect('lgf13') ,
	['练功房14'] =rect.j_rect('lgf14') ,
	['练功房刷怪1'] =rect.j_rect('lgfsg1') ,

	['练功房21'] =rect.j_rect('lgf21') ,
	['练功房22'] =rect.j_rect('lgf22') ,
	['练功房23'] =rect.j_rect('lgf23') ,
	['练功房24'] =rect.j_rect('lgf24') ,
	['练功房刷怪2'] =rect.j_rect('lgfsg2') ,

	['练功房31'] =rect.j_rect('lgf31') ,
	['练功房32'] =rect.j_rect('lgf32') ,
	['练功房33'] =rect.j_rect('lgf33') ,
	['练功房34'] =rect.j_rect('lgf34') ,
	['练功房刷怪3'] =rect.j_rect('lgfsg3') ,

	['练功房41'] =rect.j_rect('lgf41') ,
	['练功房42'] =rect.j_rect('lgf42') ,
	['练功房43'] =rect.j_rect('lgf43') ,
	['练功房44'] =rect.j_rect('lgf44') ,
	['练功房刷怪4'] =rect.j_rect('lgfsg4') ,

	['练功房51'] =rect.j_rect('lgf51') ,
	['练功房52'] =rect.j_rect('lgf52') ,
	['练功房53'] =rect.j_rect('lgf53') ,
	['练功房54'] =rect.j_rect('lgf54') ,
	['练功房刷怪5'] =rect.j_rect('lgfsg5') ,

	['练功房61'] =rect.j_rect('lgf61') ,
	['练功房62'] =rect.j_rect('lgf62') ,
	['练功房63'] =rect.j_rect('lgf63') ,
	['练功房64'] =rect.j_rect('lgf64') ,
	['练功房刷怪6'] =rect.j_rect('lgfsg6') ,
	
	--武器
	['传送-武器1'] =rect.j_rect('wuqi11') ,
	['传送-武器2'] =rect.j_rect('wuqi22') ,
	['传送-武器3'] =rect.j_rect('wuqi33') ,
	['传送-武器4'] =rect.j_rect('wuqi44') ,
	['传送-武器5'] =rect.j_rect('wuqi55') ,
	['传送-武器6'] =rect.j_rect('wuqi66') ,
	['传送-武器7'] =rect.j_rect('wuqi77') ,
	['传送-武器8'] =rect.j_rect('wuqi88') ,
	['传送-武器9'] =rect.j_rect('wuqi99') ,
	['传送-武器10'] =rect.j_rect('wuqi1010') ,

	['boss-武器1'] =rect.j_rect('wuqi1') ,
	['boss-武器2'] =rect.j_rect('wuqi2') ,
	['boss-武器3'] =rect.j_rect('wuqi3') ,
	['boss-武器4'] =rect.j_rect('wuqi4') ,
	['boss-武器5'] =rect.j_rect('wuqi5') ,
	['boss-武器6'] =rect.j_rect('wuqi6') ,
	['boss-武器7'] =rect.j_rect('wuqi7') ,
	['boss-武器8'] =rect.j_rect('wuqi8') ,
	['boss-武器9'] =rect.j_rect('wuqi9') ,
	['boss-武器10'] =rect.j_rect('wuqi10') ,

	--甲
	['传送-甲1'] =rect.j_rect('jia11') ,
	['传送-甲2'] =rect.j_rect('jia22') ,
	['传送-甲3'] =rect.j_rect('jia33') ,
	['传送-甲4'] =rect.j_rect('jia44') ,
	['传送-甲5'] =rect.j_rect('jia55') ,
	['传送-甲6'] =rect.j_rect('jia66') ,
	['传送-甲7'] =rect.j_rect('jia77') ,
	['传送-甲8'] =rect.j_rect('jia88') ,
	['传送-甲9'] =rect.j_rect('jia99') ,
	['传送-甲10'] =rect.j_rect('jia1010') ,

	['boss-甲1'] =rect.j_rect('jia1') ,
	['boss-甲2'] =rect.j_rect('jia2') ,
	['boss-甲3'] =rect.j_rect('jia3') ,
	['boss-甲4'] =rect.j_rect('jia4') ,
	['boss-甲5'] =rect.j_rect('jia5') ,
	['boss-甲6'] =rect.j_rect('jia6') ,
	['boss-甲7'] =rect.j_rect('jia7') ,
	['boss-甲8'] =rect.j_rect('jia8') ,
	['boss-甲9'] =rect.j_rect('jia9') ,
	['boss-甲10'] =rect.j_rect('jia10') ,

	--技能
	['传送-技能1'] =rect.j_rect('jn11') ,
	['传送-技能2'] =rect.j_rect('jn22') ,
	['传送-技能3'] =rect.j_rect('jn33') ,
	['传送-技能4'] =rect.j_rect('jn44') ,
	
	['boss-技能1'] =rect.j_rect('jn1') ,
	['boss-技能2'] =rect.j_rect('jn2') ,
	['boss-技能3'] =rect.j_rect('jn3') ,
	['boss-技能4'] =rect.j_rect('jn4') ,

	--洗练石
	['传送-洗练石1'] =rect.j_rect('xls11') ,
	['传送-洗练石2'] =rect.j_rect('xls22') ,
	['传送-洗练石3'] =rect.j_rect('xls33') ,
	['传送-洗练石4'] =rect.j_rect('xls44') ,
	
	['boss-洗练石1'] =rect.j_rect('xls1') ,
	['boss-洗练石2'] =rect.j_rect('xls2') ,
	['boss-洗练石3'] =rect.j_rect('xls3') ,
	['boss-洗练石4'] =rect.j_rect('xls4') ,

	--境界
	['传送-境界1'] =rect.j_rect('jj11') ,
	['传送-境界2'] =rect.j_rect('jj22') ,
	['传送-境界3'] =rect.j_rect('jj33') ,
	['传送-境界4'] =rect.j_rect('jj44') ,
	['传送-境界5'] =rect.j_rect('jj55') ,
	['传送-境界6'] =rect.j_rect('jj66') ,
	['传送-境界7'] =rect.j_rect('jj77') ,
	['传送-境界8'] =rect.j_rect('jj88') ,
	['传送-境界9'] =rect.j_rect('jj99') ,
	['传送-境界10'] =rect.j_rect('jj1010') ,

	['boss-境界1'] =rect.j_rect('jj1') ,
	['boss-境界2'] =rect.j_rect('jj2') ,
	['boss-境界3'] =rect.j_rect('jj3') ,
	['boss-境界4'] =rect.j_rect('jj4') ,
	['boss-境界5'] =rect.j_rect('jj5') ,
	['boss-境界6'] =rect.j_rect('jj6') ,
	['boss-境界7'] =rect.j_rect('jj7') ,
	['boss-境界8'] =rect.j_rect('jj8') ,
	['boss-境界9'] =rect.j_rect('jj9') ,
	['boss-境界10'] =rect.j_rect('jj10') ,
}

-- local minx, miny, maxx, maxy = ac.map.rects['刷怪']:get()
-- local point = rect.j_rect('sg002'):get_point()
-- print(minx, miny, maxx, maxy)


--召唤物倍数 波数
local function get_summon_mul(lv)
	local level_mul = {
		[10] ={ 
			['最小范围'] = 0,
			['生命'] = 20, 
			['护甲'] = 0.001, 
			['攻击'] = 0.5, 
		},
		[20] ={ 
			['最小范围'] = 10,
			['生命'] = 10, 
			['护甲'] = 0.001, 
			['攻击'] = 1, 
		},
		[30] ={ 
			['最小范围'] = 20,
			['生命'] = 9, 
			['护甲'] = 0.001, 
			['攻击'] = 3, 
		},
		[40] ={ 
			['最小范围'] = 30,
			['生命'] = 8, 
			['护甲'] = 0.001, 
			['攻击'] = 10, 
		},
		[50] ={ 
			['最小范围'] = 40,
			['生命'] = 7, 
			['护甲'] = 0.001, 
			['攻击'] = 40, 
		},
		[1000000] ={ 
			['最小范围'] = 50,
			['生命'] = 5, 
			['护甲'] = 0.001, 
			['攻击'] = 120, 
		},
	}

	local life_mul = 1
	local defence_mul = 1
	local attack_mul = 1
	for index,info in sortpairs(level_mul) do 
		if lv <= index and lv > info['最小范围']  then 
			life_mul = info['生命']
			defence_mul = info['护甲']
			attack_mul = info['攻击']
			break 
		end 
	end 
	return life_mul,defence_mul,attack_mul
end	

ac.get_summon_mul = get_summon_mul

