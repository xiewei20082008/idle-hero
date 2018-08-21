file="launcher"
adb push $file /sdcard/go/$file
adb shell "su -c mv /sdcard/go/$file /data/go/$file" 
adb shell "su -c chmod a+x /data/go/$file"
