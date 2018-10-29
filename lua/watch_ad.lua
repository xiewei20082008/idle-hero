require "TSLib"
function click(x, y)
	touchDown(x, y)
	mSleep(30)
	touchUp(x, y)
end

initLog("watch_ad", 0);  
wLog("watch_ad","!! Start to run !!");
nLog("Start to run")
init('0',1);
app_name = "com.droidhang.ad"
times=0
while true do

	x,y = findMultiColorInRegionFuzzy( 0x4a5672, "19|15|0x7e7210,15|-14|0xfee2b1,29|-7|0xd9dddc,42|-23|0xc6c1b7,27|-35|0x368d96", 90, 450, 881, 590, 1008)
	if x~=-1 then
		nLog("进游戏")
		click(x,y)
	end

	x,y = findMultiColorInRegionFuzzy( 0x7c2203, "22|-2|0x7c2203,10|8|0x7c2203,-1|20|0x7c2203,20|20|0x7c2203", 90, 1481, 157, 1553, 223)
	if x~=-1 then
		nLog("进去先点叉子")
		click(x,y)
		if times == 5 then
			break
		end
	end

	if isColor(721,375,0x392f1f,90) and isColor(776,368,0x1d2319,90) and isColor(843,413,0x4c4c28,90) and isColor(922,475,0xe6dcca,90) and isColor(897,659,0x056ab0,90) and isColor(1023,661,0x1c0b00,90) and isColor(1030,573,0xf0cda2,90) then
		nLog("然后进入游戏")
		click(500,500)
	end

	x,y = findMultiColorInRegionFuzzy( 0x585756, "16|-11|0x0a090a,13|13|0xdfdfe1,27|3|0x2d1f17,40|2|0xdcd8e2,35|26|0xe6e6e4,41|16|0x0c0c13,73|25|0x189cf9,53|48|0x3fe7fc", 90, 355, 20, 509, 139)
	if x~=-1 then
		nLog("赚钻石")
		click(435,84)
		mSleep(1000)			
	end

	x,y = findMultiColorInRegionFuzzy( 0x814a0d, "0|7|0xddad42,7|6|0xf5c851,14|6|0x7b440a,18|4|0xf5c850,18|13|0x733b05,22|16|0xe9bb49,22|20|0x7b440a,28|25|0xd1a13b", 90, 1090, 665, 1181, 715)
	if x~=-1 then
		nLog("点确定")
		click(x,y)
		mSleep(700)			
		times = times + 1

		os.execute("pkill droidhang")
		mSleep(5000)
		init('0',1);
	end

	mSleep(2000)
end
