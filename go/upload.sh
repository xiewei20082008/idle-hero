adb push market /sdcard/go/market
adb shell "su -c mv /sdcard/go/market /data/go/market" 
adb shell "su -c chmod a+x /data/go/market"
