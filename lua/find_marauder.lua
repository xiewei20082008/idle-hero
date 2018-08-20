require("helper")


account_num = 2001

function get_username()
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

function find_marauder()

	-- click friend icon
	click(64,668)
	mSleep(1000)
	-- click friend tab
	click(1596,833)
	mSleep(1000)
	-- click search
	click(970,872)
	-- if find 确定
	-- screencap
	-- break

	mSleep(2000)

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
		account_num = account_num + 1
		if account_num== 2019 then
			break
		end
	end
end

init(app_name,1);
main()