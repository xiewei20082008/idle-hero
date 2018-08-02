adb push test /sdcard/go/test
adb shell "su -c mv /sdcard/go/test /data/go/test" 
adb shell "su -c chmod a+x /data/go/test"
