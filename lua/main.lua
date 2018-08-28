require "TSLib"
require "helper"
--ver8.9
market_click_pos = {{534,723}, {534,970},{824,723},{824,970},{1087,723},{1087,970},{1380,723},{1380,970}}



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

function init_log()
	initLog("test", 0);  
	wLog("test","!! Start to run !!");
	nLog("Start to run")
end





function enter_game()
	start_time = os.time()
	while true do

		if timeout(start_time, 3) then
			wLog("test","run store timeout")
			return false
		end

		x,y = findMultiColorInRegionFuzzy( 0x7c2203, "22|-2|0x7c2203,10|8|0x7c2203,-1|20|0x7c2203,20|20|0x7c2203", 90, 1481, 157, 1553, 223)
		if x~=-1 then
			nLog("进去先点叉子")
			click(x,y)
		end

		x,y = findMultiColorInRegionFuzzy( 0xf2f1ed, "25|-15|0xe5e1dc,22|15|0xe3e5e4,59|-19|0x8f5237,56|2|0x874e36", 90, 468, 97, 660, 293)
		if x~=-1 then
			nLog("然后进入游戏")
			click(x,y)
		end

		if is_mainpage() then
			return true
		end
		mSleep(2000)
	end
end





function run_store()
	start_time = os.time()
	while true do
		if timeout(start_time, 3) then
			wLog("test","run store timeout")
			return false
		end

		x1,y1 = findMultiColorInRegionFuzzy( 0x1783f8, "-3|15|0x18f8fc,7|26|0x13d8f8,33|8|0x48261e,34|21|0x48261e", 90, 949, 10, 1057, 93)
		x2,y2 = findMultiColorInRegionFuzzy( 0xfee688, "-10|15|0xfdd86b,-3|42|0xbd7212,32|19|0xfcd564,50|48|0xa75a06", 90, 6, 14, 120, 91)
		if x1~=-1 and x2==-1 then
			wLog("test","主界面要左移");
			moveTo(545,600,1212,630)
			mSleep(1000)
			click(723,910)
		elseif x1~=-1 and x2~=-1 then

			wLog("test","尝试购买")
			current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
			file_name = "/sdcard/log/"..current_time..".png"
			wLog("test","init pic"..file_name)
			os.execute("screencap -p "..file_name)
			mSleep(8000)
			nLog("after screen shot")
			out = choose_to_buy(file_name, "arena")
			wLog("test", "arena out is "..out)
			buy_cycle(out, true)
			out = choose_to_buy(file_name, "casino")
			wLog("test", "casino out is "..out)
			buy_cycle(out, true)
			out = choose_to_buy(file_name, "hero")
			wLog("test", "hero out is "..out)
			buy_cycle(out, false)
			out = choose_to_buy(file_name, "task")
			wLog("test", "task out is "..out)
			buy_cycle(out, false)


			out = choose_to_buy(file_name, "dust")
			wLog("test", "dust out is "..out)
			buy_cycle(out, false)
			out = choose_to_buy(file_name, "tree")
			wLog("test", "tree out is "..out)
			buy_cycle(out, true)

			out = choose_to_buy(file_name, "vip_casino")
			wLog("test", "vip_casino out is "..out)
			buy_cycle(out, true)
			out = choose_to_buy(file_name, "orb")
			wLog("test", "orb out is "..out)
			buy_cycle(out, true)

			wLog("test","判断是否可以刷新or购买");

			x,y = findMultiColorInRegionFuzzy( 0x92df19, "15|3|0x90de19,89|5|0x206b01,103|9|0x1d6700,105|23|0x1e6700,102|22|0x6cb912,133|1|0x206a01,139|9|0x86d518,150|14|0x1d6700", 90, 1300, 348, 1612, 454)
			if x~=-1 then
				wLog("test","可以刷新");
				click(1454, 403)
				mSleep(3000)
			end

			current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
			file_name = "/sdcard/log/"..current_time..".png"
			wLog("test","after decision pic"..file_name)
			os.execute("screencap -p "..file_name)

			break
		end

		mSleep(2000)
	end
	return true
end

function restartApp()
	closeApp("com.droidhang.ad")
	mSleep(5000)
	runApp(app_name);
	init(app_name,1);
end

function guild_boss()
--	点击公会
	click(1336,992)
	mSleep(4000)
--	点击领地
	click(466,940)
	mSleep(4000)
--	点击副本
	click(950,331)
	mSleep(4000)
	x,y = findMultiColorInRegionFuzzy( 0xfdfbf9, "-14|1|0x6b73ae,-18|22|0x38407a,-33|28|0xf9dc10,26|28|0xf9dc10,21|-10|0xaeb2d1", 90, 313, 239, 1594, 890)
	if x~=-1 then
--		点击选BOSS的匕首
		click(x,y)
		mSleep(4000)
	else
		return false
	end

	x,y = findMultiColorInRegionFuzzy( 0xf17032, "4|4|0x62352a,10|17|0x62352a,17|12|0xf27333,21|-1|0x61342a,33|6|0xf27233,46|14|0x61342a", 90, 417, 840, 542, 913)
	if x~=-1 then
--		点击战斗文字
		click(x,y)
		mSleep(4000)
--		点击匕首开始打
		click(1500,440)
		mSleep(4000)
	else
		return true
	end

	x,y = findMultiColorInRegionFuzzy( 0x85513a, "8|-1|0xffea91,8|25|0xfbc546,27|25|0x85513a,35|22|0xfbc84a,43|0|0xffeb93,51|0|0x85513a", 90, 1794, 10, 1898, 82)
	if x~=-1 then
--		点击跳过图标
		click(x,y)
		mSleep(3000)
--		点击确定
		click(1130,700)
		mSleep(3000)
	else
		return false
	end
	return true
end

function get_mill_request()
--	点击公会
	click(1336,992)
	mSleep(4000)
--	点击领地
	click(466,940)
	mSleep(4000)
	--	点击磨坊
	click(403,404)
	mSleep(4000)
	for i = 10,1,-1 
	do
		click(1378,260)
		mSleep(200)
		click(964,766)
		mSleep(200)
		click(960,940)
		mSleep(200)
	end
	x,y = findMultiColorInRegionFuzzy( 0xa66f54, "4|0|0xe6cfad,9|4|0xd8be9d,11|4|0xa47054,6|17|0xe6d0ae,9|20|0x9d664a,49|9|0xd8bf9f,52|8|0x744d35", 90, 909, 75, 1014, 129)
	if x~=-1 then
		click(1378,260)
		return true
	end
	return false
end

function open_a_box()
	points = findMultiColorInRegionFuzzyExt(0x9e4833,"23|-21|0x5a1d2e,10|1|0xe17d1f", 100, 0, 0, 1920, 1080,  { main = 0x050505, list = 0x050505 } )
	if #points~=0 then
		nLog("click "..points[1].x..","..points[2].y)
		click(points[1].x,points[1].y)
		mSleep(8000)
		os.execute("input keyevent 4")
		mSleep(4000)
		return true
	else
		return false
	end

end

function open_box()
	
	nLog("start to open box")
	move_to_left()

--	点悬空岛
	click(1340,240)
	mSleep(4000)
--	点飞艇
	click(560,820)
	mSleep(6000)
	start_time = os.time()
	while true do
		if timeout(start_time, 2) then
			wLog("test","run store timeout")
			return false
		end
		rc = open_a_box()
		if rc==false then
			break
		end
		mSleep(2000)
	end
	
	move_to_top()
	start_time = os.time()
	while true do
		if timeout(start_time, 2) then
			wLog("test","run store timeout")
			return false
		end
		rc = open_a_box()
		if rc==false then
			break
		end
		mSleep(2000)
	end
	return true
end

function search_treasure()
	-- click friend icon
	click(64,668)
	mSleep(2000)
	-- click friend tab
	click(1596,833)
	mSleep(2000)

	-- click search
	click(970,872)
	mSleep(1000)

	return true
end

init_log()

while true do
	runApp(app_name);
	init(app_name,1);
	

	


	rc = enter_game()
	if rc==false then
		goto post_run
	end



	rc = run_store()
	if rc==false then
		goto post_run
	end
	rc = back_mainpage()
	if rc==false then
		goto post_run
	end

	rc = get_mill_request()
	if rc==false then
		goto post_run
	end
	rc = back_mainpage()
	if rc==false then
		goto post_run
	end

	rc = get_exp()
	if rc==false then
		goto post_run
	end
	rc = back_mainpage()
	if rc==false then
		goto post_run
	end

	rc = search_treasure()
	if rc==false then
		goto post_run
	end
	rc = back_mainpage()
	if rc==false then
		goto post_run
	end

	rc = guild_boss()
	if rc==false then
		goto post_run
	end
	rc = back_mainpage()
	if rc==false then
		goto post_run
	end
	
	rc = open_box()
	if rc==false then
		goto post_run
	end

	break
	::post_run::

	closeApp("com.droidhang.ad")
	mSleep(10000)
end

closeApp("com.droidhang.ad")
closeLog("test"); 
lockDevice(); 
lua_exit();

--init(app_name,1);

--back_mainpage()
