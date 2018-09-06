require "helper"
app_name = "com.eg.android.AlipayGphone"
closeApp(app_name)
mSleep(6000)
runApp(app_name)
mSleep(3000)

nLog("start")


function click_hand()
	nLog("find hand")
	x,y = findMultiColorInRegionFuzzy( 0x30bf6c, "11|6|0xffffff,27|13|0xffffff,44|13|0x30bf6c,44|19|0x30bf6c,29|34|0xffffff,26|40|0x30bf6c", 90, 1000, 10, 1080, 2240)
	if x~=-1 then
		click(x,y)
		return true
	end
	return false
end

function stolen()

	while true do
		mSleep(4000)
		current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
		file_name = "/sdcard/log/"..current_time..".png"
		os.execute("screencap -p "..file_name)
		mSleep(2000)
		sim, x, y = mymatch(file_name,"/sdcard/go/stole.png",10, 347, 1067, 1014)
		if sim<=0.06 then
			nLog("stole click at "..x..","..y)
			wLog("test","stole click at "..x..","..y)
			click(x,y)
		else
			os.execute("input keyevent 4")
			break
		end

		mSleep(4000)

	end
end

function init_log()
	initLog("test", 0);  
	wLog("test","!! Start to run !!");
	nLog("Start to run")
end

init_log()

start_time = os.time()
while true do
	if timeout(start_time, 10) then
		break
	end

--	current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
--	file_name = "/sdcard/log/"..current_time..".png"

--	os.execute("screencap -p "..file_name)
--	mSleep(2000)
--	点蚂蚁森林
	if isColor(657,833,0x29ab91,85) and isColor(656,840,0xffffff,85) and isColor(654,852,0x2aab91,85) and isColor(659,854,0xffffff,85) and isColor(665,869,0x29ab91,85) and isColor(665,881,0xffffff,85) and isColor(665,891,0x2aac92,85) and isColor(670,891,0xffffff,85) and isColor(676,891,0x29ab91,85) then
		nLog("点蚂蚁森林")
		click(680,870)
		mSleep(2000)
	end

	if isColor(56,1259,0xfbfbfb,85) and isColor(56,1261,0x4c4c4c,85) and isColor(56,1264,0xffffff,85) and isColor(56,1273,0x4c4c4c,85) and isColor(56,1281,0xffffff,85) and isColor(71,1279,0x4c4c4c,85) and isColor(94,1276,0xfbfbfb,85) and isColor(103,1276,0x4c4c4c,85) and isColor(108,1275,0xffffff,85) and isColor(119,1275,0x4c4c4c,85) then
		nLog("最新动态向下滑")
		moveTo(545,900,545,100)
		mSleep(1000)
		moveTo(545,900,545,100)
		mSleep(1000)
		moveTo(545,900,545,100)
		mSleep(1000)
		click(540,1700)
		mSleep(4000)
	end

	if isColor(131,158,0xffffff,85) and isColor(134,158,0x111111,85) and isColor(136,158,0x828282,85) and isColor(134,163,0x111111,85) and isColor(136,169,0xffffff,85) and isColor(138,173,0x111111,85) and isColor(141,174,0xffffff,85) and isColor(155,170,0x111111,85) and isColor(160,173,0xffffff,85) and isColor(194,182,0x111111,85) then
		nLog("好友排行榜")
		if click_hand() then
			mSleep(2000)
		else
			moveTo(545,900,545,100)
			mSleep(2000)
		end
	end

	if isColor(478,1268,0xffffff,85) and isColor(478,1273,0x31bf6d,85) and isColor(479,1278,0xfefffe,85) and isColor(479,1282,0x37c170,85) and isColor(479,1286,0xf7fdf9,85) and isColor(479,1290,0x31bf6d,85) and isColor(493,1293,0xfefffe,85) and isColor(498,1293,0x31bf6d,85) and isColor(503,1292,0xfefffe,85) and isColor(504,1303,0x3bc374,85) then
		nLog("开始偷能量")
		stolen()
		mSleep(2000)
	end
	if isColor(459,2148,0x333333,85) and isColor(471,2151,0xffffff,85) and isColor(498,2148,0x333333,85) and isColor(509,2157,0xffffff,85) and isColor(533,2157,0x333333,85) and isColor(556,2157,0xffffff,85) and isColor(578,2155,0x333333,85) and isColor(597,2155,0xffffff,85) and isColor(612,2155,0x333333,85) then
		break
	end
end