
local runtime = require 'jass.runtime'
local hero = require 'types.hero'
local japi = require 'jass.japi'
local slk = require 'jass.slk'

hero.hero_list = {
	'阿尔塞斯','大地','剑圣','希尔瓦娜斯','吉安娜','炼金术士',

	'赵子龙','Pa','手无寸铁的小龙女','太极熊猫','虞姬','夏侯霸',

	'至尊宝','关羽','关公','加百列','伊利丹','狄仁杰',
	'','雅典娜','鬼厉','剑仙','王昭君'
}

--加载英雄的数据
function load_heroes()
	for _, name in ipairs(hero.hero_list) do
		-- print(name)
		local data = ac.table.UnitData[name]
		-- print(data)
		if data == nil then 
			-- print('缺少单位数据',name,debug.traceback())
		else 
			local hero_data = ac.hero.create(name)(data)
			-- print(hero_data)
			if hero_data ~= nil then 
				hero.hero_list[name] = hero_data
				select(2, xpcall(require, runtime.error_handle ,('英雄.%s.init'):format(name)))
				
				hero.hero_list[name].data = hero_data
				hero_data.name = name
				hero_data.file = name
				hero_data.slk = slk.unit[base.string2id(hero_data.id)]

				if japi.EXSetUnitArrayString then
					japi.EXSetUnitArrayString(base.string2id(hero_data.id), 10, 0, hero_data.production)
					japi.EXSetUnitInteger(base.string2id(hero_data.id), 10, 1)
					japi.EXSetUnitArrayString(base.string2id(hero_data.id), 61, 0, hero_data.name)
					japi.EXSetUnitInteger(base.string2id(hero_data.id), 61, 1)
				end
			end
		end	
	end

	--英雄总数
	hero.hero_count = #hero.hero_list
end

load_heroes()







