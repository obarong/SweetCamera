#!/bin/sh
APK_NAME="SweetCamera"
echo "push ${APK_NAME}.apk~~~~~~"
adb remount
adb push ../app/build/outputs/apk/${APK_NAME}.apk system/app
