require("helper")


account_num = 1989

function get_username()
	if account_num == 1989 then
		account_num = account_num + 1
		return "xiewei.fire@gmail.com"
	end
	return "tianshi"..account_num.."@163.com"
end

function get_username1()
	return "xiewei.fire@gmail.com"
end

function get_password()
	return "123456qw"
end

function change_account()
	while true do
		if is_mainpage() then
			-- click at settings
			click(1842,638)
			mSleep(1000)
			-- click at change account
			click(1388,724)
			mSleep(1000)
			switchTSInputMethod(true)
			-- click at user name
			click(709,438)
			mSleep(500)
			inputText(get_username())
			mSleep(800)
			-- click at password
			click(679,585)
			mSleep(500)
			inputText(get_password())
			mSleep(800)
			-- click at login
			click(1130,746)
			mSleep(200)
			switchTSInputMethod(false)
			break
		end
		mSleep(2000)
	end
end

function add_me_as_friend()
	--	点放大镜
	click(1600,484)
	mSleep(2000)
	switchTSInputMethod(true)
	--	点输入框
	click(565,259)
	mSleep(500)
	inputText("31648178")
	mSleep(800)
	switchTSInputMethod(false)
	click(1271,265)
	mSleep(800)
end

function find_marauder()

	-- click friend icon
	click(64,668)
	mSleep(2000)
	-- click friend tab
	click(1596,833)
	mSleep(4000)

	x,y = findMultiColorInRegionFuzzy( 0xaaaaaa, "2|0|0x4d4d4d,6|8|0xc1c1c1,9|8|0x474747,19|17|0xb9b9b9,22|17|0x474747,45|13|0x9b9b9b,45|15|0x464646", 90, 920, 857, 1009, 898)
	if x~=-1 then
		return
	end

	x,y = findMultiColorInRegionFuzzy( 0xf6c951, "5|2|0x763e07,7|5|0xefc34d,9|12|0x733b05,4|17|0xf6c951,13|13|0xf6c951,21|6|0x743d06,49|9|0xf6c951,45|17|0x753c06", 90, 890, 860, 971, 898)
	if x~=-1 then
		add_me_as_friend()
		return
	end
	-- click search
	click(970,872)

	-- if find 确定
	-- screencap
	-- break

	mSleep(5000)
	os.execute("input keyevent 4")
	mSleep(2000)
	x,y = findMultiColorInRegionFuzzy( 0xf6c951, "5|2|0x763e07,7|5|0xefc34d,9|12|0x733b05,4|17|0xf6c951,13|13|0xf6c951,21|6|0x743d06,49|9|0xf6c951,45|17|0x753c06", 90, 890, 860, 971, 898)
	if x~=-1 then
		add_me_as_friend()
	end

end

function main()
	while true do
		change_account()
		while true do
			if is_mainpage() then
				break
			end
			mSleep(2000)
		end
		get_exp()
		back_mainpage()
		find_marauder()
		back_mainpage()
		if account_num== 2026 then
			break
		end
		account_num = account_num + 1

	end
end

init(app_name,1);
main()