---
title: Kotlin
navigation_weight: 0
---

```Kotlin
var callEventListener = FinishOnCallEnd(this)

override fun onCreate(savedInstanceState: Bundle?) {
    //...
    currentCall?.addCallEventListener(callEventListener)
}


 override fun onDestroy() {
    currentCall?.removeCallEventListener(callEventListener)
    super.onDestroy()
}

```