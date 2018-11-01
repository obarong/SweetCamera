#!/bin/sh
APK_NAME="SweetCamera"
echo "remove ${APK_NAME}.apk~~~~~~"
adb remount
adb shell rm system/app/${APK_NAME}.apk