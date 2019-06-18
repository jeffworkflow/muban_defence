local multiboard = require 'types.multiboard'

local base_icon = [[ReplaceableTextures\CommandButtons\BTNSelectHeroOn.blp]]
local mtb
local color = {
	['魔鬼的交易'] = {
		['无所不在'] = '|cffff0000',
		['无所不能'] = '|cffff0000',
	},
	['境界突破'] = {
		['小斗气'] = '|cffff0000',
		['斗者'] = '|cffff0000',
	},
	['异火'] = {
		['星星之火'] = '|cffff0000',
		['陨落心炎'] = '|cffff0000',
	},
	['其它'] = {
		['倒霉蛋'] = '|cffff0000',
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
		for key,val in pairs(color[book_skill]) do
			-- print(str,key,val)
			if finds(str,key) then
				str = val..str..'|r'
				break
			end
		end	
	end	
	return str
end


local title =  {'玩家','杀敌数','火灵','魔鬼的交易','境界','异火','其它'}

local function init()

	local online_player_cnt = get_player_count()
	local all_lines = online_player_cnt +3
	mtb = multiboard.create(#title,all_lines)
	ac.game.multiboard = mtb

	mtb:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '')..'】难度：'..(ac.g_game_degree_name or ''))
	-- mtb:setTitle("信息面板")
	--设置表头
    for i = 1,#title do 
        mtb:setText(i,1,title[i])
	end 
	--统一设置宽度
    mtb:setAllWidth(0.05)
	--初始化所有数据
    for i = 2,all_lines do 
		local player = ac.player(i-1)
		if player:is_player() then 
			mtb:setText(1,i,player:get_name())
			mtb:setText(2,i,'0')
			mtb:setText(3,i,'0')
			mtb:setText(4,i,' ')
			mtb:setText(5,i,' ')
			mtb:setText(6,i,' ')
			mtb:setText(7,i,' ')
		end	
    end 
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
	mtb:setText( 2, player.id + 1, player.kill_count)
	mtb:setText( 3, player.id + 1, player.fire_seed)
	--刷新字段
	-- print(get_text(hero,'魔鬼的交易'))
	for i,book_skill in ipairs(title) do 
		local new_str = get_text(hero,book_skill)
		new_str = add_color(new_str,book_skill)
		print(book_skill,new_str)
		if new_str and new_str ~='' then 
			mtb:setText( i, player.id + 1, new_str)
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