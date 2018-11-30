require "TSLib"
require "helper"
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

	runApp(app_name);
	enter_game()

	while true do

		if isColor(290,983,0xe0dfd9,90) and isColor(291,1001,0xe1dfdb,90) and isColor(317,996,0x0d090b,90) and isColor(324,999,0xe0dfda,90) and isColor(332,999,0x130907,90) and isColor(350,1008,0x2bc6fa,90) then

			nLog("赚钻石")
			click(307,998)
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
			break
		end

		mSleep(2000)
	end
	
	mSleep(2000)
end
