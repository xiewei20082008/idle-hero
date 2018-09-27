require("helper")


account_num = 1990
now_friend=0
need_friend = 5

function get_username()
	if account_num == 1989 then
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
			mSleep(1500)
			inputText(get_username())
			mSleep(800)
			-- click at password
			click(679,585)
			mSleep(1500)
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
	if now_friend == need_friend then
		return
	end
	now_friend = now_friend + 1
	--	点放大镜
	click(1600,484)
	mSleep(2000)
	switchTSInputMethod(true)
	--	点输入框
	click(565,259)
	mSleep(1500)
	inputText("31648178")
	mSleep(800)
	click(1271,265)



	click(565,259)
	mSleep(1500)
	for var = 1,12 do
		inputText("\b")       --删除输入框中的文字（假设输入框中已存在文字）
	end
	inputText("16216808")
	mSleep(800)
	click(1271,265)

	switchTSInputMethod(false)
	mSleep(800)
end

function stay_auto_battle()
	if isColor(929,916,0x733b05,85) and isColor(940,918,0xf6c951,85) and isColor(940,923,0x733b05,85) and isColor(940,927,0xf6c951,85) and isColor(947,927,0x743c05,85) and isColor(958,927,0xf6c951,85) and isColor(971,927,0x733b05,85) and isColor(988,927,0xf6c951,85) and isColor(993,927,0x763f07,85) then
		click(958,919)
		return true
	end
	return false
end

function select_hero()
	if not isColor(1278,447,0x5c3929,95) then
		click(1500,437)
		return
	end
	if isColor(880,101,0xe5cfad,85) and isColor(889,106,0x7d5940,85) and isColor(889,111,0xe6d0ae,85) and isColor(898,118,0x633722,85) and isColor(911,131,0x9b6045,85) and isColor(924,130,0xe6d0ae,85) and isColor(934,121,0x9c6247,85) and isColor(937,109,0xe6d0ae,85) then
		--英雄出战
		click(180,950)
		mSleep(700)
		click(340,950)
		mSleep(700)
		click(517,950)
		mSleep(700)
		click(690,950)
		mSleep(700)
		click(847,950)
		mSleep(700)
		click(1021,950)
		mSleep(700)

		click(1500,437)
		return
	end
end

function speedx2()
	if isColor(1793,42,0xffcf67,85) and isColor(1799,42,0xffd069,85) and isColor(1825,49,0x633c2b,85) and isColor(1846,47,0x5e3b28,85) and isColor(1852,47,0xfff7e5,85) and isColor(1852,41,0xfff7e5,85) and isColor(1852,47,0xfff7e5,85) and isColor(1852,50,0xfff7e5,85) and isColor(1852,54,0xfff7e5,85) and isColor(1855,55,0x1e1d0f,85) then
		click(1822,53)
	end
end

function confirm_island()
	if isColor(1142,665,0xf0c34e,85) and isColor(1150,665,0x773f07,85) and isColor(1153,671,0xb3802a,85) and isColor(1156,674,0x733b05,85) and isColor(1161,676,0xe0b245,85) and isColor(1162,679,0x733b05,85) and isColor(1163,683,0xe3b546,85) and isColor(1166,685,0x733b05,85) then
		click(1146,673)
		return true
	end
end

function go_next_map_island()
	click(1783,857)
	mSleep(1000)
	if confirm_island() then
		return true
	end
	click(1628,383)
	mSleep(1000)
	if confirm_island() then
		return true
	end
	click(1349,791)
	mSleep(1000)
	if confirm_island() then
		return true
	end
	click(1169,436)
	mSleep(1000)
	if confirm_island() then
		return true
	end
	click(878,865)
	mSleep(1000)
	if confirm_island() then
		return true
	end
	return false
end

function go_next_map()
	rc = false
	if isColor(1464,629,0xf82e4f,85) then
		rc = true
	else
		mSleep(500)
		if isColor(1464,629,0xf82e4f,85) then
			rc = true
		else
			mSleep(500)
			if isColor(1464,629,0xf82e4f,85) then
				rc = true
			end
		end
	end
	if rc then
		click(1349,651)
		--select island
		mSleep(5000)
		go_next_map_island()
		return true
	else
		return false
	end
end

function pass_dungeon()
	while true do
		if isColor(915,638,0xffd76b,85) and isColor(915,644,0x83513b,85) and isColor(915,652,0xffd76b,85) and isColor(915,660,0x83513b,85) and isColor(915,670,0xffd76b,85) and isColor(961,660,0xfbd369,85) and isColor(961,665,0x83513b,85) and isColor(984,665,0x83513b,85) and isColor(993,665,0xffd76b,85) then
			-- 通过
			mSleep(300)

			ok = 0

			rc = go_next_map()
			if rc then
				ok = 1
			else
				-- 中间点有绿
				r,g,b = getColorRGB(1044,891);
				if r<0x30 then
					click(1260,891)
					mSleep(1000)
					click(960,930)
					ok = 1
				end

				r,g,b = getColorRGB(482,891);
				if r<0x30 then
					click(688,891)
					mSleep(1000)
					click(960,930)
					ok = 1
				end
				r,g,b = getColorRGB(763,891);
				if r<0x30 then
					click(973,891)
					mSleep(1000)
					click(960,930)
					ok = 1
				end
				r,g,b = getColorRGB(1325,891);
				if r<0x30 then
					click(1532,891)
					mSleep(1000)
					click(960,930)
					ok = 1
				end
				ok = 0
			end

			if ok == 1 then
				mSleep(12000)
				click(949,653)
			end
		end
		mSleep(2000)
		select_hero()

		speedx2()

		if isColor(922,867,0xf6c951,85) and isColor(930,872,0x733b05,85) and isColor(932,877,0xf1c44e,85) and isColor(940,878,0x763e07,85) and isColor(943,884,0xe2b346,85) and isColor(948,887,0x733b05,85) and isColor(952,891,0xf3c54f,85) and isColor(962,891,0xf6c951,85) then
			-- 打完确定
			mSleep(2000)
			if isColor(965,551,0xd81f15,85) and isColor(974,549,0xfde60f,85) and isColor(974,553,0xfff112,85) and isColor(974,566,0x1f1811,85) and isColor(976,577,0xfde60e,85) and isColor(986,587,0xb4acb6,85) and isColor(999,606,0x539816,85) then
				toast("失败换下一个号",1)
--				playAudio("/sdcard/Download/10620.mp3")
--				mSleep(5000)
--				stopAudio()
				return true
			end
			click(960,890)
		end

		if isColor(930,648,0x7e2700,85) and isColor(930,657,0x7e2700,85) and isColor(930,658,0x7e2700,85) and isColor(945,654,0x7e2700,85) and isColor(948,666,0x7e2700,85) and isColor(955,673,0x7e2700,85) then
			click(958,660)
		end

	end
end




function find_marauder()

	-- click friend icon
	click(64,668)
	mSleep(2000)
	-- click friend tab
	click(1596,833)
	mSleep(2000)

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

	mSleep(4000)

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
		if account_num== 2029 then
			break
		end
		account_num = account_num + 1
	end
end

function all_pass_dungeon()
	while true do
		change_account()

		while true do
			if is_mainpage() then
				break
			end
			mSleep(2000)
		end

		move_to_left()

		click(1914,533)
		mSleep(1500)
		rc = pass_dungeon()
		if rc then
			back_mainpage()
			account_num = account_num + 1
		end

		if account_num== 2029 then
			break
		end
	end
end

function get_email()
	click(74,526)
	mSleep(2000)
	click(507,194)
	mSleep(2000)
	click(802,194)
	mSleep(2000)
	click(1124,688)
end

function daily_signup()
	click(1652,90)
	mSleep(2000)
	for i=5,1,-1 do
		click(1626,884)
		mSleep(1000)
	end
end

function buy_purple_ball()
	moveTo(545,600,1212,630)
	mSleep(1000)
	click(723,910)
	mSleep(3000)

	current_time = os.date("%m-%d-%H:%M:%S", os.time()); --以时间戳命名进行截图
	file_name = "/sdcard/log/"..current_time..".png"
	wLog("test","init pic"..file_name)
	os.execute("screencap -p "..file_name)
	mSleep(3000)

	out = choose_to_buy(file_name, "purple_ball")
	wLog("test", "arena out is "..out)
	buy_cycle(out, false)

	out = choose_to_buy(file_name, "casino")
	wLog("test", "casino out is "..out)
	buy_cycle(out, true)

	x,y = findMultiColorInRegionFuzzy( 0x92df19, "15|3|0x90de19,89|5|0x206b01,103|9|0x1d6700,105|23|0x1e6700,102|22|0x6cb912,133|1|0x206a01,139|9|0x86d518,150|14|0x1d6700", 90, 1300, 348, 1612, 454)
	if x~=-1 then
		wLog("test","可以刷新");
		click(1454, 403)
		mSleep(3000)
	end
end

function all_farm()
	while true do
		change_account()

		while true do
			if is_mainpage() then
				break
			end
			mSleep(2000)
		end

		move_to_left()

		click(1914,533)
		mSleep(1500)

		back_mainpage()

		get_email()
		back_mainpage()

		daily_signup()
		back_mainpage()

		buy_purple_ball()
		back_mainpage()
		
		move_to_left()
		click(1331,250)
		mSleep(4000)
		click(1048,646)
		mSleep(1000)
		back_mainpage()
		


		if account_num== 2029 then
			break
		end
		account_num = account_num + 1
	end
end

function all_manual()
	while true do
		change_account()
		while true do
			x,y = findMultiColorInRegionFuzzy( 0xbfec7c, "2|-3|0xfdfdfe,15|-1|0x49941b,22|1|0x116d22,12|26|0xfabe12,42|4|0x48261e", 90, 953, 22, 1030, 101)
			if x~=-1 then
				back_mainpage()
				break
			end
			mSleep(2000)
		end
		if account_num== 2029 then
			break
		end
		account_num = account_num + 1
		mSleep(2000)
	end
end

--init(app_name,1);
--all_pass_dungeon()
--main()