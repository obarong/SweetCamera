[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![platform](https://img.shields.io/badge/platform-Android-yellow.svg)](https://www.android.com)
[![API](https://img.shields.io/badge/API-14%2B-brightgreen.svg?style=flat)](https://android-arsenal.com/api?level=9)
[![PRs Welcome](https://img.shields.io/badge/prs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Code Climate](https://img.shields.io/codeclimate/issues/github/me-and/mdf.svg)](https://github.com/WellerV/SweetCamera/issues)

**SweetCamera**主要是为了解决兼容android各种机型的相机自动对焦的问题的项目，这里采用了基于传感器的方案，希望能够帮助您解决自动对焦问题。
详细可以看[博客][1]。
![enter description here][3]
## Preview：
![效果图][2]

## Core Code
具体原理是根据传感器来判断手机的运动状态，如果手机从静止状态变成运行状态后再次进入静止状态，此时就是手机的对焦时机。
通过传感器方式来触发对焦，可以兼容几乎所有拥有传感器的手机的对焦问题。
```java
    if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
            int x = (int) event.values[0];
            int y = (int) event.values[1];
            int z = (int) event.values[2];
            mCalendar = Calendar.getInstance();
            long stamp = mCalendar.getTimeInMillis();

            int second = mCalendar.get(Calendar.SECOND);

            if (STATUE != STATUS_NONE) {
                int px = Math.abs(mX - x);
                int py = Math.abs(mY - y);
                int pz = Math.abs(mZ - z);

                double value = Math.sqrt(px * px + py * py + pz * pz);
                if (value > 1.4) {
                    STATUE = STATUS_MOVE;
                } else {
                    //上一次状态是move，记录静态时间点
                    if (STATUE == STATUS_MOVE) {
                        lastStaticStamp = stamp;
                        canFocusIn = true;
                    }

                    if (canFocusIn) {
                        if (stamp - lastStaticStamp > DELEY_DURATION) {
                            //移动后静止一段时间，可以发生对焦行为
                            if (!isFocusing) {
                                canFocusIn = false;
                                if (mCameraFocusListener != null) {
                                    mCameraFocusListener.onFocus();
                                }
                            }
                        }
                    }

                    STATUE = STATUS_STATIC;
                }
            } else {
                lastStaticStamp = stamp;
                STATUE = STATUS_STATIC;
            }

            mX = x;
            mY = y;
            mZ = z;
        }
```

## End
如果你觉得不错, 对你有帮助, 欢迎点个 fork, star, follow , 也可以帮忙分享给你更多的朋友, 这是给作者最大的动力与支持。

  [1]: http://blog.csdn.net/huweigoodboy/article/details/51378751
  [2]: http://on8vjlgub.bkt.clouddn.com/cameraPreview.png "cameraPreview"
  [3]: http://on8vjlgub.bkt.clouddn.com/%E6%B7%B1%E5%BA%A6%E6%88%AA%E5%9B%BE20171103003702.png "原理图"
