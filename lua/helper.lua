require "TSLib"
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

function move_to_top()
	moveTo(545,300,545,800)
	mSleep(2000)
end

function move_to_left()
	moveTo(545,600,1212,630)
	mSleep(2000)
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



function get_exp()
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
			return true
		end
		mSleep(2000)
	end
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
