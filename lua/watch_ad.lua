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

	x,y = findMultiColorInRegionFuzzy( 0x8c331e, "15|2|0x596789,24|14|0x348992,30|26|0xfdbc08,55|22|0xd7d9d5,38|54|0x33868e,48|78|0xeda803,85|45|0xb8b998", 90, 466, 863, 634, 1022)
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

	x,y = findMultiColorInRegionFuzzy( 0xf2f1ed, "25|-15|0xe5e1dc,22|15|0xe3e5e4,59|-19|0x8f5237,56|2|0x874e36", 90, 468, 97, 660, 293)
	if x~=-1 then
		nLog("然后进入游戏")
		click(x,y)		
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
