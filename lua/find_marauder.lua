require("helper")


account_num = 1990

function get_username()
    return "tianshi"..account_num.."@163.com"

function get_password()
    return "123456qw"

function change_account()
    while true do
        if is_mainpage() then
            -- click at settings
            mSleep(2000)
            -- click at change account
            mSleep(2000)
            switchTSInputMethod(true)
            -- click at user name
            mSleep(200)
            inputText(get_username)
            mSleep(200)
            -- click at password
            mSleep(200)
            inputText(get_password)
            mSleep(200)
            switchTSInputMethod(false)
            mSleep(200)
            -- click at login
            break
        end
        mSleep(2000)
    end
end

function find_marauder()
    while true do
        -- click friend icon
        -- click friend tab
        -- click search
        -- if find 确定
            -- screencap
            -- break

        mSleep(2000)
    end
end

function main()
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
end

main()