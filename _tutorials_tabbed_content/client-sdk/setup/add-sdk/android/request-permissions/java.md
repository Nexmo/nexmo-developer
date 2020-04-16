---
title: Java
language: java
---

```java
// Here, thisActivity is the current activity
if (ContextCompat.checkSelfPermission(thisActivity, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
    ActivityCompat.requestPermissions(thisActivity, new String[]{Manifest.permission.RECORD_AUDIO}, 123);
}
```
