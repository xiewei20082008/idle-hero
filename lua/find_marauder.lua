require("smurf")
require("helper")

function find_marauder_main(account_num)
	nLog("start of find marauder main")

	init('0',1)

	while true do
		pressHomeKey()
		mSleep(4000)
		click(1496,956)
		nLog("click done")
		rc = enter_game()
		if rc==false then
			if wifi ==1 then
				wLog("test","关闭wifi")
				setWifiEnable(false)
				wifi = 0
			else
				wLog("test","开启wifi")
				setWifiEnable(true)
				wifi = 1
			end

			goto post_run
		end

		rc = find_marauder_loop(account_num)
		if rc then
			shell_run("echo 1989 > /sdcard/log/aa.txt")
			closeApp("com.droidhang.ad")
			mSleep(4000)
			os.execute("pkill droidhang")
			mSleep(4000)
			return true
		else
			closeApp("com.droidhang.ad")
			mSleep(4000)
			os.execute("pkill droidhang")
			mSleep(4000)
			return false
		end

		::post_run::

		closeApp("com.droidhang.ad")
		mSleep(4000)
		os.execute("pkill droidhang")
		mSleep(60000)
	end
end
