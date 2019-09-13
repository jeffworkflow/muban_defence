local multiboard = require 'types.multiboard'

local base_icon = [[ReplaceableTextures\CommandButtons\BTNSelectHeroOn.blp]]
local mtb
local color = {
	['魔鬼的交易'] = {
		['无所不在'] = '|cffffffff',
		['无所不知'] = '|cffffffff',
		['无所不为'] = '|cff00ffff',
		['无所不贪'] = '|cff00ffff',
		['无所不能'] = '|cffffff00',
		['脚踩祥云'] = '|cffffff00',
		['身披圣衣'] = '|cffff0000',
		['头顶乾坤'] = '|cffff0000',
	},
	['境界突破'] = {
		['小斗气'] = '|cff00ff00',
		['斗者'] = '|cff00ff00',
		['斗师'] = '|cff00ffff',
		['斗灵'] = '|cff00ffff',
		['斗王'] = '|cffffff00',
		['斗皇'] = '|cffffff00',
		['斗宗'] = '|cffff0000',
		['斗尊'] = '|cffff0000',
		['斗圣'] = '|cffdf19d0',
		['斗帝'] = '|cffdf19d0',
		['斗神'] = '|cffdf19d0',
	},
	['异火'] = {
		['星星之火'] = '|cff00ffff',
		['陨落心炎'] = '|cffffff00',
		['三千焱炎火'] = '|cffffe799',
		['虚无吞炎'] = '|cffff0000',
		['陀舍古帝'] = '|cffdf19d0',
		['无尽火域'] = '|cffdf19d0',
	},
	['其它'] = {
		['倒霉蛋'] = '|cff00ffff',
		['游戏王'] = '|cffff0000',
	},
}
--深度优先算法
local function get_text(hero,book_skill)
	local str = ''
	local skl = hero:find_skill(book_skill,nil,true)
	if not skl or  #skl.skill_book ==0 then return str end 
	for i=#skl.skill_book,1,-1 do
		local skill = skl.skill_book[i]
		if skill.level>=1 then 
			if skill.is_spellbook then
				--深度优先，没有判断 则每次递归都有值返回，而我们是要找到符合条件的才返回，所以加判断。
				if get_text(hero,skill.name) then 
					return get_text(hero,skill.name) 
				end	
			else
				-- print(skill.name)
				str = skill.name
				return str
			end	
		end	
	end
end	
local function add_color(str,book_skill)
	local str = str or ''
	--处理颜色代码
	if color[book_skill] then  
		for key,val in sortpairs(color[book_skill]) do
			-- print(str,key,val)
			if finds(str,key) then
				str = val..str..'|r'
				break
			end
		end	
	end	
	return str
end


local title =  {'玩家','|cff00ff00杀敌数|r','|cff00ffff火灵|r','|cff00ff00魔鬼的交易|r','|cff00ffff境界|r','|cffffff00异火|r','|cffff0000其它|r'}

local function init()

	local online_player_cnt = get_player_count()
	local all_lines = online_player_cnt +3
	mtb = multiboard.create(#title,all_lines)
	ac.game.multiboard = mtb
	mtb:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '赤灵传说')..'】难度：'..(ac.g_game_degree_name or ''))
	
	function mtb:set_time(time)
		local str = '【'..(ac.server_config and ac.server_config['map_name'] or '赤灵传说')..'】难度：'..(ac.g_game_degree_name or '')
		mtb:setTitle(' '..str..'     【游戏时长】'..time)
	end	
	-- mtb:setTitle("信息面板")
	--设置表头
    for i = 1,#title do 
        mtb:setText(i,1,title[i])
	end 
	--统一设置宽度
	mtb:setAllWidth(0.05)
    -- mtb:setWidth(2,1,0.03)
	--调整局部宽度 第x列
    mtb:setXwidth(2,0.03)
    mtb:setXwidth(3,0.03)
    mtb:setXwidth(5,0.03)
	mtb:setXwidth(7,0.03)
	local ix = 2
	--初始化所有数据
    for i = 1,10 do 
		local player = ac.player(i)
		if player:is_player() then 
			mtb:setText(1,ix,player:getColorWord()..player:get_name()..'|r')
			mtb:setText(2,ix,'0')
			mtb:setText(3,ix,'0')
			mtb:setText(4,ix,' ')
			mtb:setText(5,ix,' ')
			mtb:setText(6,ix,' ')
			mtb:setText(7,ix,' ')
			player.ix = ix
			ix = ix + 1 --位置第几行
		end	
	end 
	
	mtb:setWidth(1,ix+1,0.1)
	-- function mtb:set_auto_tip()
	-- 	mtb:setText(1,ix+1,'|cffff0000F6查看无尽排行榜|r')
	-- end	
	-- mtb:setText(1,ix+1,'|cffff0000F6|r查看无尽排行榜')
	
	--初始化格式
	mtb:setAllStyle(true,false)
	mtb:show()
	
end

--具体函数
local function player_init(player,hero)
	mtb:setText( 1, player.id + 1, player:get_name())
	mtb:setIcon( 1, player.id + 1, hero:get_slk('Art',base_icon))
end

local function fresh(player,hero)
	-- print(1111111111)
	--刷新杀敌数
	mtb:setText( 2, player.ix, bignum2string(player.kill_count))
	mtb:setText( 3, player.ix, bignum2string(player.fire_seed))
	--刷新字段
	-- print(get_text(hero,'魔鬼的交易'))
	for i,book_skill in ipairs(title) do 
		--去颜色
		local book_skill = clean_color(book_skill)
		local new_str 
		if book_skill == '其它' then 
			new_str = player.is_show_nickname
		elseif book_skill == '境界' then
			book_skill = '境界突破'
			new_str = get_text(hero,book_skill)
		else	
			new_str = get_text(hero,book_skill)
		end	 
		new_str = add_color(new_str,book_skill)
		-- print(book_skill,new_str)
		if new_str and new_str ~='' then 
			mtb:setText( i, player.ix, new_str)
		end	
	end	
end	

ac.loop(1000,function()
	for i=1,10 do 
		local player = ac.player(i)
		local hero = player.hero
		if player:is_player() and hero then 
			fresh(player,hero)
		end	
	end	
end)

ac.game:event '游戏-开始' (function()
	--游戏开始时，重新更改标题
	mtb:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '')..'】难度：'..(ac.g_game_degree_name or ''))
end)

ac.wait(0,function()
	init()
end)