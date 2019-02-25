---
title: Java
navigation_weight: 1
---

```java
NexmoCallEventListener callEventListener = new FinishOnCallEnd(this);

@Override
protected void onCreate(@Nullable Bundle savedInstanceState) {
    NexmoHelper.currentCall.addCallEventListener(callEventListener);
}


@Override
protected void onDestroy() {
    NexmoHelper.currentCall.removeCallEventListener(callEventListener);
    super.onDestroy();
}
```
