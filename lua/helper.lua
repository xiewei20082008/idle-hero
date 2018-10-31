require "TSLib"
app_name = "com.droidhang.ad"

market_click_pos = {{534,723}, {534,970},{824,723},{824,970},{1087,723},{1087,970},{1380,723},{1380,970}}

function shell_run(cmd)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result
end

function is_network_connected()
	out = shell_run("ping -c 4 -i 0.2 www.baidu.com")
	result = string.find( out,"bytes from" )
	if result == nil then
		return false
	end
	return true
end

function screencap(prefix)
	current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
	file_name = "/sdcard/log/"..prefix..current_time..".png"
	os.execute("screencap -p "..file_name)
	mSleep(4000)
	return file_name
end

function click(x, y)
	touchDown(x, y)
	mSleep(30)
	touchUp(x, y)
end

function move_to_top()
	moveTo(545,300,545,800)
	mSleep(2000)
end

function move_to_left()
	moveTo(545,600,1212,630)
	mSleep(1000)
end

function offline_reconnect()
	if isColor(933,674,0xf6c951,85) and isColor(935,679,0x733b05,85) and isColor(938,684,0xf5c750,85) and isColor(943,685,0x733b05,85) and isColor(946,688,0xf3c54f,85) and isColor(950,691,0x733b05,85) and isColor(953,695,0xecbe4b,85) and isColor(956,697,0x733b05,85) and isColor(959,699,0xe8ba49,85) then
		click(966,696)
		mSleep(1000)
	end
end

function is_mainpage()
	x,y = findMultiColorInRegionFuzzy( 0xeca17c, "12|3|0x7e2f14,13|20|0xdc7a4d,30|6|0x7e2e13,43|24|0xdc7b4e,47|5|0x7d2b12", 90, 1767, 13, 1902, 83)
	if x~=-1 then
		click(x,y)
		mSleep(1500)
	end
	offline_reconnect()
	x,y = findMultiColorInRegionFuzzy( 0xfee281, "2|14|0xa95906,9|-3|0xfee78a,14|11|0xaf5709,33|-2|0xfee98e,34|12|0xa85806", 90, 1767, 13, 1902, 83)
	if x~=-1 then
		return true
	end
	return false
end

function timeout(start_time, gap)
	now_time = os.time()
	diff_time = os.difftime(now_time,start_time)
	pass_minutes = diff_time/60

	if pass_minutes > gap then
		wLog("test", "stop main loop for pass_minutes is "..pass_minutes)
		return true
	end
	return false
end


function get_exp_loot1(loot)
	start_time = os.time()
	move_to_left()
	click(1914,533)
	mSleep(1500)
	while true do

		if timeout(start_time, 1) then
			wLog("test","get exp timeout")
			return false
		end

		x,y = findMultiColorInRegionFuzzy( 0xbfec7c, "2|-3|0xfdfdfe,15|-1|0x49941b,22|1|0x116d22,12|26|0xfabe12,42|4|0x48261e", 90, 953, 22, 1030, 101)
		if x~=-1 then
			click(1691,204)
			nLog("get exp")
			if loot then
				mSleep(2000)
				click(1633,649)
			end
			return true
		end
		mSleep(2000)
	end
end

function get_exp_loot()
	return get_exp_loot1(true)
end

function get_exp()
	return get_exp_loot1(false)
end

function back_mainpage()
	start_time = os.time()
	while is_mainpage()==false do
		if timeout(start_time, 1) then
			wLog("test","back mainpage timeout")
			return false
		end
		os.execute("input keyevent 4")
		mSleep(2000)
	end
	nLog("mainpage")
	return true
end

function mymatch(imgName,patternName,x1,y1,x2,y2)
	output = shell_run("/data/go/match".." "..imgName.." "..patternName.." "..x1.." "..y1.." "..x2.." "..y2)
	print(output)
	for sim, x, y in string.gmatch( output,"(%S+),(%d+),(%d+)" ) do
		sim = tonumber(sim)
		return sim,x,y
	end
	return -1,-1,-1
end

function choose_to_buy(file_name, pattern)
	p = io.popen("/data/go/market "..file_name.." /sdcard/go/"..pattern..".png")
	out = p:read("*all")
	p:close()
	return out
end

function try_click_confirm()
	times = 10
	while(times>0) do
		x,y = findMultiColorInRegionFuzzy( 0x7b4309, "-1|2|0xd7a73f,-1|4|0x773f08,-1|6|0xc49334,8|13|0x753c06,8|15|0xddad42,8|22|0xe4b647,8|24|0x733b05", 90, 1135, 630, 1150, 683)
		if x~=-1 then
			click(1135,630)
		end
		x,y = findMultiColorInRegionFuzzy( 0x733b05, "0|4|0xebbd4a,4|5|0x753d06,8|5|0xf4c850,24|8|0x743c05,26|11|0xe9bb49,26|15|0x733b05,27|27|0xf4c850,28|30|0x773f07", 90, 907, 662, 980, 724)
		if x~=-1 then
			click(949,696)
			break
		end
		times = times - 1
		mSleep(1000)
	end
end


function buy_cycle(s, always_buy)
	for pos, is_coin in string.gmatch(s, "(%d+)%s(%a+)") do
		nLog(pos)
		nLog(is_coin)
		if ((is_coin=="true") or (always_buy==true)) then
			x = market_click_pos[pos+1][1]
			y = market_click_pos[pos+1][2]
			wLog("test", "will click at "..x.."and "..y)
			click(x,y)
			try_click_confirm()
			mSleep(5000)
		end
	end
end

function enter_game()
	start_time = os.time()
	while true do

		if timeout(start_time, 3) then
			wLog("test","run enter game timeout")
			screencap("fail_enter_game")
			return false
		end

		x,y = findMultiColorInRegionFuzzy( 0x7c2203, "22|-2|0x7c2203,10|8|0x7c2203,-1|20|0x7c2203,20|20|0x7c2203", 90, 1481, 157, 1553, 223)
		if x~=-1 then
			nLog("进去先点叉子")
			click(x,y)
		end


		--x,y = findMultiColorInRegionFuzzy( 0xf2f1ed, "25|-15|0xe5e1dc,22|15|0xe3e5e4,59|-19|0x8f5237,56|2|0x874e36", 90, 468, 97, 660, 293)

		if isColor(721,375,0x392f1f,90) and isColor(776,368,0x1d2319,90) and isColor(843,413,0x4c4c28,90) and isColor(922,475,0xe6dcca,90) and isColor(897,659,0x056ab0,90) and isColor(1023,661,0x1c0b00,90) and isColor(1030,573,0xf0cda2,90) then
			nLog("然后进入游戏")
			click(500,500)
		end

		if is_mainpage() then
			return true
		end
		mSleep(2000)
	end
end
