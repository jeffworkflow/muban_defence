local jass = require 'jass.common'
local unit = require 'types.unit'

local shop = {}
local mt = {}
ac.shop = shop
-- setmetatable(shop, shop)
shop.__index = mt
setmetatable(mt, unit)

--保存商店NPC
shop.unit_list = {}

--类型
mt.unit_type = 'shop'

--页面记录
mt.page_stack = nil

--文字显示
local function on_texttag(string,hero,zoffset,xoffset,yoffset)
	local target = hero
	local x, y,z = target:get_point():get()
	-- local z = target:get_point():getZ()
	local tag = ac.texttag
	{
		string = string,
		size = 14,
		position = target:get_point(),
		xoffset = tonumber(xoffset) or -100,
		yoffset = tonumber(yoffset) or 0,
		zoffset = tonumber(zoffset) or 200,
		red = 238,
		green = 31,
		blue = 39,
		permanent = true,
		target = target 
	}
	return tag
end
ac.nick_name = on_texttag
--创建一个商店
function shop.create(name,x,y,face,is_selling,player)
	local player = player or ac.player[11]
	local unit = player:create_unit(name,ac.point(x,y),face)
	--继承商店
	setmetatable(unit, shop)

	unit:add_restriction '无敌'
	unit:add_restriction '缴械'
	
	if not unit.sell then 
		unit.sell = {}
	end	
	if not unit.sell_new_gold then 
		unit.sell_new_gold = {}
	end	
	local data = ac.table.UnitData[name]
	if not is_selling then 
		local sell = data.sell
		unit.sell = sell
		if sell then 
			for i,v in ipairs(sell) do
				unit:add_sell_item(v,i)
			end
		end	
	end	
	--创建文字
	-- unit.texttag = on_texttag(name,unit)
	--加头上模型
	if data.head_effect then 
		unit:add_effect('overhead',data.head_effect)
	end  

	shop.unit_list[unit.handle] = unit

	return unit
end

--移除时的处理
function mt:on_remove()
	--全部删除
	self:remove_all()
	--移除文字显示
	if self.texttag then 
		self.texttag:remove()
	end	
	--移除各种引用
	shop.unit_list[self.handle] = nil

end	
--打印商品
function mt:print_item()
	local str =""
	if not next(self.sell_item_list)  then 
		return
	end
	
	for i =1,12 do
		if self.sell_item_list[i] then
			str = str..i..self.sell_item_list[i].name..self.sell_item_list[i].type_id..','
		end	
	end	
	print(str)	
end	
--添加商品
function mt:add_sell_item(name,i)
	local data = ac.table.ItemData[name]
	if not data then
		data = ac.skill[name]
		if not data.is_skill then
			-- print('商店添加物品失败,不存在数据',name)
			return
		end
	end

	local item = ac.item.create(name,i,seller)
	if not item then 
		return 
	end
	item.shop_slot_id = i
	-- print('设置seller',self:get_name())
	-- item:set_store_title('                   '..self:get_name())
	item:set_store_title(item.store_name)
	--每秒刷新商店介绍
	--选择英雄时，如果是重复用同一套 ability，技能描述会再被刷新为最后一次添加的描述
	--改为 刷新 当前选择的单位的tip
	-- if item.auto_fresh_tip then
	-- 	ac.loop(1000, function(t)
	-- 		if item.removed then
	-- 			t:remove()
	-- 			return
	-- 		end
	-- 		--设置tip
	-- 		item:set_tip(item:get_tip())
	-- 	end)
	-- end
	if not self.sell_item_list then 
		self.sell_item_list = {}
	end	
	if not self.sell then 
		self.sell = {}
	end	
	if item then 
		self.sell_item_list[i] = item
		self.sell[i] = item.name
	end	
	--添加到商店
	-- print(item.name,item.type_id)
	--handle,id,当前数量，最大数量
	jass.AddItemToStock(self.handle,base.string2id(item.type_id),item.shop_count,item.shop_max_count)
	item:hide()
	--删掉物品
	-- jass.RemoveItem(item.handle)
	-- print(item.handle)
	return item
end

--寻找物品 --一个物品只能被添加到一个单位身上
--可根据物品名称，或是物品品质返回物品。
function mt:find_sell_item(it)
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
	for i=1,12 do
		local items = self.sell_item_list[i]
		if items and (items.name == it_name or items.color == it_name)then
			item = items
			break
		end
	end
	return item
	-- it_name = clean_color(it_name)
	-- local item = ac.item.shop_item_map[it_name]
end

--移除商品
--一个商店只支持一个物品模板，如果已经添加过，图标刷新不了
--删除这个商品时，会莫名的删掉另外一些商品
--测试得出，一个物品模板已经被添加到商店后，从商店删除（模板已回收），
--再添加时， 另一个商店的icon不会变
function mt:remove_sell_item(it)
	local item = self:find_sell_item(it)
	if not item  then 
		return
	end	
	local shop_slot_id = item.shop_slot_id
	-- --回收
	ac.item.shop_item_map[item.name] = nil
	ac.shop_item_list[item.type_id] = false --true回收模板
	self.sell_item_list[shop_slot_id] = nil
	self.sell[shop_slot_id] = nil
	
	-- print('从商店移除',item.type_id,item.name,item.shop_slot_id)
	--从商店移除
	jass.RemoveItemFromStock(self.handle,base.string2id(item.type_id))
	jass.RemoveItem(item.handle)

end
--移除全部商品
--无用
function mt:remove_all()
	for i =1,12 do
		if self.sell_item_list and self.sell_item_list[i] then
			self:remove_sell_item(self.sell_item_list[i].name)
		end	
	end	
end
function mt:fresh_sell()
	for i =1,12 do
		if self.sell_item_list and self.sell_item_list[i] then
			self.sell[i] = self.sell_item_list[i].name
		end	
	end	
end	
--刷新一次商店（删除商店再创建商店）
--sell 即将刷新的清单， sell_item_list 现在拥有的清单，执行添加会刷新sell清单。
--是否继承价格 默认都是不继承价格的
function mt:fresh()

	local sell = self.sell
	local data = {}
	data.sell = {}
	data.sell_item_list = {}
	data.sell_new_gold = {}
	for i=1,12 do 
		data.sell[i] = sell[i]
		data.sell_item_list[i] = self.sell_item_list[i]
		data.sell_new_gold[i] = self.sell_new_gold[i]
	end	

	--全部删除
	self:remove_all()

	--再添加一次
	--也要继承玩家价
	for i=1,12 do 
		if data.sell[i] then 
			local new_shop_item = self:add_sell_item(data.sell[i] ,i)
			--新物品继承属性
			if new_shop_item and not data.sell_new_gold[i]  then 
				if data.sell_item_list[i] and data.sell_item_list[i].gold then 
					local it = data.sell_item_list[i]
					new_shop_item.player_gold = it.player_gold
					local gold 
					if it.player_gold then 
						gold = it.player_gold[ac.player.self] 
					end	
					new_shop_item.gold = gold or it.gold
					--刷新数据
					new_shop_item:set_sell_state()
					--设置回原来的价格
					new_shop_item.gold = it.gold
				end	
			end	
		end	
	end	
end	
--注册魔兽事件

local j_trg = war3.CreateTrigger(function()
	--贩卖者
	local seller = shop.unit_list[jass.GetSellingUnit()]
	--购买者
	local u = ac.unit.j_unit(jass.GetBuyingUnit())
	-- 被购买的物品名，没办法保存物品handle，因为物品添加给商店时就被删除了
	-- 添加颜色代码会导致物品没有在商店里面创建。
	local it_name = jass.GetItemName(jass.GetSoldItem())
	-- 如果英雄在两个商店的中间，购买一次物品会触发两次购买事件。
	if not it_name then 
		return
	end	
	it_name = clean_color(it_name)
	local it = ac.item.shop_item_map[it_name]

	--删掉物品排泄(神符类物品需要删除)
	jass.RemoveItem(jass.GetSoldItem())

	if not u or not seller or not it then
		return
	end

	u:event_notify('单位-点击商店物品',seller,u,it)
end)

for i = 1, 13 do
	jass.TriggerRegisterPlayerUnitEvent(j_trg, ac.player[i].handle, jass.EVENT_PLAYER_UNIT_SELL_ITEM, nil)
end




--native RemoveItemFromStock takes unit whichUnit, integer itemId returns nothing


--需要以下事件

-- ac.game:event '单位-拾取物品'(function(_,u,item)
	
-- end)

-- ac.game:event '单位-移动物品'(function(_,u,item,source_slotid,target_slotid)
	
-- end)

-- ac.game:event '单位-给与物品'(function(_,u,item,target)
	
-- end)

-- ac.game:event '单位-点击商店物品'(function(_,shop,u,item)
	
-- end)
         
-- ac.game:event '单位-切换背包'(function(_,u,page)
	
-- end)

-- ac.game:event '单位-丢弃物品'(function(_,u,item)
	
-- end)

return shop