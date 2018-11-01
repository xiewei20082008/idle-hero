require("helper")


now_friend=0
need_friend = 10

function get_username(account_num)
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

function change_account(account_num)
	start_time = os.time()
	while true do
		if timeout(start_time, 2) then
			wLog("test","change account timeout")
			return false
		end

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
			inputText(get_username(account_num))
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
			return true
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

--	click(565,259)
--	mSleep(1500)
--	for var = 1,12 do
--		inputText("\b")       --删除输入框中的文字（假设输入框中已存在文字）
--	end
--	inputText("16216808")
--	mSleep(800)
--	click(1271,265)

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

function find_marauder_loop(account_num)

	while true do

		rc = change_account(account_num)
		if rc==false then
			return false
		end
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
		if account_num==2029 then
			return true
		end
		account_num = account_num + 1
		shell_run("echo "..account_num.." > /sdcard/log/aa.txt")
	end
end

function all_pass_dungeon(account_num)
	while true do
		change_account(account_num)

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
	while true do 
		click(1626,884)
		mSleep(500)
		if isColor(1567,886,0xababab,90) then
			break
		end
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

function island_clear()
	--拿金币
	move_to_left()
	click(1331,250)
	mSleep(4000)
	click(1048,646)
	mSleep(2000)
	click(758,470)
	mSleep(2000)
	--	飞TING
	click(555,853)
	mSleep(4000)
	--点虚空之巢
	click(653,286)
	mSleep(2000)
	click(606,816)
	mSleep(2000)

	for var = 1,15 do
		click(1169,504)
		mSleep(300)
	end
	click(956,748)
	mSleep(2000)
	--	选个英雄
	click(177,971)
	mSleep(1000)
	click(1517,446)
end

function nation_day_signup()
	click(1478,89)
	mSleep(2000)
	while true do
		if isColor(410,472,0x8c5d2f,90) and isColor(418,474,0xe5d7c5,90) and isColor(420,479,0xf1e7d9,90) and isColor(432,482,0x753d08,90) and isColor(437,483,0xf5e6d2,90) and isColor(446,485,0x733b05,90) and isColor(453,488,0xf4ebdd,90) and isColor(461,488,0x733b05,90) then
			click(447,505)
			mSleep(1000)
		end
		if isColor(926,681,0xf6c951,90) and isColor(935,683,0x733b05,90) and isColor(938,687,0xf4c750,90) and isColor(942,688,0x733b05,90) and isColor(946,692,0xf0c34e,90) and isColor(949,695,0x733b05,90) and isColor(953,698,0xf4c850,90) then
			click(963,694)
			mSleep(1000)
		end

		if isColor(1565,868,0x8ad919,90) and isColor(1573,890,0x8ad919,90) and isColor(1599,904,0x8ad919,90) and isColor(1688,880,0x8ad919,90) and isColor(1686,902,0x8ad919,90) and isColor(1713,875,0x8ad919,90) then
			click(1622,881)
			mSleep(1000)
		end
		if isColor(1604,864,0xababab,90) and isColor(1611,876,0x464646,90) and isColor(1612,879,0xababab,90) and isColor(1615,880,0x464646,90) and isColor(1622,886,0xababab,90) and isColor(1631,887,0xababab,90) and isColor(1638,889,0x464646,90) then
			return true
		end
		mSleep(2000)
	end
end


function all_farm(account_num)
	while true do
		change_account(account_num)

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

		island_clear()
		back_mainpage()

		--nation_day_signup()
		--back_mainpage()

		if account_num== 2029 then
			break
		end
		account_num = account_num + 1
	end
end

function all_manual(account_num)
	while true do
		change_account(account_num)
		while true do
			if isColor(929,249,0xf3ebdb,90) and isColor(931,253,0x946242,90) and isColor(936,256,0xf2ead9,90) and isColor(935,260,0x956344,90) and isColor(937,264,0xf0e7d6,90) and isColor(854,333,0xf0e4ce,90) and isColor(824,346,0x61342a,90) and isColor(791,400,0xd25547,90) and isColor(496,400,0xd25547,90) then

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
