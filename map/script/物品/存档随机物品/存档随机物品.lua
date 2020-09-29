--起始id
--存档物品库
local item_list = {
    --名字 = 生成个数 装备类型 装备等级 图标 基础属性
['霓光刀']={num=23,type1 = '武器',lv = 1,art = 'yiji1.blp',rate = 13,attr = {['攻击']=2000000,['攻击减甲']=10}},
['霓光甲']={num=23,type1 = '衣服',lv = 1,art = 'yiji2.blp',rate = 13,attr = {['护甲']=2000}},
['霓光面罩']={num=23,type1 = '头盔',lv = 1,art = 'yiji3.blp',rate = 13,attr = {['护甲']=500,['技能基础伤害']=1000000}},
['霓光靴']={num=23,type1 = '鞋子',lv = 1,art = 'yiji4.blp',rate = 13,attr = {['护甲']=500,['移动速度']=15}},
['霓光腰带']={num=23,type1 = '腰带',lv = 1,art = 'yiji5.blp',rate = 13,attr = {['护甲']=500,['生命上限']=5000000}},
['霓光之钩']={num=23,type1 = '手套',lv = 1,art = 'yiji6.blp',rate = 13,attr = {['护甲']=500,['攻击距离']=15}},

['血腥三月镰']={num=23,type1 = '武器',lv = 2,art = 'erji1.blp',rate = 13,attr = {['攻击']=6000000,['攻击减甲']=30}},
['血腥三月甲']={num=23,type1 = '衣服',lv = 2,art = 'erji2.blp',rate = 13,attr = {['护甲']=6000}},
['血腥三月面罩']={num=23,type1 = '头盔',lv = 2,art = 'erji3.blp',rate = 13,attr = {['护甲']=1500,['技能基础伤害']=3000000}},
['血腥三月鞋']={num=23,type1 = '鞋子',lv = 2,art = 'erji4.blp',rate = 13,attr = {['护甲']=1500,['移动速度']=30}},
['血腥三月腰带']={num=23,type1 = '腰带',lv = 2,art = 'erji5.blp',rate = 13,attr = {['护甲']=1500,['生命上限']=15000000}},
['血腥三月护手']={num=23,type1 = '手套',lv = 2,art = 'erji6.blp',rate = 13,attr = {['护甲']=1500,['攻击距离']=30}},

['银霜法杖']={num=23,type1 = '武器',lv = 3,art = 'sanji1.blp',rate = 13,attr = {['攻击']=18000000,['攻击减甲']=90}},
['银霜甲']={num=23,type1 = '衣服',lv = 3,art = 'sanji2.blp',rate = 13,attr = {['护甲']=18000}},
['银霜头盔']={num=23,type1 = '头盔',lv = 3,art = 'sanji3.blp',rate = 13,attr = {['护甲']=4500,['技能基础伤害']=9000000}},
['银霜鞋']={num=23,type1 = '鞋子',lv = 3,art = 'sanji4.blp',rate = 13,attr = {['护甲']=4500,['移动速度']=60}},
['银霜腰带']={num=23,type1 = '腰带',lv = 3,art = 'sanji5.blp',rate = 13,attr = {['护甲']=4500,['生命上限']=75000000}},
['银霜护手']={num=23,type1 = '手套',lv = 3,art = 'sanji6.blp',rate = 13,attr = {['护甲']=4500,['攻击距离']=60}},

['菲普斯的法杖']={num=23,type1 = '武器',lv = 4,art = 'siji1.blp',rate = 13,attr = {['攻击']=54000000,['攻击减甲']=180}},
['菲普斯的战甲']={num=23,type1 = '衣服',lv = 4,art = 'siji2.blp',rate = 13,attr = {['护甲']=54000}},
['菲普斯的面具']={num=23,type1 = '头盔',lv = 4,art = 'siji3.blp',rate = 13,attr = {['护甲']=13500,['技能基础伤害']=27000000}},
['菲普斯的鞋子']={num=23,type1 = '鞋子',lv = 4,art = 'siji4.blp',rate = 13,attr = {['护甲']=13500,['移动速度']=120}},
['菲普斯的护腰']={num=23,type1 = '腰带',lv = 4,art = 'siji5.blp',rate = 13,attr = {['护甲']=13500,['生命上限']=375000000}},
['菲普斯的护手']={num=23,type1 = '手套',lv = 4,art = 'siji6.blp',rate = 13,attr = {['护甲']=13500,['攻击距离']=120}},

-- --新增
-- ['卓拉的魔石']={num=3,type1 = '武器',lv = 5,art = 'wuji1.blp',rate = 13,attr = {['攻击']=100000000,['攻击减甲']=400}},
-- ['卓拉的魔袍']={num=3,type1 = '衣服',lv = 5,art = 'wuji2.blp',rate = 13,attr = {['护甲']=100000}},
-- ['卓拉的魔法帽']={num=3,type1 = '头盔',lv = 5,art = 'wuji3.blp',rate = 13,attr = {['护甲']=25000,['技能基础伤害']=55000000}},
-- ['卓拉的魔靴']={num=3,type1 = '鞋子',lv = 5,art = 'wuji4.blp',rate = 13,attr = {['护甲']=25000,['移动速度']=150}},
-- ['卓拉的腰带']={num=3,type1 = '腰带',lv = 5,art = 'wuji5.blp',rate = 13,attr = {['护甲']=25000,['生命上限']=750000000}},
-- ['卓拉的护手']={num=3,type1 = '手套',lv = 5,art = 'wuji6.blp',rate = 13,attr = {['护甲']=25000,['攻击距离']=150}},

-- --新增
-- ['天行者的队长盾']={num=3,type1 = '武器',lv = 6,art = 'liuji1.blp',rate = 13,attr = {['攻击']=200000000,['攻击减甲']=800}},
-- ['天行者的胸甲']={num=3,type1 = '衣服',lv = 6,art = 'liuji2.blp',rate = 13,attr = {['护甲']=200000}},
-- ['天行者的头盔']={num=3,type1 = '头盔',lv = 6,art = 'liuji3.blp',rate = 13,attr = {['护甲']=50000,['技能基础伤害']=100000000}},
-- ['天行者的战靴']={num=3,type1 = '鞋子',lv = 6,art = 'liuji4.blp',rate = 13,attr = {['护甲']=50000,['移动速度']=180}},
-- ['天行者的护腰']={num=3,type1 = '腰带',lv = 6,art = 'liuji5.blp',rate = 13,attr = {['护甲']=50000,['生命上限']=1500000000}},
-- ['天行者的护腕']={num=3,type1 = '手套',lv = 6,art = 'liuji6.blp',rate = 13,attr = {['护甲']=50000,['攻击距离']=180}},

--新增
-- ['血骷髅之镰']={num=23,type1 = '武器',lv = 7,art = 'qiji1.blp',rate = 13,attr = {['攻击']=400000000,['攻击减甲']=1600}},
-- ['血骷髅之甲']={num=23,type1 = '衣服',lv = 7,art = 'qiji2.blp',rate = 13,attr = {['护甲']=400000}},
-- ['血骷髅之头']={num=23,type1 = '头盔',lv = 7,art = 'qiji3.blp',rate = 13,attr = {['护甲']=100000,['技能基础伤害']=230000000}},
-- ['血骷髅之蹄']={num=23,type1 = '鞋子',lv = 7,art = 'qiji4.blp',rate = 13,attr = {['护甲']=100000,['移动速度']=210}},
-- ['血骷髅的腰带']={num=23,type1 = '腰带',lv = 7,art = 'qiji5.blp',rate = 13,attr = {['护甲']=100000,['生命上限']=3000000000}},
-- ['血骷髅之手']={num=23,type1 = '手套',lv = 7,art = 'qiji6.blp',rate = 13,attr = {['护甲']=100000,['攻击距离']=210}},

--新增
-- ['火凤之羽']={num=23,type1 = '武器',lv = 8,art = 'baji1.blp',rate = 13,attr = {['攻击']=600000000,['攻击减甲']=2400}},
-- ['火凤之甲']={num=23,type1 = '衣服',lv = 8,art = 'baji2.blp',rate = 13,attr = {['护甲']=600000}},
-- ['火凤头盔']={num=23,type1 = '头盔',lv = 8,art = 'baji3.blp',rate = 13,attr = {['护甲']=150000,['技能基础伤害']=350000000}},
-- ['火凤之足']={num=23,type1 = '鞋子',lv = 8,art = 'baji4.blp',rate = 13,attr = {['护甲']=150000,['移动速度']=240}},
-- ['火凤腰带']={num=23,type1 = '腰带',lv = 8,art = 'baji5.blp',rate = 13,attr = {['护甲']=150000,['生命上限']=4500000000}},
-- ['火凤护手']={num=23,type1 = '手套',lv = 8,art = 'baji6.blp',rate = 13,attr = {['护甲']=150000,['攻击距离']=240}},



}
-- local function get_start_id()
--     local temp={}
--     for name,data in pairs(ac.table.ItemData) do 
--         if data.category == '存档' then 
--             table.insert(temp,data.s_id)
--         end
--     end
--     table.sort(temp,function(a,b)
--         return a>b
--     end)
--     return temp[1] or 1
-- end
--起始id
local start_id =1
--6*20*4*4+1+6*20*4+1+6*20*4+1 + 6*6*4*3+1+ 6*23*4*3+1
-- print(start_id)
local max = 0
for name, data in pairs(item_list) do 
    max = data.num * 4 + max
end   
max = max + start_id
local ids = {}
for i=start_id,max do 
	ids[i] = i
end	

for i=start_id,max do 
	local randindex = math.random(start_id,max)
	local temp = ids[randindex];
	ids[randindex] = ids[i];
	ids[i] = temp;
end

-- for i = start_id,max do 
--     print(i,ids[i])
-- end    


local com_func = {
    -- '（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）'
    ['特殊属性百分比'] = {0.6,0.4},
    -- '（（装备等级-1）*6+（装备品质-1）*3'
    ['地图等级需求'] = {6,3},
    --装备评分公式=100*等级*（主要属性波动百分比）+100*附加属性数量*（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）
    ['装备评分'] = {100,100},
}

local color_attr = {
--品质 = 品质数值 物品模型 最小词条数 最大词条数 词条值因数
['白'] = {1,[[effect_bxg_g.mdx]],0,1,1,1.5},
['蓝'] = {2,[[effect_bxg.mdx]],2,3,0.6,1.5},
['金'] = {3,[[effect_bxy.mdx]],4,5,0.5,1.5},
['暗金'] = {4,[[effect_bxz.mdx]],6,8,0.45,1.5},
}

local max_attribute = {
['杀敌数加成']= 10,
['木头加成']= 10,
['火灵加成']= 10,
['物品获取率']= 10,
['每秒加杀敌数']= 1,
['每秒加木头']= 3,
['每秒加火灵']= 6,

['全属性']= 1500000,
['杀怪加全属性']= 50,
['攻击加全属性']= 250,
['每秒加全属性']= 1000,
['力量']= 3000000,
['杀怪加力量']= 100,
['攻击加力量']= 500,
['每秒加力量']= 2000,
['敏捷']= 3000000,
['杀怪加敏捷']= 100,
['攻击加敏捷']= 500,
['每秒加敏捷']= 2000,
['智力']= 3000000,
['杀怪加智力']= 100,
['攻击加智力']= 500,
['每秒加智力']= 2000,
['攻击']= 6000000,
['杀怪加攻击']= 200,
['每秒加攻击']= 4000,
['护甲']= 3000,
['每秒加护甲']= 2,

['力量%']= 3,
['敏捷%']= 3,
['智力%']= 3,
['护甲%']= 3,
['生命上限%']= 6,
['攻击%']= 6,

['生命上限']= 15000000,
['技能基础伤害']= 3000000,
['生命恢复']= 3000000,
['攻击回血']= 3000000,
['杀怪回血']= 3000000,
['伤害减少']= 3000000,

['移动速度']= 25,
['攻击距离']= 25,
['攻击速度']= 35,
['分裂伤害']= 35,
['吸血']= 10,
['攻击间隔']= -0.02,
['多重射']= 1,

['触发概率加成']= 3,
['技能冷却']= 3,

['攻击减甲']= 50,
['减少周围护甲']= 350,

['暴击几率']= 2,
['技暴几率']= 2,
['会心几率']= 2,
['暴击加深']= 60,
['技暴加深']= 40,
['会心伤害']= 20,
['物理伤害加深']= 30,
['技能伤害加深']= 15,
['全伤加深']= 7.5,
['对BOSS额外伤害']= 7.5,

['免伤']= 2,
['免伤几率']= 2,
['闪避']= 2,
['每秒回血']= 2,

}

local base_attr =[[
力量 敏捷 智力 全属性 生命 生命上限 生命恢复 生命脱战恢复 魔法 
魔法上限 魔法脱战恢复 攻击 护甲 魔抗 攻击间隔 攻击距离 移动速度 减耗 破甲 
破魔 护盾 技能基础伤害 多重射 额外连锁 额外范围 攻击回血 杀怪回血 基础金币 积分加成 熟练度加成 伤害减少
召唤物 
杀怪加力量 杀怪加敏捷 杀怪加智力 杀怪加全属性 杀怪加护甲 杀怪加攻击
每秒加金币 每秒加木头 每秒加力量 每秒加敏捷 每秒加智力 每秒加全属性 每秒加护甲 每秒加攻击
攻击加金币 攻击加木头 攻击加力量 攻击加敏捷 攻击加智力 攻击加全属性 攻击加护甲
攻击减甲
减少周围护甲
额外杀敌数
每秒加火灵 
]]
--字符串是否包含 字符串 字符串 字符串
function finds(str,...)
	local flag = false
	if not str or type(str) =='table' or  type(str) =='function' then 
		return flag
	end	
    for key , value in pairs{...} do
        if value:sub(-1, -1) == '%' then
            value =  value..'%'
        end
		local _, q=string.find(str, value)
		if _ then 
			flag= true
			break
		end	
	end
	return flag
end

function bignum2string(value)
	local value = tonumber(value)
	if type(value) == 'string' then 
		return 
    end	
    --每个装备的评分
    if value < 10000 then
        return math.tointeger(value) or ('%.2f'):format(value)
	elseif value < 100000000 then
        return value % 10000 == 0 and ('%.0f'):format(value/10000)..'万' or ('%.1f'):format(value/10000)..'万'
    else
        return value % 100000000 == 0 and ('%.0f'):format(value/100000000)..'亿' or ('%.1f'):format(value/100000000)..'亿'
    end
end
local specail_skl = {
    '简易','超级简易','无级别','精致','珍宝',
    '破血狂攻','弱点击破','神佑','愤怒','魔兽之印'
}
local function lni_item()
	local lni_str = {}
    local temp_max_attr ={}
    local str = [[['default']
item_type = '消耗品'
category = '存档']]
    table.insert(lni_str,str..'\n')
    -- table.insert(lni_str,str..'\n'
	for key,val in pairs(max_attribute) do
		table.insert(temp_max_attr,{key,val})
	end
	
	for name,data in pairs(item_list) do
        --每个物品 的物品数量  ['霞光刀']={num=20,type1 = '武器',lv = 1,art = 'al.tip',['攻击']=2,['护甲'] = 3},
        for i=1,data.num do
            for color,color_tab in pairs(color_attr) do 
                table.insert(lni_str,"['"..name..ids[start_id].."']"..'\n')
                table.insert(lni_str,"s_id = "..ids[start_id]..""..'\n')
                start_id = start_id + 1
                table.insert(lni_str,"title = "..name..""..'\n')
                table.insert(lni_str,"type1 = '"..data.type1.."'"..'\n')
                table.insert(lni_str,"lv = "..data.lv..""..'\n')
                table.insert(lni_str,"art = '"..data.art.."'"..'\n')
                --处理特性
                local rate = data.rate or 0
                local sub_skl
                if math.random(100000) / 1000 <= rate then 
                    local skl_name = specail_skl[math.random(#specail_skl)]
                    table.insert(lni_str,"sub_skl = '"..skl_name.."'"..'\n')
                    sub_skl = skl_name
                end

                --主要属性浮动%
                local main_attr_per = math.random(50,150)
                table.insert(lni_str,"main_attr_per = "..main_attr_per..""..'\n')

                --处理主要属性
                local main_attr_tab = {}
                for k1,v1 in pairs(data.attr) do 
                    v1 = v1 * main_attr_per/100 
                    v1 = math.tointeger(v1) or ('%.2f'):format(v1)
                    table.insert(main_attr_tab,{k1,v1})
                end    

                --处理color赋值 品质数值 物品模型 最小词条数 最大词条数 词条值因数
                table.insert(lni_str,"color = '"..color.."'"..'\n')
                table.insert(lni_str,"color_lv = "..color_tab[1]..""..'\n')
                table.insert(lni_str,"specail_model = [["..color_tab[2].."]]"..'\n')
                table.insert(lni_str,"min_attr_num = "..color_tab[3]..""..'\n')
                table.insert(lni_str,"max_attr_num = "..color_tab[4]..""..'\n')
                table.insert(lni_str,"attr_a = "..color_tab[5]..""..'\n')
                table.insert(lni_str,"model_size = "..color_tab[6]..""..'\n')

                --随机词条：每个物品的 词缀数,重复的话，重复的数值加上去
                local attr_num = math.random(color_tab[3],color_tab[4])
                table.insert(lni_str,"attr_num = "..attr_num..""..'\n')

                local item = {}
                for n = 1, attr_num do
                    local rd = math.random(1,#temp_max_attr)
                    local key1 = temp_max_attr[rd][1] --取到特殊属性 key
                    local val1 = temp_max_attr[rd][2] --取到特殊属性 val
                    --特殊属性百分比 '（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）'
                    local vv = val1 * (com_func['特殊属性百分比'][1] + data.lv*com_func['特殊属性百分比'][1])*color_tab[5]   
                    vv = math.tointeger(vv) or ('%.2f'):format(vv)
                    local ok = true
                    for i,tab in ipairs(item) do 
                        if tab[1] == key1 then
                            ok = false 
                            if tab[2]> vv then
                                tab[1] = vv
                            end
                        end 
                    end        
                    if ok then 
                        table.insert(item,{key1,vv})
                    end    
                end	
                --装备评分 装备评分公式=100*等级*（主要属性波动百分比）+100*附加属性数量*（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）
                local pf = com_func['装备评分'][1] * data.lv * main_attr_per/100 + com_func['装备评分'][2]*attr_num*(com_func['特殊属性百分比'][1] + data.lv*com_func['特殊属性百分比'][1])*color_tab[5]
                pf = string.format('%.f',pf)
                table.insert(lni_str,"pf = "..pf..""..'\n')
                --地图等级需求 '（（装备等级-1）*6+（装备品质-1）*3'
                local need_map_level = (data.lv-1)*com_func['地图等级需求'][1] + (color_tab[1]-1)*com_func['地图等级需求'][2]
                
                table.insert(lni_str,"need_map_level = "..need_map_level..""..'\n')

                --生成tip
                table.insert(lni_str,'tip = [['..'\n')
                table.insert(lni_str,'|cffffe799评分：|r'..pf..'\n')
                table.insert(lni_str,'%map_level_tip%'..'\n')
                table.insert(lni_str,'|cffffe799属性：|r'..'\n')
                for i,tab in ipairs(main_attr_tab)do 
                    local per_str = finds(base_attr,tab[1])  and '' or '%'
                    local attr_name = tab[1]:sub(-1,-1)=='%' and tab[1]:sub(1,-2) or tab[1]
                    if tonumber(tab[2]) < 0 then 
                        table.insert(lni_str,"|cffffff00"..bignum2string(tab[2])..per_str..' |r'.. attr_name ..'\n')
                    else     
                        table.insert(lni_str,"|cffffff00+"..bignum2string(tab[2])..per_str..' |r'.. attr_name ..'\n')
                    end    
                end
                if #item > 0 then 
                    -- table.insert(lni_str,''
                    -- table.insert(lni_str,'\n|cffffe799额外属性：|r'..'\n'
                end
                for i,tab in ipairs(item) do    
                    local per_str = finds(base_attr,tab[1])  and '' or '%'
                    local attr_name = tab[1]:sub(-1,-1)=='%' and tab[1]:sub(1,-2) or tab[1]
                    if tonumber(tab[2]) < 0 then 
                        table.insert(lni_str,"|cffffff00"..bignum2string(tab[2])..per_str..' |r'.. attr_name ..'\n')
                    else     
                        table.insert(lni_str,"|cffffff00+"..bignum2string(tab[2])..per_str..' |r'.. attr_name ..'\n')
                    end    
                end
                if sub_skl then 
                    table.insert(lni_str,'\n%sub_skl_tip%'..'\n')
                end
                table.insert(lni_str,'\n|cff00ff00点击进行穿戴|cffff0000（只存档穿戴后的装备）|cff00ff00，按Tab查看效果'..'\n')
                table.insert(lni_str,']]'..'\n')

                --合并属性条
                local temp = {}
                for i,tab in ipairs(main_attr_tab) do 
                    table.insert(item,tab)
                end 
                for i,tab in ipairs(item) do 
                    local key = tab[1]
                    local val = tab[2]
                    if not temp[key] then 
                        temp[key] = val
                    else 
                        temp[key] = temp[key] + val
                    end    
                end    
                --生成 属性 lni 
                table.insert(lni_str,"attr = {"..'\n')
                for key,val in pairs(temp)do
                    table.insert(lni_str,"'"..key .."' = " .. val ..',\n')
                end
                table.insert(lni_str,"}")
                --table.insert(lni_str,"'"..key1 .."' = " .. random_val ..'\n'
                table.insert(lni_str,'\n')
            end    
		end	
    end
    local str = table.concat( lni_str,"")
	print(str)

end

local function main()
	 lni_item()

end    

main()

