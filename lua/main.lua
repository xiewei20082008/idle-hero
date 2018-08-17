require "TSLib"
--ver8.9
market_click_pos = {{534,723}, {534,970},{824,723},{824,970},{1087,723},{1087,970},{1380,723},{1380,970}}
app_name = "com.droidhang.ad"

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

function click(x, y)
	touchDown(x, y)
	mSleep(30)
	touchUp(x, y)
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

function init_log()
	initLog("test", 0);  
	wLog("test","!! Start to run !!");
	nLog("Start to run")
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

function is_mainpage()
	x,y = findMultiColorInRegionFuzzy( 0xeca17c, "12|3|0x7e2f14,13|20|0xdc7a4d,30|6|0x7e2e13,43|24|0xdc7b4e,47|5|0x7d2b12", 90, 1767, 13, 1902, 83)
	if x~=-1 then
		click(x,y)
		mSleep(1500)
	end
	x,y = findMultiColorInRegionFuzzy( 0xfee281, "2|14|0xa95906,9|-3|0xfee78a,14|11|0xaf5709,33|-2|0xfee98e,34|12|0xa85806", 90, 1767, 13, 1902, 83)
	if x~=-1 then
		return true
	end
	return false
end


function back_mainpage()
	start_time = os.time()
	while is_mainpage()==false do
		if timeout(start_time, 1) then
			wLog("test","back mainpage timeout")
			return false
		end
		os.execute("input keyevent 4")
		mSleep(3000)
	end
	nLog("mainpage")
	return true
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

function move_to_left()
	moveTo(545,600,1212,630)
	mSleep(2000)
end

function get_exp()
	start_time = os.time()
	while true do

		if timeout(start_time, 1) then
			wLog("test","get exp timeout")
			return false
		end
		move_to_left()
		click(1914,533)

		x,y = findMultiColorInRegionFuzzy( 0xbfec7c, "2|-3|0xfdfdfe,15|-1|0x49941b,22|1|0x116d22,12|26|0xfabe12,42|4|0x48261e", 90, 953, 22, 1030, 101)
		if x~=-1 then
			click(1691,204)
			mSleep(2000)
			nLog("get exp")
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
			out = choose_to_buy(file_name, "scroll")
			wLog("test", "scroll out is "..out)
			buy_cycle(out, false)
			out = choose_to_buy(file_name, "dust")
			wLog("test", "dust out is "..out)
			buy_cycle(out, false)
			out = choose_to_buy(file_name, "tree")
			wLog("test", "tree out is "..out)
			buy_cycle(out, true)

			wLog("test","判断是否可以刷新or购买");

			x,y = findMultiColorInRegionFuzzy( 0x92df19, "15|3|0x90de19,89|5|0x206b01,103|9|0x1d6700,105|23|0x1e6700,102|22|0x6cb912,133|1|0x206a01,139|9|0x86d518,150|14|0x1d6700", 90, 1300, 348, 1612, 454)
			if x~=-1 then
				wLog("test","可以刷新");
				click(1454, 403)
				mSleep(3000)
				current_time = os.date("%m-%d-%H-%M-%S", os.time()); --以时间戳命名进行截图
				file_name = "/sdcard/log/"..current_time..".png"
				wLog("test","after decision pic"..file_name)
				os.execute("screencap -p "..file_name)
			end

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




init_log()

while true do
	runApp(app_name);
	init(app_name,1);

	rc = enter_game()
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

	rc = run_store()
	if rc==false then
		goto post_run
	end

	break
	::post_run::
	mSleep(10000)
	closeApp("com.droidhang.ad")
end

closeApp("com.droidhang.ad")
closeLog("test"); 
lockDevice(); 
lua_exit();

--init(app_name,1);

--back_mainpage()
