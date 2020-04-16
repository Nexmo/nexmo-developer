---
title: Kotlin
language: kotlin
---

```kotlin
// Here, thisActivity is the current activity
if (ContextCompat.checkSelfPermission(thisActivity, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
    ActivityCompat.requestPermissions(thisActivity, arrayOf(Manifest.permission.RECORD_AUDIO), 123)
}
```
