
local slk = require 'jass.slk'
local game = require 'types.game'
local jass = require 'jass.common'
local dbg = require 'jass.debug'
local skill = require 'ac.skill'
local table = table
local japi = require 'jass.japi'
local runtime = require 'jass.runtime'
local affix = require 'types.affix'
local setmetatable = setmetatable
local xpcall = xpcall
local select = select
local error_handle = runtime.error_handle
local unit = require 'types.unit'

local item = {}
local mt = {}
ac.item = item

item.__index = mt
setmetatable(mt, skill)

item.item_map = {}
item.shop_item_map = {}
item.removed_items = setmetatable({}, { __mode = 'kv' })
--类型
mt.type = 'item'

--物品分类
mt.item_type = '无'
--默认不刷新tip
mt.auto_fresh_tip = false
--技能分类
-- mt.skill_type = '物品'

--物品等级
mt.level = 1

--所属单位
mt.owner = nil
--价格
mt.gold = 0

--物品所在的格子
mt.slot_id = nil

--物品是否唯一 如两把新手剑,会丢弃一个
mt.unique = false

--物品类型最大数量 如武器类型 最多带一个 0为不限制
mt.type_count = 0

--物品类型ID
mt.type_id = nil

--物品句柄
mt.handle = nil

--物品名
mt.name = ''

--是否可以丢弃
mt.drop = true

--物品数量 (数量为0的物品使用完不会删除，有使用次数的物品使用完会被删除)
mt._count = 0

--模型
-- 需要完善:依据装备品质，设置默认的模型
mt._model = [[Objects\InventoryItems\TreasureChest\treasurechest.mdl]]

--可以出售
mt.sell = true

--物品出售折扣
mt.discount = 0.5
--默认物品图标 书籍
mt.art = [[ReplaceableTextures\CommandButtons\BTNSnazzyScrollPurple.blp]]
--物品最大使用次数
mt.max_use_count = 99999
--商品当前库存和最大库存
mt.shop_count = 1
mt.shop_max_count = 1

--商品库存恢复时间

--颜色代码
local blend_file = {
    ['红'] = 'hong',
    ['绿'] = 'lv', 
    ['蓝'] = 'lan',--浅蓝
    ['黄'] = 'huang',
    ['青'] = nil,
    ['紫'] = 'zi',
    ['橙'] = nil,
    ['棕'] = nil,
    ['粉'] = nil,
    ['白'] = 'bai',
    ['黑'] = nil,
    ['金'] = 'huang',
	['灰'] = nil,
	['淡黄'] = nil,	
}
ac.blend_file = blend_file

--颜色代码
local color_code = {
    ['红'] = 'ff0000',
    ['绿'] = '00ff00', 
    ['蓝'] = '00bdec',--浅蓝
    ['黄'] = 'ffff00',
    ['青'] = '00ffff',
    ['紫'] = 'df19d0',
    ['橙'] = 'FFCC00',
    ['棕'] = 'a67d3d',
    ['粉'] = 'bc8f8f',
    ['白'] = 'ffffff',
    ['黑'] = '883A00',
    ['金'] = 'ffff00',
	['灰'] = 'cccccc',
	['淡黄'] = 'FFE799',
    ['神'] = 'df19d0', --91007F 860202
	
}
ac.color_code = color_code

--颜色模型 目前应用于仙丹模型
local color_model = {
    ['白'] = [[faguangbai.mdx]],
    ['蓝'] = [[faguanglan.mdx]],
    ['金'] = [[faguanghuang.mdx]],
    ['红'] = [[faguanghong.mdx]],
    ['绿'] = [[faguanglv.mdx]],
    ['紫'] = [[faguangzi.mdx]],
}

--颜色模型 目前应用于装备
local zb_color_model = {
    ['白'] = [[File00000376 - W.mdx]],
    ['蓝'] = [[File00000376 - B.mdx]],
    ['金'] = [[File00000376 - Y.mdx]],
    ['红'] = [[File00000376 - R.mdx]],
    ['绿'] = [[File00000376 - G.mdx]],
    ['书'] = [[ArcaneTome.mdx]],
}
ac.zb_color_model = zb_color_model


local drop_flag = false
local item_slk = slk.item

--获取一个句柄
function ac.get_item_handle()
	local id = ac.item_list[#ac.item_list]
	if not id then
		print('物品句柄上限')
		return
	end

	table.remove(ac.item_list)
	return id
end

--回收句柄
function ac.remove_item_handle(handle)
	-- print('回收句柄',handle)
	table.insert(ac.item_list,handle)
end

--获取物品对应的技能id 物编内的
function mt:get_item_skillid()
	local id = self.type_id
	return 'A'..string.sub(id,2,4)
end

--获取物品名
function mt:get_name()
	return self.name
end


--设置物品名 增加显示等级
function mt:set_name(name)
	-- self.name = name
	local id = self.type_id
	local color = color_code[self.color or '白']
	local show_lv = ''
	if self.show_level then 
		if self.level == self.max_level then 
			show_lv = 'Lvmax'
		else
			show_lv = 'Lv'..self.level 
		end		
	end	
	if self.suit_type then 
		color = color_code['绿']
	end	

	local str = '|cff'..color..tostring(name)..show_lv..'|r'
	if not self.store_name then 
		self.store_name = str
	end	
	if not self.color_name then 
		self.color_name = str
	end	
	japi.EXSetItemDataString(base.string2id(id),4,str)
end
--获取商店物品显示名字
function mt:get_store_name()
	return self.store_name or self.name or ''
end
--设置物品说明
--物品掉落地上时，点击物品的说明
function mt:set_descrition(str)
	local id = self.type_id
	japi.EXSetItemDataString(base.string2id(id),5,str)
end

--设置物品描述
function mt:set_tip(str)
	local id = self.type_id
	japi.EXSetItemDataString(base.string2id(id),3,str)
	japi.EXSetItemDataString(base.string2id(id),5,str)
end

--设置贴图
function mt:set_art(art)
	local art = art or self.art or ''
	-- print('设置贴图1',self.name,self.art,art)
	local id = self.type_id
	japi.EXSetItemDataString(base.string2id(id),1,art)
end

--设置位置
function mt:setPoint(point)
	local x, y = point:get()
	jass.SetItemPosition(self.handle, x, y) --设置物品的位置
	self:show(true)

	return true
end

--设置是否可丢弃
function mt:disable_drop(is)
	jass.SetItemDroppable(self.handle, is)
end

--获取购买价格
function mt:buy_price()
	return self.gold or 0,(self.show_gold or 0),self.player_gold and self.player_gold[ac.player.self] 
end

--获取出售价格
function mt:sell_price()
	local count = self:get_item_count()
	local gold = self.gold  or 0
	if count > 1 and self.item_type =='消耗品' then
		gold = gold * count
	end
	gold = math.floor(gold * self.discount)
	return gold
end

--获取购买木头
function mt:buy_wood()
	return self.wood or 0,(self.show_wood or 0),self.player_wood and self.player_wood[ac.player.self] 
end

--获取出售木头
function mt:sell_wood()
	local count = self:get_item_count()
	local wood = self.wood  or 0
	if count > 1 then
		wood = wood * count
	end
	wood = math.floor(wood * self.discount)
	return wood
end

--获取购买杀敌数
function mt:buy_kill_count()
	local gold = (self.player_kill and self.player_kill[ac.player.self]) and self.player_kill[ac.player.self] or (self.kill_count or 0)
	-- print(gold,self.kill_count)
	self.kill_count = self.kill_count or 0 
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			if ac.player.self.kill_count then 
				gold = gold ..'   |cff00ffff(拥有'..(ac.player.self.kill_count or '0')..')|r'
			end
		end	
	end
	self.show_kill_count = gold
	return self.kill_count,self.show_kill_count,self.player_kill and self.player_kill[ac.player.self] 
end

--获取出售杀敌数
function mt:sell_kill_count()
	local count = self:get_item_count()
	local kill_count = self.kill_count or 0
	if count > 1 then
		kill_count = kill_count * count
	end
	kill_count = math.floor(kill_count * self.discount)
	return kill_count
end

--获取购买积分
function mt:buy_jifen()
	local gold = (self.player_jifen and self.player_jifen[ac.player.self] ) and self.player_jifen[ac.player.self] or (self.jifen or 0)
	self.jifen = self.jifen or 0 
	-- self.jifen = gold
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			gold = gold..'   |cff00ffff(拥有'..(ac.player.self.jifen or '0')..')|r'
		end	
	end
	self.show_jifen = gold
	return self.jifen,self.show_jifen,self.player_jifen and self.player_jifen[ac.player.self] 
end

--获取出售积分
function mt:sell_jifen()
	local count = self:get_item_count()
	local jifen = self.jifen or 0
	if count > 1 then
		jifen = jifen * count
	end
	jifen = math.floor(jifen * self.discount)
	return jifen
end

--获取购买火灵
function mt:buy_fire_seed()
	local gold = (self.player_fire and self.player_fire[ac.player.self]) and self.player_fire[ac.player.self] or (self.fire_seed or 0)
	-- self.fire_seed = gold
	self.fire_seed = self.fire_seed or 0 
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			gold = gold ..'   |cff00ffff(拥有'..(ac.player.self.fire_seed or '0')..')|r'
		end	
	end
	self.show_fire_seed = gold
	return self.fire_seed,self.show_fire_seed,self.player_fire and self.player_fire[ac.player.self] 
end

--获取出售火灵
function mt:sell_fire_seed()
	local count = self:get_item_count()
	local fire_seed = self.fire_seed  or 0
	if count > 1 then
		fire_seed = fire_seed * count
	end
	fire_seed = math.floor(fire_seed * self.discount)
	return fire_seed
end

--增加物品层数
function mt:add_item_count(count)
	local count = self._count + count
	self:set_item_count(count)
end

--设置物品使用层数
function mt:set_item_count(count)
	self._count = count
	if count > 0 then 
		jass.SetItemCharges(self.handle,count)
		self:set_tip(self:get_tip())
	else 
		self:item_remove()	
	end	
end

--获取物品使用层数
function mt:get_item_count()
	return self._count or 0
end

--显示物品 是否显示地上的模型
function mt:show(is)
	if not self.handle then 
		return
	end	
	local handle = self.handle
	jass.SetItemVisible(handle,true)
	if is then
        -- self.recycle = false
		if self._eff then
			self._eff:remove()
			self._eff = nil
		end
		-- print(self:get_point())
		-- self._eff = ac.effect(self:get_point(),self._model,270,1,'origin')
		
		-- --设置物品模型 套装 模型大小
		-- if self.model_size and self._eff then 
		-- 	self._eff.unit:set_size(self.model_size )
		-- end
		self._eff = ac.effect_ex{
			point = self:get_point(),
			model =self._model,
		   size = self.model_size or 1,
		   angle = 270
	   }
	end
end

--隐藏物品 隐藏时会把地上的模型也删掉
function mt:hide()
	local handle = self.handle
	jass.SetItemVisible(handle,false)
	if self._eff then
		self._eff:remove()
		self._eff = nil
	end
end

--物品是否可见 在单位身上 or 被隐藏起来的物品 都会返回false
function mt:is_show()
	return ((jass.IsItemVisible(self.handle) == true))
end

--获取物品在地上的坐标
function mt:get_point()
	local x,y = jass.GetItemX(self.handle),jass.GetItemY(self.handle)
	return ac.point(x,y)
end

--初始化一下技能
function mt:item_init_skill()
	local hero = self.owner
	if not hero then
		-- print('初始化技能失败，没有所有者',self.name)
		return
	end

	local lv = self.level
	self.level = 0
	self:upgrade(lv)
	-- print(self.level,lv)
	-- print()
	self:fresh()
	-- if not self.is_skill_init then
	-- 	--修复暗图标，物品类的只有亮图标 
	-- 	self:set_art(self.on_bland or self.art)
	-- end
	-- 用 item.not_dis = true 替换
	japi.EXSetAbilityDataReal(self:get_handle(), 1, 0x69, self.cool or 0)
	-- self.is_skill_init = true
end
function mt:get_item_lni_tip(str)
	local item_tip = str or (self.lni_data and self.lni_data.tip ) or ''
	item_tip = item_tip:gsub('%%([%S_]*)%%', function(k)
		local value = self[k]
		local tp = type(value)
		local color_flag
		if tp == 'function' then
			value =  value(self)
			tp = type(value)
		end
		if tp =='number' then 
			value = self.is_small_num and ac.format_number(value) or ac.format_number_tip(value)
			color_flag = true 
		end
		if color_flag then 
			return '|cff'..color_code['金']..tostring(value)..'|r'
		else 
			return tostring(value)
		end		
	end)

	return item_tip
end	
--获取物品描述
function mt:get_tip()
	local owner = self.owner
	local store_title =''
	local gold =''
	local skill_tip = self:get_simple_tip() or ''
	local item_tip = self:get_item_lni_tip() or ''
	local tip = ''
	local color_tip = ''
	local item_type_tip = ''
	if self.item_type =='消耗品' then 
		item_type_tip = '|cff'..ac.color_code['淡黄'].. '类型：|R|cff'..ac.color_code['绿']..self.item_type..'\n'
	end	
	
	if self.cus_type then 
		item_type_tip = '|cff'..ac.color_code['淡黄']..'类型：|R'..'|cff'..ac.color_code['紫']..self.cus_type..'\n'
	end	
	if self.item_type_tip then 
		item_type_tip = self.item_type_tip
	end	
	--如果物品tip和技能tip一致，不添加技能tip
	--去掉颜色代码
	local t_str = skill_tip:gsub('|[cC]%w%w%w%w%w%w%w%w(.-)|[rR]','%1'):gsub('|n','\n'):gsub('\r','\n')
	local s_str = item_tip:gsub('|[cC]%w%w%w%w%w%w%w%w(.-)|[rR]','%1'):gsub('|n','\n'):gsub('\r','\n')
	-- print(t_str,s_str)
	-- print(self.color)
	if self.color then 
		color_tip = '|cff'..ac.color_code['淡黄'].. '品质：|R|cff'..ac.color_code[self.color]..self.color..'|r\n'
	end	
	if self.color_tip then 
		color_tip = self.color_tip
	end	

	if owner then
		--有所属单位则说明物品在身上
		if self:sell_price() > 0 then 
			gold = '|cff'..ac.color_code['淡黄']..'售价：|R'..self:sell_price()..'|r|n'
		end	
		if self:sell_wood() > 0 then 
			gold = '|cff'..ac.color_code['淡黄']..'售价：|R'..self:sell_wood()..'(木头)|r|n'
		end	
		if self.get_sell_tip then 
			gold = self.get_sell_tip
		end	
	end

	local content_tip =''
	if self.item_type =='装备' then 
		content_tip = '|cff'..ac.color_code['淡黄']..'基本属性：|R\n'
	end
	if self.item_type =='消耗品' then 
		content_tip = '|cff'..ac.color_code['淡黄']..'增加属性：|R\n'
	end
	--技能
	if self.is_skill  then 
		content_tip = '|cff'..ac.color_code['淡黄'].. '技能介绍：'..'|R\n'
	end
	--自定义 内容说明titile '|cff'..ac.color_code['淡黄'].. self.content_tip ..'|R\n'
	if self.content_tip  then 
		content_tip = self.content_tip
	end
	
	
	tip = store_title..gold..color_tip..item_type_tip..content_tip.. item_tip
	-- print(item_tip,skill_tip)
	if skill_tip and t_str ~= s_str then 
	    if item_tip ~='' then  
			local temp_tip = '|cff'..color_code['灰']..'技能：'..'|r'..'\n' 
		end	
		tip = tip..(temp_tip or '')..skill_tip..'\n'
	end	
	-- 物品最后一行换行 
	-- items.lni_data = data
	tip = tip .. ''
	return tip
	
end
local function register_item_destroy_event(item_handle)
	if not  item_handle  or item_handle == 0 then 
		return 
	end	
	local trg = jass.CreateTrigger()

	jass.TriggerRegisterDeathEvent(trg,item_handle)

	jass.TriggerAddAction(trg,function ()
		local handle = GetTriggerWidget()
		local it = ac.item.item_map[handle]
        -- print('触发丢弃物品',it.owner,it.name,it._model)
		if not it then
			return
		end
		if it._eff then 
			it._eff:remove()
		end	
	end)
	
end

--单位获得物品 添加属性
function mt:on_add_state()
	local hero = self.owner

	if not hero or not hero:is_type('英雄') then 
		return
	end	

	--保存物品
	local name = self.name

	--单位的属性表
	local data = ac.unit.attribute

	local state = {}
	for key in sortpairs(data) do 
		local value 
		if self.random then 
			value = self.randm_data[key]
			if value then 
				value = math.random(value[1],value[2])
			end 
		else 
			value = self[key]
		end 
		if value then 
			table.insert(state,{name = key,value = value})
		end 
		key = key..'%'
		value = self[key]
		if value then 
			table.insert(state,{name = key,value = value})
		end 
	end
	table.sort(state,function (a,b)
		return a.name < b.name
	end) 

	local is_show_text = self:get_type() == '神符'
	for index,value in ipairs(state) do 
		if is_show_text then 
			ac.texttag
			{
				string = value.name .. ' +' .. value.value,
				size = 10,
				position = hero:get_point(),
				speed = 86,
				red = (self.color[1] / 255 * 100),
				green = (self.color[2] / 255 * 100),
				blue = (self.color[3] / 255 * 100),
				player = hero:get_owner()
			}
		end
		-- print('物品添加属性：',value.name,value.value)
		if self.item_type ~= '消耗品' then
			hero:add_tran(value.name,value.value)
		end	
	end 
	self.state = state
end
--单位 使用物品 添加属性
function mt:on_use_state()
	local hero = self.owner
	if not hero or self.not_use_state then 
		return
	end	
	--物品，是否宠物可代替英雄，默认不行。
	if  self.item_type == '神符' and self.is_peon_on then
		--让宠物使用物品时给英雄增加对应的属性
		hero = hero:get_owner().hero
	end	

	if self.item_type == '消耗品' then
		--让宠物使用物品时给英雄增加对应的属性
		hero = hero:get_owner().hero
	end	
	--最大使用次数相关
	if not hero.use_item then 
		hero.use_item = {}
	end	
	hero.use_item[self.name] = (hero.use_item[self.name] or 0) + 1
	if hero.use_item[self.name] > self.max_use_count then 
		hero:get_owner():sendMsg('|cffFFE799【系统消息】|r|cffff0000操作失败|r '..self.color_name..'已被激活，可以在神器系统中查看',2)
		return 
	end	
	--播放特效
	hero:add_effect('chest','Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx'):remove()

	-- print(hero)
	--保存物品
	local name = self.name

	--单位的属性表
	local data = ac.unit.attribute

	local state = {}
	for key in sortpairs(data) do 
		local value 
		if self.random then 
			value = self.randm_data[key]
			if value then 
				value = math.random(value[1],value[2])
			end 
		else 
			value = self[key]
		end 
		if value then 
			table.insert(state,{name = key,value = value})
		end 
		key = key..'%'
		value = self[key]
		if value then 
			table.insert(state,{name = key,value = value})
		end 
	end
	table.sort(state,function (a,b)
		return a.name < b.name
	end) 

	local is_show_text = self:get_type() == '神符'
	for index,value in ipairs(state) do 
		if is_show_text then 
			ac.texttag
			{
				string = value.name .. ' +' .. value.value,
				size = 10,
				position = hero:get_point(),
				speed = 86,
				red = (self.color[1] / 255 * 100),
				green = (self.color[2] / 255 * 100),
				blue = (self.color[3] / 255 * 100),
				player = hero:get_owner()
			}
		end
		if self.item_type == '消耗品' or self.item_type == '神符' then
			-- print('使用物品,增加属性：',name,value.name,value.value)
			hero:add_tran(value.name,value.value)
		end	
	end 
	self:set_tip(self:get_tip())

end


--单位失去物品 扣除属性
function mt:on_remove_state()
	local hero = self.owner

	if not hero then 
		return
	end	

	local name = self.name

	if self.state then 
		for index,value in ipairs(self.state) do 

			if self.item_type ~= '消耗品' then
				hero:add_tran(value.name,-value.value)
			end	

		end 
		self.state = nil 
	end
end

--删除物品
function mt:item_remove(is)
	-- print('即将移除物品：',self.slot_id,self.name,self.handle)
	-- self.removed = true --skill 那边会认为已经移除，不会进行on_remove 操作
	--排除神符类的移除
	if not self.handle then 
		return
	end	
	
	self.has_removed = true
	--移除物品时，如果物品在单位身上，会触发单位丢弃物品事件，会先执行下面代码，再执行单位丢弃。
	self.is_discard_event = true
	if self.owner then 
		self.owner:remove_item(self)
	end	
	jass.RemoveItem(self.handle)
	dbg.handle_unref(self.handle)

	ac.item.item_map[self.handle] = nil
	ac.item.removed_items[self] = self
	self.handle = nil
	self.owner = nil
	self.slot_id = nil
	ac.remove_item_handle(self.type_id)
	if self._eff then
		self._eff:remove()
		self._eff = nil
	end
	
end

--单位是否有物品,查到立即返回
--可根据物品名称，或是物品品质返回物品。
function unit.__index:has_item(it,all)
	if not it then 
		return 
	end	
	if type(it) == 'string' then 
		it_name = it
	else 
		if it.name then
			it_name = it.name
		else 
			print('传入的物品没有名称')
			return 
		end
	end	
	local item 
	if all then 
		for i = 1,100 do
			local items = self.item_list[i]
			if items and (items.name == it_name or items.color == it_name)then
				item = items
				break
			end
		end
	else	
		for i=1,6 do
			local items = self:get_slot_item(i)
			if items and (items.name == it_name or items.color == it_name)then
				item = items
				break
			end
		end
	end	
	return item
end

--单位是否有物品,handle 查询,查到立即返回
function unit.__index:has_item_handle(handle)
	if not handle then 
		return 
	end	

	local item 
	for i=1,6 do
		local items = self:get_slot_item(i)
		if items and items.handle == handle  then
			item = items
			break
		end
	end

	return item
end

--添加物品
--true,满格掉地上。默认是阻止添加。
--应用： 合成装备时，满格掉落地上,给与装备，满格掉落
function unit.__index:add_item(it,is_fall)

	--如果没有初始化则创建
	if type(it) =='string'  then 	
		--不创建特效
		it = ac.item.create_item(it,nil,true)
		it:hide()
		it.recycle = true
	end	
	if not self.item_list  then 
		self.item_list ={}
	end	
	if self:has_item_handle(it.handle) then 
		-- print('单位已有该物品不需要添加')
		--不阻止 丢弃物品事件
		it.is_discard_event = false 
		return 
	end
	-- 统一修复，如果英雄死亡时给与，统一掉地上。
	if not self:is_alive() then 
		it:setPoint(self:get_point())
		it.recycle = false
		self.buy_suc = true 
		if it.item_type == '神符' then 
			-- @神符类的 在英雄死亡时直接删除，不通用可能会由问题************
			it:item_remove()
		end	
		return it
	end	
	--如果物品指定所有者，不是所有者就返回
	if it.owner_ship and it.owner_ship:get_owner() ~= self:get_owner() then 
	   self.owner:showSysWarning('不是你的')
	   return 
	end   	
	--为了合成装备
	-- print('装备2',it)
	if it.check_hecheng then 
		if self:event_dispatch('单位-合成装备', self, it) then
			self.buy_suc = true 
			return 
		end
	end
	
	if self:event_dispatch('单位-即将获得物品', self, it) then
		--装备唯一时，要求掉落在地上 如果代码直接添加，无法被加在地上。
		-- if is_fall then
		-- 	it:setPoint(self:get_point())
		-- end	
		--消耗品 就算 掉地上也要回收
		if it.recycle then
			it:item_remove()
		end	
		 
		--给与 时的处理逻辑
		-- 唯一装备可能要处理下。
		if it.geiyu then
			it.geiyu = false 
			-- print(it.name)
			if it.unique then 
				it:setPoint(self:get_point())
				it.recycle = false
			end	
		end 
		return
	end
	
	--获取一个空槽位
	local slot = self:get_nil_slot()
	if not slot then
		self.owner:showSysWarning('物品栏已满')
		--满格时，掉落地上
		if is_fall then
			it:setPoint(self:get_point())
			it.recycle = false
		elseif it.recycle then
			--物品栏已满，需要回收
			-- @应用在 购买商店物品 、 代码直接添加物品给英雄
			it:item_remove()
		end		
		return it
	end
	--单位真正获得物品时的处理
	it.recycle = false
	self.buy_suc = true 
	it.owner = self
	self.item_list[slot] = it
	it.slot_id = slot
	-- print('获得物品',it.handle,it.owner,it.name,it.slot_id)
	-- self:print_item(true)
	-- 如果单位身上已经有这个物品的handle了，再添加一次会触发先丢弃再获得物品事件。
	-- print('1',it.handle,it.owner,self.handle,it.is_skill_init)
	jass.UnitAddItem(self.handle,it.handle)
	-- print('2',it.handle,it.owner,self.handle,it.is_skill_init)

	--不阻止 丢弃物品事件   
	--有时很奇怪，已经获得这个物品了，再用UnitAddItem 添加时，没有丢弃物品。所以这边操作是个修补操作
	it.is_discard_event = false 

	-- print(it.owner,self.handle,it.is_skill_init)
	-- if not it.is_skill_init then
	it:item_init_skill()
	-- else
	-- 	it:_call_event 'on_add'
	-- end
			
	-- it:on_add_state() 

	ac.wait(10,function()
		it:hide()
	end)
	--刷新 当前选择的单位的tip
	if it.auto_fresh_tip then
		ac.loop(1000, function(t)
			if not it.owner then
				t:remove()
				return
			end
			--设置tip
			it:set_tip(it:get_tip())
			--刷新货币
			-- it:buy_price()
			-- it:buy_wood()
			-- it:buy_kill_count()
			-- it:buy_jifen()
			-- it:buy_fire_seed()
		end)
	end
	self:event_notify('单位-获得物品后',self, it)
	-- self:print_item(true)
	--刷新tip
	-- it:fresh_tip()
	-- print(it:get_tip())
	return it
end
--打印单位身上的物品 ，打印全部 或是 当前页
function unit.__index:print_item(all)
	-- 测试 是否移除成功
	local pt = ''
	if not all  then 
		for i = 1,6 do
			local item = self:get_slot_item(i)
			if item then 
				pt = pt ..item.slot_id ..item.name .. ','
			end	
		end
	else
		for i = 1,100 do
			local item = self.item_list[i]
			if item then 
				pt = pt ..item.slot_id ..item.name .. ','
			end	
		end
	end	
	print(pt)
end
--单位移除找到的物品
--	具体的某物品或根据名字找到的第一个物品
--	false 真删 ,true 丢在地上。
function unit.__index:remove_item(it)
	if not it  then
		print('物品已被移除')
		return false
	end
	-- print('即将从单位移除物品：',it.slot_id,it.name,it.handle,ac.clock())
	-- it:on_remove_state()
	-- print('触发丢弃物品',it.name,it.type,it.handle)
	--移除技能
	if it.owner then 
		it:_call_event 'on_remove'
	end	

	--神符类的物品，有所有者，但是没有slot_id 所以，需要做一重判断
	local slot = it.slot_id

	--删除单位身上的table值
	if slot then 
		if self.item_list then 
			self.item_list[slot] = nil
		end	
	end	
	it.slot_id = nil
	it.owner = nil

	--阻止触发物品丢弃	modify by jeff 从单位身上移除装备，都是丢在地上
	it.is_discard_event = true
	
	--触发丢弃物品时，没有马上返回物品位置。
	ac.wait(0,function()
		-- print(it:get_point())
		it:show(true)
	end)   
	
	jass.UnitRemoveItem(self.handle,it.handle)
	if it.after_remove then 
		it:after_remove(self)
	end	
	self:event_notify('单位-丢弃物品后',self, it)
	return it
end


--获取一个空槽位
function unit.__index:get_nil_slot()
	local a,b = self:get_bar_page()
	if not self.item_list then 
		self.item_list = {}
	end	
	for i=a,b do
		local slot = self.item_list[i]
		if not slot then
			return i
		end
	end
	return
end

--获取指定槽位的物品
function unit.__index:get_slot_item(slot)
	local page = self.currentpage or 1
	slot = (page - 1) * 6 + slot
	if not self.item_list then 
		self.item_list = {}
	end	
	local item = self.item_list[slot]
	if item then
		return item
	end
	return
end

--获取当前页面索引，如第一页是1-6
function unit.__index:get_bar_page()
	local page = self.currentpage or 1
	local a = (page - 1) * 6 + 1
	local b = a + 5
	return a,b
end

--是否存在同名武器
function unit.__index:get_unique_name(it)
	for i=1,6 do
		local items = self:get_slot_item(i)
		if items and items.name == it.name then
			return items
		end
	end
	return 
end


--判断以携带同类型物品数量是否超标
function unit.__index:get_type_count(it)
	if it.type_count == 0 then
		return false
	end

	local count = it.type_count
	local n = 0
	for i=1,6 do
		local items = self:get_slot_item(i)
		if items and items.item_type == it.item_type then
			n=n+1
			if n >= count then
				return true
			end
		end
	end

	return false
end


--创建物品
--物品名称
--位置
--是否创建特效，默认创建,true 不创建， false 创建
function item.create_item(name,poi,is)
	--创建一个物品
	local items = setmetatable({},item)
	
	--在继承skill的属性(如果带技能的话,不存在技能时遍历一下也无所谓)
	-- local data = ac.skill[name]
	-- for k, v in pairs(data) do
	-- 	items[k] = v
	-- end	
	local skl = ac.dummy:add_skill(name,'英雄')
	for k, v in sortpairs(skl) do
		items[k] = v
	end
	items.owner = nil
	skl:remove()
	-- print_r(items.old_status or {})
	--如果存在lni则继承lni的属性
	local data = ac.table.ItemData[name]
	items.lni_data = data
	if data then
		for k, v in sortpairs(data) do
			items[k] = v
		end
	end
	if items.old_status then 
		items.old_status = nil 
	end
	-- print(items['全属性'])
	

	--读取一个句柄
	local type_id = ac.get_item_handle()
	if not type_id then 
		ac.player.self:sendMsg('|cffff0000物品超出上限，请及时清理地上物品!|r',10)
		return 
	end	
	items.type_id = type_id
	--如果有坐标，则说明创建在地上的
	local x,y = 0,0
	-- print('指定坐标创建物品',poi)
	if poi then
		x,y = poi:get()
	end
	
	--创建一个实例物品
	local item_handle = jass.CreateItem(base.string2id(type_id),x,y)
	if item_handle and ac.item.item_map[item_handle] then 
		print('该物品已被创建在地图',ac.item.item_map[item_handle].name,item_handle)
		-- return ac.item.item_map[items.handle]
	end	
	dbg.handle_ref(item_handle)
	items.handle = item_handle

	x = jass.GetItemX(item_handle)
	y = jass.GetItemY(item_handle)

	--设置物品模型 消耗品
	if items.color and items.item_type == '消耗品' then 
		items._model = color_model[items.color]
	end
	
	--设置物品模型 装备
	if items.color and items.item_type == '装备' then 
		items._model = zb_color_model[items.color]
	end

	--设置物品模型 套装
	if items.color and items.suit_type  then 
		items._model = zb_color_model['绿']
	end
	if items.specail_model then 
		items._model = items.specail_model
	end	
	if not is then 
		-- items._eff = ac.effect(ac.point(x,y),items._model,270,1,'origin')
		-- --设置物品模型 套装 模型大小
		-- if items.model_size and items._eff then 
		-- 	items._eff.unit:set_size(items.model_size )
		-- end
		items:show(true)
	end
	
	--设置使用次数
	if items.item_type == '消耗品' and items._count == 0 then 
		items._count = 1
	end	
	if items._count > 0 then 
		items:set_item_count(items._count)
	end
	-- 按图标处理，所有物品默认都是没有按图标的。
	items.not_dis = true
	-- print(items.name,items.item_type,items._count)
	--设置物品名
	items.name = name
	items:set_name(items.title or name)
	-- print(items.tip)
	--设置tip
	items:set_tip(items:get_tip())
	--设置贴图
	items:set_art(items.art)
	--混合图标处理
	local blend = items.blend or blend_file[items.color or 'nil'] 
	if blend then 
		items.owner = ac.dummy
		if items.level >=1 then 
			items.on_bland = items:add_blend(blend, 'frame', 2)
		else
			items.level = 1
			items.on_bland = items:add_blend(blend, 'frame', 2)
			items.level = 0
		end	
		items.owner = nil
	end	
	--是否可以丢弃
	items:disable_drop(items.drop)

	local skill_id = items:get_item_skillid()
	items.ability_id = skill_id

	--绑定 物品被A时，地上特效删除 的事件
	-- 会引起掉线 不用
	-- register_item_destroy_event(item_handle)

	-- 记录全图物品
	ac.item.item_map[items.handle] = items
	ac.game:event_notify('物品-创建', items)
	return items
end


--创建物品 - 商店使用
--@商品位置 必填
function item.create(name,pos,seller)
	
	--创建一个物品
	local items = setmetatable({},item)


	--在继承skill的属性(如果带技能的话,不存在技能时遍历一下也无所谓)
	local data = ac.skill[name]
	for k, v in sortpairs(data) do
		items[k] = v
	end	

	--如果存在lni则继承lni的属性
	local data = ac.table.ItemData[name]
	if data then
		for k, v in sortpairs(data) do
			items[k] = v
		end
	end
	items.lni_data = data
	-- print(items.type_id)
	if not items.type_id then 
		local type_id = ac.get_shop_item_handle(pos)
		if not type_id then 
			print('商店模板id超出限制')
			return 
		end	
		items.type_id = type_id
	end	

	--创建一个实例物品
	local item_handle = jass.CreateItem(base.string2id(items.type_id),0,0)
	ac.item.shop_item_map[name] = items
	-- ac.item.shop_item_map[item_handle] = items

	items.handle = item_handle
	--设置物品名
	items.name = name
	items:set_name(items.title or name)
	--设置贴图
	items:set_art(items.art)
	--技能处理
	-- local flag 
	-- for i,v in ipairs(ac.skill_list2) do
	-- 	if v == items.name then 
	-- 		flag = true
	-- 		break
	-- 	end    
	-- end 
	-- if flag then 
	-- 	items.color = '紫'
	-- end	
	--混合图标处理
	local blend = items.blend or blend_file[items.color or 'nil'] 
	if blend then 
		items.owner = ac.dummy
		if items.level >=1 then 
			items.on_bland = items:add_blend(blend, 'frame', 2)
		else
			items.level = 1
			items.on_bland = items:add_blend(blend, 'frame', 2)
			items.level = 0
		end	
		items.owner = nil
	end	

	--设置tip
	items:set_tip(items:get_tip())
	-- if ac.skill[name].is_skill then
	-- 	items.is_skill = true
	-- end
	
	ac.game:event_notify('物品-创建', items)
	return items
end

--商店标题
function mt:set_store_title(title)
	local title = (self.store_affix or '购买 ')..title..'|r'
	japi.EXSetItemDataString(base.string2id(self.type_id), 2,title)
end

--更新商店信息
function mt:set_sell_state()
	--设置物品名
	self:set_name(self.name)
	--设置贴图self:get_art()
	self:set_art(self.art)
	--混合图标处理
	local blend = self.blend or blend_file[self.color or 'nil'] 
	if blend then 
		self.owner = ac.dummy
		if self.level >=1 then 
			self.on_bland = self:add_blend(blend, 'frame', 2)
		else
			self.level = 1
			self.on_bland = self:add_blend(blend, 'frame', 2)
			self.level = 0
		end
		self.owner = nil
	end	
	--设置tip
	self:set_tip(self:get_tip())
	--设置商店出售名 颜色没法呈现
	self:set_store_title(self.store_name)
end



--检查施法条件
function mt:conditions(skills,target)
	--是否在施法范围内
	if not skills:is_in_range(target) then
		return
	end
	local on_target = target
	--无目标
	if not target then
		if skills.target_type ~= skills.TARGET_TYPE_NONE then
			return false
		else
			on_target = skills.owner
		end
	elseif target.type == 'unit' then
		if skills.target_type ~= skills.TARGET_TYPE_UNIT and skills.target_type ~= skills.TARGET_TYPE_UNIT_OR_POINT then
			return false
		end
	elseif target.type == 'point' then
		
		if skills.target_type ~= skills.TARGET_TYPE_POINT and skills.target_type ~= skills.TARGET_TYPE_UNIT_OR_POINT then
			return false
		end
	else
		return false
	end

	skills.target = on_target
	return true
end


	
return item

